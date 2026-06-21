import 'dart:typed_data';

import 'package:supabase_flutter/supabase_flutter.dart';

/// Direct Supabase access for pilgrim intake: the `create-pilgrim` edge
/// function and the private `pilgrim-documents` storage bucket + metadata table.
///
/// Owns every [SupabaseClient] call and returns raw data; validation, mapping
/// and error handling live in [PilgrimIntakeService].
class PilgrimIntakeRemoteDataSource {
  const PilgrimIntakeRemoteDataSource(this._client);

  final SupabaseClient _client;

  static const _documentsBucket = 'pilgrim-documents';

  Future<FunctionResponse> createPilgrim(Map<String, dynamic> body) {
    return _client.functions.invoke('create-pilgrim', body: body);
  }

  Future<void> uploadDocument({
    required String storagePath,
    required Uint8List bytes,
    String? contentType,
  }) async {
    await _client.storage.from(_documentsBucket).uploadBinary(
          storagePath,
          bytes,
          fileOptions: FileOptions(contentType: contentType),
        );
  }

  Future<void> insertDocumentMetadata(Map<String, dynamic> payload) async {
    await _client.from('pilgrim_documents').insert(payload);
  }
}
