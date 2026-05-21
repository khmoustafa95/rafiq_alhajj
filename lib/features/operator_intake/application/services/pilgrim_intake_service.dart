import 'package:file_picker/file_picker.dart';
import 'package:rafiq_alhajj/core/config/app_config.dart';
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
  PilgrimIntakeService(this._client);

  final SupabaseClient? _client;

  bool get isAvailable => AppConfig.hasSupabase && _client != null;

  Future<CreatedPilgrimAccount> registerPilgrim(PilgrimIntakeForm form) async {
    if (!isAvailable) {
      throw const PilgrimIntakeException('Supabase is not configured');
    }

    try {
      final response = await _client!.functions.invoke(
        'create-pilgrim',
        body: {
          'email': form.email.trim(),
          'full_name': form.fullName.trim(),
          'passport_number': form.passportNumber,
          'travel_permit_number': form.travelPermitNumber,
          'medical_test_status': form.medicalTestStatus,
          'travel_date': form.travelDate?.toIso8601String().split('T').first,
          'hotel_name': form.hotelName,
          'hotel_location_url': form.hotelLocationUrl,
          'transportation_details': form.transportationDetails,
        },
      );

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
    } catch (e) {
      throw PilgrimIntakeException(e.toString());
    }
  }

  Future<int> uploadDocuments({
    required String profileId,
    required String operatorId,
    required List<PlatformFile> files,
  }) async {
    if (!isAvailable || files.isEmpty) {
      return 0;
    }

    var uploaded = 0;
    for (final file in files) {
      if (file.bytes == null) {
        continue;
      }

      final safeName = file.name.replaceAll(RegExp(r'[^\w.\-]'), '_');
      final storagePath = '$profileId/${DateTime.now().millisecondsSinceEpoch}_$safeName';

      await _client!.storage.from('pilgrim-documents').uploadBinary(
            storagePath,
            file.bytes!,
            fileOptions: FileOptions(
              contentType: file.extension != null
                  ? _mimeFromExtension(file.extension!)
                  : null,
            ),
          );

      await _client.from('pilgrim_documents').insert({
        'profile_id': profileId,
        'file_name': file.name,
        'storage_path': storagePath,
        'document_type': file.extension,
        'uploaded_by': operatorId,
      });

      uploaded++;
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
