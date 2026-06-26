import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:cryptography/cryptography.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Encrypts offline media at rest with AES-CTR using a random 256-bit key kept
/// in the platform secure store (Keychain / Keystore-backed EncryptedSharedPrefs).
///
/// AES-CTR is a streaming cipher: by passing `keyStreamIndex` per chunk we can
/// encrypt/decrypt large files (videos up to the 45 MiB upload cap) in bounded
/// 1 MiB chunks without ever holding the whole plaintext in memory. The key is
/// bound to the device (`first_unlock_this_device` on iOS, EncryptedSharedPrefs
/// on Android), so any backed-up ciphertext is useless off-device.
class MediaEncryptionService {
  MediaEncryptionService({FlutterSecureStorage? secureStorage})
      : _secureStorage = secureStorage ??
            const FlutterSecureStorage(
              // Device-bound key: never synced to iCloud/cloud backup, so any
              // backed-up ciphertext is useless off-device.
              iOptions: IOSOptions(
                accessibility: KeychainAccessibility.first_unlock_this_device,
              ),
            );

  static const _keyStorageKey = 'content_media_aes_key_v1';
  static const _chunkSize = 1024 * 1024; // 1 MiB (multiple of AES block size)

  final FlutterSecureStorage _secureStorage;
  final AesCtr _algorithm = AesCtr.with256bits(macAlgorithm: MacAlgorithm.empty);
  final Random _random = Random.secure();

  SecretKey? _cachedKey;

  Future<SecretKey> _key() async {
    final cached = _cachedKey;
    if (cached != null) {
      return cached;
    }
    final existing = await _secureStorage.read(key: _keyStorageKey);
    if (existing != null && existing.isNotEmpty) {
      final key = SecretKey(base64Decode(existing));
      _cachedKey = key;
      return key;
    }
    final generated = await _algorithm.newSecretKey();
    final bytes = await generated.extractBytes();
    await _secureStorage.write(key: _keyStorageKey, value: base64Encode(bytes));
    final key = SecretKey(bytes);
    _cachedKey = key;
    return key;
  }

  /// A fresh random 16-byte nonce (initial counter block) for a single file.
  Uint8List newNonce() {
    final nonce = Uint8List(16);
    for (var i = 0; i < nonce.length; i++) {
      nonce[i] = _random.nextInt(256);
    }
    return nonce;
  }

  String encodeNonce(Uint8List nonce) => base64Encode(nonce);

  Uint8List decodeNonce(String value) =>
      Uint8List.fromList(base64Decode(value));

  /// Streams [src] -> [dst] encrypting in chunks with the given [nonce].
  Future<void> encryptFile({
    required File src,
    required File dst,
    required Uint8List nonce,
  }) =>
      _transform(src: src, dst: dst, nonce: nonce, encrypt: true);

  /// Streams [src] (ciphertext) -> [dst] (plaintext) decrypting in chunks.
  Future<void> decryptFile({
    required File src,
    required File dst,
    required Uint8List nonce,
  }) =>
      _transform(src: src, dst: dst, nonce: nonce, encrypt: false);

  Future<void> _transform({
    required File src,
    required File dst,
    required Uint8List nonce,
    required bool encrypt,
  }) async {
    final key = await _key();
    final reader = await src.open();
    final sink = dst.openWrite();
    var offset = 0;
    try {
      while (true) {
        final chunk = await reader.read(_chunkSize);
        if (chunk.isEmpty) {
          break;
        }
        if (encrypt) {
          final box = await _algorithm.encrypt(
            chunk,
            secretKey: key,
            nonce: nonce,
            keyStreamIndex: offset,
          );
          sink.add(box.cipherText);
        } else {
          final box = SecretBox(chunk, nonce: nonce, mac: Mac.empty);
          final clear = await _algorithm.decrypt(
            box,
            secretKey: key,
            keyStreamIndex: offset,
          );
          sink.add(clear);
        }
        offset += chunk.length;
      }
    } finally {
      await reader.close();
      await sink.close();
    }
  }

  /// Rotates the encryption key (e.g. on logout) so any leftover ciphertext can
  /// never be decrypted again.
  Future<void> wipeKey() async {
    _cachedKey = null;
    await _secureStorage.delete(key: _keyStorageKey);
  }
}
