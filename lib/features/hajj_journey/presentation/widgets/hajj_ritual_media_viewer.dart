import 'package:flutter/material.dart';
import 'package:rafiq_alhajj/core/domain/models/educational_media.dart';
import 'package:rafiq_alhajj/core/widgets/educational_media_viewer.dart';
import 'package:rafiq_alhajj/features/hajj_journey/domain/models/hajj_journey_media.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class HajjRitualMediaViewer extends StatelessWidget {
  const HajjRitualMediaViewer({
    required this.media,
    super.key,
  });

  final List<HajjJourneyMedia> media;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return EducationalMediaViewer(
      media: media.map(_toEducationalMedia).toList(),
      sectionTitle: l10n.hajjJourneyMediaTitle,
      emptyMessage: l10n.hajjJourneyNoMedia,
    );
  }

  EducationalMediaItem _toEducationalMedia(HajjJourneyMedia item) {
    return EducationalMediaItem(
      id: item.id,
      mediaType: switch (item.mediaType) {
        HajjMediaType.video => EducationalMediaType.video,
        HajjMediaType.audio => EducationalMediaType.audio,
        HajjMediaType.image => EducationalMediaType.image,
      },
      title: item.title,
      url: item.url,
      sortOrder: item.sortOrder,
    );
  }
}
