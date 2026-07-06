import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/features/hajj_journey/presentation/forms/journey_media_form.dart';
import 'package:rafiq_alhajj/features/hajj_journey/presentation/utils/hajj_journey_l10n.dart';
import 'package:rafiq_alhajj/features/hajj_journey/presentation/widgets/admin_journey_media_draft_card.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// Reactive form body for the admin Hajj journey step editor.
class AdminHajjJourneyEditForm extends StatelessWidget {
  const AdminHajjJourneyEditForm({
    required this.form,
    required this.isActive,
    required this.onActiveChanged,
    required this.onAddMedia,
    required this.onRemoveMedia,
    super.key,
  });

  final FormGroup form;
  final bool isActive;
  final ValueChanged<bool> onActiveChanged;
  final VoidCallback onAddMedia;
  final ValueChanged<int> onRemoveMedia;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final mediaArray = JourneyMediaForm.mediaArray(form);

    return ReactiveForm(
      formGroup: form,
      child: ListView(
        padding: EdgeInsets.all(16.w),
        children: [
          ReactiveTextField<String>(
            formControlName: 'titleAr',
            decoration: InputDecoration(
              labelText: l10n.adminHajjJourneyTitleAr,
            ),
          ),
          SizedBox(height: 12.h),
          ReactiveTextField<String>(
            formControlName: 'titleEn',
            decoration: InputDecoration(
              labelText: l10n.adminHajjJourneyTitleEn,
            ),
          ),
          SizedBox(height: 12.h),
          ReactiveTextField<String>(
            formControlName: 'descriptionAr',
            decoration: InputDecoration(
              labelText: l10n.adminHajjJourneyDescriptionAr,
            ),
            minLines: 4,
            maxLines: 8,
          ),
          SizedBox(height: 12.h),
          ReactiveTextField<String>(
            formControlName: 'descriptionEn',
            decoration: InputDecoration(
              labelText: l10n.adminHajjJourneyDescriptionEn,
            ),
            minLines: 4,
            maxLines: 8,
          ),
          SizedBox(height: 12.h),
          ReactiveTextField<String>(
            formControlName: 'sortOrder',
            decoration: InputDecoration(
              labelText: l10n.adminHajjJourneySortOrder,
            ),
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 8.h),
          SwitchListTile(
            value: isActive,
            onChanged: onActiveChanged,
            title: Text(l10n.adminHajjJourneyActive),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: Text(
                  l10n.adminHajjJourneyMediaSection,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Semantics(
                button: true,
                label: l10n.adminHajjJourneyMediaSection,
                child: IconButton(
                  onPressed: onAddMedia,
                  icon: const Icon(Icons.add_circle_outline),
                ),
              ),
            ],
          ),
          for (var i = 0; i < mediaArray.controls.length; i++) ...[
            AdminJourneyMediaDraftCard(
              mediaGroup: mediaArray.controls[i] as FormGroup,
              onRemove: () => onRemoveMedia(i),
              mediaTypeLabel: (type) => hajjMediaTypeLabel(l10n, type),
              l10n: l10n,
            ),
            SizedBox(height: 8.h),
          ],
        ],
      ),
    );
  }
}
