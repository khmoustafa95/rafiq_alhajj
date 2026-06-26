import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

/// A labelled progress bar shown while a media file is compressing or uploading.
///
/// [progress] is `0.0`–`1.0`, or `null` for an indeterminate bar. When
/// [compressing] is true the label reflects the on-device compression phase.
class UploadProgressBanner extends StatelessWidget {
  const UploadProgressBanner({
    required this.progress,
    this.compressing = false,
    super.key,
  });

  final double? progress;
  final bool compressing;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final percent = ((progress ?? 0) * 100).round();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          compressing
              ? l10n.mediaCompressing(percent)
              : l10n.uploadInProgress(percent),
          style: Theme.of(context).textTheme.bodySmall,
        ),
        SizedBox(height: 6.h),
        ClipRRect(
          borderRadius: BorderRadius.circular(8.r),
          child: LinearProgressIndicator(value: progress),
        ),
      ],
    );
  }
}
