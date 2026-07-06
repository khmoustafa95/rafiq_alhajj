import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_layout.dart';
import 'package:rafiq_alhajj/core/widgets/upload_progress_banner.dart';
import 'package:rafiq_alhajj/features/admin_content/presentation/utils/content_meta_l10n.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_type.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_visibility.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// Reactive form fields for announcement/news feed items.
class AdminContentEditForm extends StatelessWidget {
  const AdminContentEditForm({
    required this.form,
    required this.type,
    required this.notifyPilgrims,
    required this.isBusy,
    required this.isUploading,
    required this.isCompressing,
    required this.uploadProgress,
    required this.onNotifyChanged,
    required this.onUploadCover,
    super.key,
  });

  final FormGroup form;
  final ContentType type;
  final bool notifyPilgrims;
  final bool isBusy;
  final bool isUploading;
  final bool isCompressing;
  final double? uploadProgress;
  final ValueChanged<bool> onNotifyChanged;
  final VoidCallback onUploadCover;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return ReactiveForm(
      formGroup: form,
      child: StaffFormSection(
        icon: Icons.article_outlined,
        title: contentTypeLabel(l10n, type),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ResponsiveFormGrid(
              children: [
                ReactiveTextField<String>(
                  formControlName: 'title',
                  decoration: InputDecoration(
                    labelText: l10n.adminContentTitleLabel,
                  ),
                  validationMessages: {
                    ValidationMessage.required: (_) =>
                        l10n.adminContentTitleRequired,
                  },
                ),
                ReactiveTextField<String>(
                  formControlName: 'mediaUrl',
                  decoration: InputDecoration(
                    labelText: l10n.adminContentMediaUrlLabel,
                  ),
                  keyboardType: TextInputType.url,
                ),
                ReactiveTextField<String>(
                  formControlName: 'description',
                  maxLines: 4,
                  decoration: InputDecoration(
                    labelText: l10n.adminContentDescriptionLabel,
                  ),
                ),
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
              ],
            ),
            SizedBox(height: 12.h),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: OutlinedButton.icon(
                onPressed: isBusy ? null : onUploadCover,
                icon: const Icon(Icons.image_outlined),
                label: Text(l10n.adminContentMediaUploadCover),
              ),
            ),
            if (isUploading) ...[
              SizedBox(height: 12.h),
              UploadProgressBanner(
                progress: uploadProgress,
                compressing: isCompressing,
              ),
            ],
            SizedBox(height: 8.h),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              value: notifyPilgrims,
              onChanged: isBusy ? null : onNotifyChanged,
              title: Text(l10n.adminContentNotifyPilgrims),
              subtitle: Text(l10n.adminContentNotifyPilgrimsHint),
            ),
          ],
        ),
      ),
    );
  }
}
