import 'package:file_picker/file_picker.dart';
import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/core/utils/upload_validation.dart';
import 'package:rafiq_alhajj/features/operator_intake/data/data_sources/pilgrim_intake_remote_data_source.dart';
import 'package:rafiq_alhajj/features/operator_intake/domain/models/created_pilgrim_account.dart';
import 'package:rafiq_alhajj/features/operator_intake/domain/models/pilgrim_import_models.dart';
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

  /// Hard cap per uploaded document and the allowed file types (shared
  /// [UploadConstraints]). Enforced client-side; storage RLS guards the bucket.
  static const _constraints = UploadConstraints.pilgrimDocuments;

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

  /// Sends parsed [rows] to the `import-pilgrims` edge function (server-side
  /// upsert by passport). Returns a per-row outcome summary.
  Future<PilgrimImportResult> importPilgrims({
    required List<Map<String, dynamic>> rows,
    String? tripId,
    String? groupId,
  }) async {
    if (!isAvailable) {
      throw const PilgrimIntakeException('Supabase is not configured');
    }

    try {
      final response = await _remote!.importPilgrims({
        'rows': rows,
        'trip_id': ?tripId,
        'group_id': ?groupId,
      });

      if (response.status != 200) {
        final error = response.data is Map
            ? (response.data as Map)['error']?.toString()
            : null;
        throw PilgrimIntakeException(error ?? 'Failed to import pilgrims');
      }

      final data = Map<String, dynamic>.from(response.data as Map);
      return PilgrimImportResult(
        created: (data['created'] as num?)?.toInt() ?? 0,
        updated: (data['updated'] as num?)?.toInt() ?? 0,
        failed: (data['failed'] as num?)?.toInt() ?? 0,
        errors: (data['errors'] as List?)
                ?.map((e) => e.toString())
                .toList(growable: false) ??
            const [],
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
      if (extension == null ||
          !_constraints.allowedExtensions.contains(extension)) {
        failures.add(file.name);
        continue;
      }
      if (bytes.length > _constraints.maxBytes) {
        failures.add(file.name);
        continue;
      }

      final safeName = sanitizeUploadFileName(file.name);
      final storagePath =
          '$profileId/${DateTime.now().millisecondsSinceEpoch}_$safeName';

      try {
        await remote.uploadDocument(
          storagePath: storagePath,
          bytes: bytes,
          contentType: mimeFromExtension(extension),
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
}
