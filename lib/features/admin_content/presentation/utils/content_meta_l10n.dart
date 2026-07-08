import 'package:rafiq_alhajj/core/domain/models/educational_media.dart';
import 'package:rafiq_alhajj/core/utils/upload_validation.dart';
import 'package:rafiq_alhajj/features/content/data/storage/content_media_storage_service.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_type.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_visibility.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

String contentTypeLabel(AppLocalizations l10n, ContentType type) {
  return switch (type) {
    ContentType.video => l10n.adminContentTypeVideo,
    ContentType.news => l10n.adminContentTypeNews,
    ContentType.announcement => l10n.adminContentTypeAnnouncement,
  };
}

String contentVisibilityLabel(
  AppLocalizations l10n,
  ContentVisibility visibility,
) {
  return switch (visibility) {
    ContentVisibility.public => l10n.adminContentVisibilityPublic,
    ContentVisibility.pilgrimOnly => l10n.adminContentVisibilityPilgrimOnly,
  };
}

String educationalMediaTypeLabel(
  AppLocalizations l10n,
  EducationalMediaType type,
) {
  return switch (type) {
    EducationalMediaType.video => l10n.hajjJourneyMediaVideo,
    EducationalMediaType.audio => l10n.hajjJourneyMediaAudio,
    EducationalMediaType.image => l10n.hajjJourneyMediaImage,
    EducationalMediaType.pdf => l10n.contentMediaPdf,
  };
}

/// Maps an upload failure to a precise, localized message so the UI never shows
/// a generic "upload failed" that hides the real cause (size/type/permission).
String uploadErrorMessage(
  AppLocalizations l10n,
  Object error, {
  UploadConstraints? constraints,
}) {
  if (error is UploadValidationException) {
    return switch (error.reason) {
      UploadRejectionReason.tooLarge => l10n.uploadErrorTooLarge(
          (error.maxBytes ?? constraints?.maxBytes ?? 0) ~/ (1024 * 1024),
        ),
      UploadRejectionReason.unsupportedType => l10n.uploadErrorUnsupportedType(
          _allowedTypesLabel(constraints),
        ),
      UploadRejectionReason.emptyData => l10n.uploadErrorEmpty,
    };
  }
  if (error is ContentMediaStorageException && error.message != null) {
    return error.message!;
  }
  return l10n.adminContentTopicUploadError;
}

String _allowedTypesLabel(UploadConstraints? constraints) {
  if (constraints == null) {
    return '';
  }
  final extensions = constraints.allowedExtensions.toList()..sort();
  return extensions.join(', ');
}
