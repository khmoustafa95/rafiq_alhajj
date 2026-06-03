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
