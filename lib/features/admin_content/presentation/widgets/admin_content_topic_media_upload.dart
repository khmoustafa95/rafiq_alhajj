import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rafiq_alhajj/core/domain/models/educational_media.dart';
import 'package:rafiq_alhajj/core/utils/file_pick_upload.dart';
import 'package:rafiq_alhajj/core/utils/upload_validation.dart';
import 'package:rafiq_alhajj/features/admin_content/presentation/utils/content_meta_l10n.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_visibility.dart';
import 'package:rafiq_alhajj/features/content/presentation/providers/content_media_providers.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

typedef TopicUploadProgressCallback = void Function({
  required bool isUploading,
  required bool isCompressing,
  required double? progress,
});

/// Pick, validate, and upload topic cover/media bytes for the admin editor.
abstract final class AdminContentTopicMediaUpload {
  static UploadConstraints constraintsFor(EducationalMediaType type) {
    return switch (type) {
      EducationalMediaType.video => UploadConstraints.video,
      EducationalMediaType.audio => UploadConstraints.audio,
      EducationalMediaType.image => UploadConstraints.image,
      EducationalMediaType.pdf => UploadConstraints.pdf,
    };
  }

  static UploadMediaKind kindFor(EducationalMediaType type) {
    return switch (type) {
      EducationalMediaType.video => UploadMediaKind.video,
      EducationalMediaType.audio => UploadMediaKind.audio,
      EducationalMediaType.image => UploadMediaKind.image,
      EducationalMediaType.pdf => UploadMediaKind.other,
    };
  }

  static Future<void> pickAndUpload({
    required BuildContext context,
    required WidgetRef ref,
    required ContentVisibility visibility,
    required String? topicId,
    required void Function(String url) onUploaded,
    required TopicUploadProgressCallback onProgress,
    required void Function(String message) showMessage,
    required String folder,
    required UploadConstraints constraints,
    required UploadMediaKind kind,
  }) async {
    final l10n = AppLocalizations.of(context);

    PickedUpload? picked;
    try {
      picked = await pickValidatedUpload(
        constraints,
        kind: kind,
        onCompressProgress: (progress) {
          onProgress(
            isUploading: true,
            isCompressing: true,
            progress: progress,
          );
        },
      );
    } on UploadValidationException catch (e) {
      onProgress(isUploading: false, isCompressing: false, progress: null);
      showMessage(uploadErrorMessage(l10n, e, constraints: constraints));
      return;
    }

    if (picked == null || !context.mounted) {
      onProgress(isUploading: false, isCompressing: false, progress: null);
      return;
    }

    onProgress(isUploading: true, isCompressing: false, progress: 0);

    final isPrivate = visibility == ContentVisibility.pilgrimOnly;

    try {
      final url = await ref.read(contentMediaStorageServiceProvider).uploadBytes(
            bytes: picked.bytes,
            fileName: picked.fileName,
            topicId: topicId,
            folder: folder,
            constraints: constraints,
            isPrivate: isPrivate,
            onProgress: (progress) {
              onProgress(
                isUploading: true,
                isCompressing: false,
                progress: progress,
              );
            },
          );
      onUploaded(url);
      if (context.mounted) {
        showMessage(l10n.adminContentTopicUploadSuccess);
      }
    } catch (e) {
      showMessage(uploadErrorMessage(l10n, e, constraints: constraints));
    } finally {
      onProgress(isUploading: false, isCompressing: false, progress: null);
    }
  }
}
