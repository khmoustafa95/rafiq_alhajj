import 'package:file_picker/file_picker.dart';
import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/features/operator_intake/data/data_sources/pilgrim_intake_remote_data_source.dart';
import 'package:rafiq_alhajj/features/operator_intake/domain/models/created_pilgrim_account.dart';
import 'package:rafiq_alhajj/features/operator_intake/domain/models/pilgrim_intake_form.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PilgrimIntakeException implements Exception {
  const PilgrimIntakeException(this.message);

  final String message;

  @override
  String toString() => message;
}

class PilgrimIntakeService {
  PilgrimIntakeService([SupabaseClient? client])
      : _remote =
            client == null ? null : PilgrimIntakeRemoteDataSource(client);

  final PilgrimIntakeRemoteDataSource? _remote;

  /// Hard cap per uploaded document (10 MB) and the allowed file types. These
  /// are enforced client-side; storage RLS additionally restricts the bucket.
  static const _maxFileBytes = 10 * 1024 * 1024;
  static const _allowedExtensions = {'pdf', 'jpg', 'jpeg', 'png'};

  bool get isAvailable => AppConfig.hasSupabase && _remote != null;

  Future<CreatedPilgrimAccount> registerPilgrim(PilgrimIntakeForm form) async {
    if (!isAvailable) {
      throw const PilgrimIntakeException('Supabase is not configured');
    }

    try {
      final response = await _remote!.createPilgrim({
        'email': form.email.trim(),
        'full_name': form.fullName.trim(),
        if (form.tripId != null) 'trip_id': form.tripId,
        if (form.groupId != null) 'group_id': form.groupId,
        'person': form.person,
        'enrollment': form.enrollment,
      });

      if (response.status != 200) {
        final error = response.data is Map
            ? (response.data as Map)['error']?.toString()
            : null;
        throw PilgrimIntakeException(error ?? 'Failed to create pilgrim account');
      }

      final data = Map<String, dynamic>.from(response.data as Map);

      return CreatedPilgrimAccount(
        profileId: data['profile_id'] as String,
        email: data['email'] as String,
        password: data['password'] as String,
      );
    } on PilgrimIntakeException {
      rethrow;
    } on FunctionException catch (e) {
      throw PilgrimIntakeException(e.reasonPhrase ?? 'Edge function error');
    } on PostgrestException catch (e) {
      throw PilgrimIntakeException(e.message);
    }
  }

  /// Uploads picked documents. Returns the number successfully uploaded.
  ///
  /// Best-effort: each valid file is uploaded independently; invalid or failed
  /// files are collected and surfaced via [PilgrimIntakeException] after the
  /// valid ones are stored, so a partial failure never blocks the others.
  Future<int> uploadDocuments({
    required String profileId,
    required String operatorId,
    required List<PlatformFile> files,
  }) async {
    if (!isAvailable || files.isEmpty) {
      return 0;
    }
    final remote = _remote!;

    var uploaded = 0;
    final failures = <String>[];

    for (final file in files) {
      final bytes = file.bytes;
      final extension = file.extension?.toLowerCase();

      if (bytes == null) {
        failures.add(file.name);
        continue;
      }
      if (extension == null || !_allowedExtensions.contains(extension)) {
        failures.add(file.name);
        continue;
      }
      if (bytes.length > _maxFileBytes) {
        failures.add(file.name);
        continue;
      }

      final safeName = file.name.replaceAll(RegExp(r'[^\w.\-]'), '_');
      final storagePath =
          '$profileId/${DateTime.now().millisecondsSinceEpoch}_$safeName';

      try {
        await remote.uploadDocument(
          storagePath: storagePath,
          bytes: bytes,
          contentType: _mimeFromExtension(extension),
        );
        await remote.insertDocumentMetadata({
          'profile_id': profileId,
          'file_name': file.name,
          'storage_path': storagePath,
          'document_type': extension,
          'uploaded_by': operatorId,
        });
        uploaded++;
      } on StorageException {
        failures.add(file.name);
      } on PostgrestException {
        failures.add(file.name);
      }
    }

    if (failures.isNotEmpty) {
      throw PilgrimIntakeException(
        'Failed to upload: ${failures.join(', ')}',
      );
    }

    return uploaded;
  }

  String? _mimeFromExtension(String ext) {
    return switch (ext.toLowerCase()) {
      'pdf' => 'application/pdf',
      'jpg' || 'jpeg' => 'image/jpeg',
      'png' => 'image/png',
      _ => null,
    };
  }
}
