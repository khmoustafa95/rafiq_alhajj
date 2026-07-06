import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/core/domain/models/educational_media.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/features/admin_content/presentation/forms/topic_media_form.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';
import 'package:reactive_forms/reactive_forms.dart';

class AdminTopicMediaDraftCard extends StatelessWidget {
  const AdminTopicMediaDraftCard({
    required this.mediaGroup,
    required this.isBusy,
    required this.onUpload,
    required this.onRemove,
    required this.mediaTypeLabel,
    required this.l10n,
    super.key,
  });

  final FormGroup mediaGroup;
  final bool isBusy;
  final VoidCallback onUpload;
  final VoidCallback onRemove;
  final String Function(EducationalMediaType type) mediaTypeLabel;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return ReactiveForm(
      formGroup: mediaGroup,
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(12.w),
          child: Column(
            children: [
              ReactiveDropdownField<EducationalMediaType>(
                formControlName: TopicMediaForm.mediaTypeControl,
                decoration: InputDecoration(
                  labelText: l10n.adminHajjJourneyMediaType,
                ),
                items: EducationalMediaType.values
                    .map(
                      (type) => DropdownMenuItem(
                        value: type,
                        child: Text(mediaTypeLabel(type)),
                      ),
                    )
                    .toList(),
              ),
              SizedBox(height: 8.h),
              ReactiveTextField<String>(
                formControlName: TopicMediaForm.titleControl,
                decoration: InputDecoration(
                  labelText: l10n.adminHajjJourneyMediaTitle,
                ),
              ),
              SizedBox(height: 8.h),
              ReactiveTextField<String>(
                formControlName: TopicMediaForm.urlControl,
                decoration: InputDecoration(
                  labelText: l10n.adminHajjJourneyMediaUrl,
                ),
              ),
              SizedBox(height: 8.h),
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: OutlinedButton.icon(
                  onPressed: isBusy ? null : onUpload,
                  icon: const Icon(Icons.upload_file_outlined),
                  label: Text(l10n.adminContentTopicUploadMedia),
                ),
              ),
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: TextButton.icon(
                  onPressed: onRemove,
                  icon: const Icon(
                    Icons.delete_outline,
                    color: AppColors.error,
                  ),
                  label: Text(
                    l10n.adminHajjJourneyRemoveMedia,
                    style: const TextStyle(color: AppColors.error),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
