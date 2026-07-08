import 'package:flutter_test/flutter_test.dart';
import 'package:rafiq_alhajj/core/utils/upload_validation.dart';

void main() {
  group('validateUpload', () {
    test('rejects empty payload', () {
      expect(
        () => validateUpload(
          fileName: 'photo.jpg',
          byteLength: 0,
          constraints: UploadConstraints.image,
        ),
        throwsA(isA<UploadValidationException>()),
      );
    });

    test('rejects unsupported extension', () {
      expect(
        () => validateUpload(
          fileName: 'virus.exe',
          byteLength: 100,
          constraints: UploadConstraints.image,
        ),
        throwsA(
          predicate<UploadValidationException>(
            (e) => e.reason == UploadRejectionReason.unsupportedType,
          ),
        ),
      );
    });

    test('rejects oversize file', () {
      expect(
        () => validateUpload(
          fileName: 'big.jpg',
          byteLength: UploadConstraints.image.maxBytes + 1,
          constraints: UploadConstraints.image,
        ),
        throwsA(
          predicate<UploadValidationException>(
            (e) => e.reason == UploadRejectionReason.tooLarge,
          ),
        ),
      );
    });

    test('accepts valid image', () {
      expect(
        () => validateUpload(
          fileName: 'cover.png',
          byteLength: 1024,
          constraints: UploadConstraints.image,
        ),
        returnsNormally,
      );
    });
  });

  group('fileExtension', () {
    test('returns lower-case extension', () {
      expect(fileExtension('photo.JPG'), 'jpg');
      expect(fileExtension('noext'), isNull);
    });
  });
}
