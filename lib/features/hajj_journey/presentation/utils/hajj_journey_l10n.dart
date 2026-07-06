import 'package:rafiq_alhajj/features/hajj_journey/domain/models/hajj_journey_media.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

String hajjMediaTypeLabel(AppLocalizations l10n, HajjMediaType type) {
  return switch (type) {
    HajjMediaType.video => l10n.hajjJourneyMediaVideo,
    HajjMediaType.audio => l10n.hajjJourneyMediaAudio,
    HajjMediaType.image => l10n.hajjJourneyMediaImage,
  };
}
