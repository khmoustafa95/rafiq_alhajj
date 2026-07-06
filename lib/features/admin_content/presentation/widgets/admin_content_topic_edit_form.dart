import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/core/widgets/upload_progress_banner.dart';
import 'package:rafiq_alhajj/features/admin_content/presentation/forms/topic_media_form.dart';
import 'package:rafiq_alhajj/features/admin_content/presentation/utils/content_meta_l10n.dart';
import 'package:rafiq_alhajj/features/admin_content/presentation/widgets/admin_topic_media_draft_card.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_visibility.dart';
import 'package:rafiq_alhajj/features/content/presentation/widgets/content_topic_offline_actions.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// Reactive form body for the admin educational topic editor.
class AdminContentTopicEditForm extends StatelessWidget {
  const AdminContentTopicEditForm({
    required this.form,
    required this.isBusy,
    required this.isUploading,
    required this.isCompressing,
    required this.uploadProgress,
    required this.isActive,
    required this.notifyPilgrims,
    required this.onActiveChanged,
    required this.onNotifyChanged,
    required this.onUploadCover,
    required this.onAddMedia,
    required this.onUploadMedia,
    required this.onRemoveMedia,
    super.key,
  });

  final FormGroup form;
  final bool isBusy;
  final bool isUploading;
  final bool isCompressing;
  final double? uploadProgress;
  final bool isActive;
  final bool notifyPilgrims;
  final ValueChanged<bool> onActiveChanged;
  final ValueChanged<bool> onNotifyChanged;
  final VoidCallback onUploadCover;
  final VoidCallback onAddMedia;
  final ValueChanged<int> onUploadMedia;
  final ValueChanged<int> onRemoveMedia;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final mediaArray = TopicMediaForm.mediaArray(form);
    final previewMedia = TopicMediaForm.previewItems(mediaArray);

    return ReactiveForm(
      formGroup: form,
      child: ListView(
        padding: EdgeInsets.all(16.w),
        children: [
          if (isUploading)
            Padding(
              padding: EdgeInsets.only(bottom: 16.h),
              child: UploadProgressBanner(
                progress: uploadProgress,
                compressing: isCompressing,
              ),
            ),
          ReactiveTextField<String>(
            formControlName: 'title',
            decoration: InputDecoration(
              labelText: l10n.adminContentTitleLabel,
            ),
          ),
          SizedBox(height: 12.h),
          ReactiveTextField<String>(
            formControlName: 'description',
            decoration: InputDecoration(
              labelText: l10n.adminContentTopicDescription,
            ),
            minLines: 3,
            maxLines: 6,
          ),
          SizedBox(height: 12.h),
          ReactiveTextField<String>(
            formControlName: 'coverUrl',
            decoration: InputDecoration(
              labelText: l10n.adminContentTopicCoverUrl,
            ),
          ),
          SizedBox(height: 8.h),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Semantics(
              button: true,
              label: l10n.adminContentTopicUploadCover,
              enabled: !isBusy,
              child: OutlinedButton.icon(
                onPressed: isBusy ? null : onUploadCover,
                icon: const Icon(Icons.upload_file_outlined),
                label: Text(l10n.adminContentTopicUploadCover),
              ),
            ),
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
          ReactiveDropdownField<ContentVisibility>(
            formControlName: 'visibility',
            decoration: InputDecoration(
              labelText: l10n.adminContentVisibilityLabel,
            ),
            items: ContentVisibility.values
                .map(
                  (v) => DropdownMenuItem(
                    value: v,
                    child: Text(contentVisibilityLabel(l10n, v)),
                  ),
                )
                .toList(),
          ),
          SizedBox(height: 8.h),
          SwitchListTile(
            value: isActive,
            onChanged: onActiveChanged,
            title: Text(l10n.adminHajjJourneyActive),
          ),
          SwitchListTile(
            value: notifyPilgrims,
            onChanged: isBusy ? null : onNotifyChanged,
            title: Text(l10n.adminContentNotifyPilgrims),
            subtitle: Text(l10n.adminContentNotifyPilgrimsHint),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: Text(
                  l10n.adminContentTopicMediaSection,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Semantics(
                button: true,
                label: l10n.adminContentTopicMediaSection,
                child: IconButton(
                  onPressed: onAddMedia,
                  icon: const Icon(Icons.add_circle_outline),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: Text(
              l10n.adminContentVideoExternalHint,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
          ),
          for (var i = 0; i < mediaArray.controls.length; i++) ...[
            AdminTopicMediaDraftCard(
              mediaGroup: mediaArray.controls[i] as FormGroup,
              isBusy: isBusy,
              onUpload: () => onUploadMedia(i),
              onRemove: () => onRemoveMedia(i),
              mediaTypeLabel: (type) => educationalMediaTypeLabel(l10n, type),
              l10n: l10n,
            ),
            SizedBox(height: 8.h),
          ],
          if (previewMedia.isNotEmpty) ...[
            SizedBox(height: 8.h),
            AdminContentMediaPreview(media: previewMedia),
          ],
        ],
      ),
    );
  }
}
