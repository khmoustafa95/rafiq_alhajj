import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/features/hajj_journey/domain/models/hajj_journey_media.dart';
import 'package:rafiq_alhajj/features/hajj_journey/presentation/forms/journey_media_form.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';
import 'package:reactive_forms/reactive_forms.dart';

class AdminJourneyMediaDraftCard extends StatelessWidget {
  const AdminJourneyMediaDraftCard({
    required this.mediaGroup,
    required this.onRemove,
    required this.mediaTypeLabel,
    required this.l10n,
    super.key,
  });

  final FormGroup mediaGroup;
  final VoidCallback onRemove;
  final String Function(HajjMediaType type) mediaTypeLabel;
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
              ReactiveDropdownField<HajjMediaType>(
                formControlName: JourneyMediaForm.mediaTypeControl,
                decoration: InputDecoration(
                  labelText: l10n.adminHajjJourneyMediaType,
                ),
                items: HajjMediaType.values
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
                formControlName: JourneyMediaForm.titleControl,
                decoration: InputDecoration(
                  labelText: l10n.adminHajjJourneyMediaTitle,
                ),
              ),
              SizedBox(height: 8.h),
              ReactiveTextField<String>(
                formControlName: JourneyMediaForm.urlControl,
                decoration: InputDecoration(
                  labelText: l10n.adminHajjJourneyMediaUrl,
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
