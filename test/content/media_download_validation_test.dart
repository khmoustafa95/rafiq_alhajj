import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rafiq_alhajj/features/content/application/services/media_content_url_rules.dart';
import 'package:rafiq_alhajj/features/content/application/services/media_download_coordinator.dart';

void main() {
  group('validateDownload', () {
    late Directory tempDir;

    setUp(() async {
      tempDir = await Directory.systemTemp.createTemp('media_download_test_');
    });

    tearDown(() async {
      if (tempDir.existsSync()) {
        await tempDir.delete(recursive: true);
      }
    });

    Response<dynamic> responseWithContentType(String contentType) {
      return Response<dynamic>(
        requestOptions: RequestOptions(path: '/media'),
        headers: Headers.fromMap({
          Headers.contentTypeHeader: [contentType],
        }),
      );
    }

    test('accepts valid mp4 payload', () async {
      final file = File('${tempDir.path}/video.mp4');
      await file.writeAsBytes(List<int>.filled(1024, 1));

      expect(
        () => validateDownload(responseWithContentType('video/mp4'), file),
        returnsNormally,
      );
    });

    test('rejects html landing pages', () async {
      final file = File('${tempDir.path}/fake.mp4');
      await file.writeAsBytes('<html></html>'.codeUnits);

      expect(
        () => validateDownload(responseWithContentType('text/html'), file),
        throwsA(isA<MediaCacheException>()),
      );
    });

    test('rejects empty downloads', () async {
      final file = File('${tempDir.path}/empty.mp4');
      await file.create();

      expect(
        () => validateDownload(responseWithContentType('video/mp4'), file),
        throwsA(isA<MediaCacheException>()),
      );
    });

    test('rejects oversize downloads', () async {
      final file = File('${tempDir.path}/huge.mp4');
      await file.writeAsBytes(
        List<int>.filled(MediaDownloadCoordinator.maxDownloadBytes + 1, 1),
      );

      expect(
        () => validateDownload(responseWithContentType('video/mp4'), file),
        throwsA(isA<MediaCacheException>()),
      );
    });
  });

  group('ContentMediaUrlRules', () {
    test('allows private refs and direct http urls', () {
      expect(ContentMediaUrlRules.isCacheable('private://topic/video.mp4'), isTrue);
      expect(
        ContentMediaUrlRules.isCacheable('https://cdn.example.com/a.mp4'),
        isTrue,
      );
    });

    test('skips youtube, vimeo, and empty urls', () {
      expect(
        ContentMediaUrlRules.isCacheable('https://www.youtube.com/watch?v=abc'),
        isFalse,
      );
      expect(
        ContentMediaUrlRules.isCacheable('https://vimeo.com/123'),
        isFalse,
      );
      expect(ContentMediaUrlRules.isCacheable(''), isFalse);
    });
  });
}
