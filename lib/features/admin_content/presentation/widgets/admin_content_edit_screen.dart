import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
import 'package:rafiq_alhajj/core/routing/staff_navigation.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/utils/file_pick_upload.dart';
import 'package:rafiq_alhajj/core/utils/upload_validation.dart';
import 'package:rafiq_alhajj/core/widgets/rafiq_app_bar.dart';
import 'package:rafiq_alhajj/core/widgets/staff_error_view.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_layout.dart';
import 'package:rafiq_alhajj/core/widgets/upload_progress_banner.dart';
import 'package:rafiq_alhajj/features/admin_content/domain/models/content_editor_input.dart';
import 'package:rafiq_alhajj/features/admin_content/presentation/providers/admin_content_providers.dart';
import 'package:rafiq_alhajj/features/admin_content/presentation/utils/content_meta_l10n.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_item.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_type.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_visibility.dart';
import 'package:rafiq_alhajj/features/content/presentation/providers/content_media_providers.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';
import 'package:reactive_forms/reactive_forms.dart';

class AdminContentEditScreen extends ConsumerStatefulWidget {
  const AdminContentEditScreen({this.contentId, super.key});

  final String? contentId;

  @override
  ConsumerState<AdminContentEditScreen> createState() =>
      _AdminContentEditScreenState();
}

class _AdminContentEditScreenState extends ConsumerState<AdminContentEditScreen> {
  late final FormGroup _form;
  bool _loaded = false;
  bool _isUploading = false;
  bool _isCompressing = false;
  double? _uploadProgress;

  bool get _isEditing => widget.contentId != null;

  String get _pageTitle {
    final l10n = AppLocalizations.of(context);
    return _isEditing ? l10n.adminContentEditTitle : l10n.adminContentNewTitle;
  }

  @override
  void initState() {
    super.initState();
    _form = FormGroup({
      'title': FormControl<String>(value: '', validators: [Validators.required]),
      'mediaUrl': FormControl<String>(value: ''),
      'description': FormControl<String>(value: ''),
      'type': FormControl<ContentType>(value: ContentType.news),
      'visibility': FormControl<ContentVisibility>(
        value: ContentVisibility.public,
      ),
    });
  }

  @override
  void dispose() {
    _form.dispose();
    super.dispose();
  }

  void _bindItem(ContentItem item) {
    if (_loaded) {
      return;
    }
    _form.control('title').updateValue(item.title);
    _form.control('description').updateValue(item.description ?? '');
    _form.control('mediaUrl').updateValue(item.mediaUrl ?? '');
    _form.control('type').updateValue(item.type);
    _form.control('visibility').updateValue(item.visibility);
    _loaded = true;
  }

  void _cancel() {
    staffNavigateBack(context, fallbackRoute: AppRoutes.adminContent);
  }

  Future<void> _submit() async {
    if (!_form.valid) {
      _form.markAllAsTouched();
      return;
    }

    final l10n = AppLocalizations.of(context);
    final input = ContentEditorInput(
      id: widget.contentId,
      title: _form.control('title').value as String,
      description: _form.control('description').value as String,
      mediaUrl: _form.control('mediaUrl').value as String,
      type: _form.control('type').value as ContentType,
      visibility: _form.control('visibility').value as ContentVisibility,
    );

    final ok = await ref.read(adminContentSaveProvider.notifier).save(input);

    if (!mounted) {
      return;
    }

    if (ok) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isEditing
                ? l10n.adminContentSaveSuccess
                : l10n.adminContentCreateSuccess,
          ),
        ),
      );
      context.go(AppRoutes.adminContent);
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n.adminContentSaveError)),
    );
  }

  Future<void> _uploadImage() async {
    final l10n = AppLocalizations.of(context);
    const constraints = UploadConstraints.image;

    PickedUpload? picked;
    try {
      picked = await pickValidatedUpload(
        constraints,
        kind: UploadMediaKind.image,
        onCompressProgress: (progress) {
          if (mounted) {
            setState(() {
              _isUploading = true;
              _isCompressing = true;
              _uploadProgress = progress;
            });
          }
        },
      );
    } on UploadValidationException catch (e) {
      _resetUploadState();
      _showSnack(uploadErrorMessage(l10n, e, constraints: constraints));
      return;
    }
    if (picked == null || !mounted) {
      _resetUploadState();
      return;
    }

    setState(() {
      _isUploading = true;
      _isCompressing = false;
      _uploadProgress = 0;
    });

    try {
      final url = await ref.read(contentMediaStorageServiceProvider).uploadBytes(
            bytes: picked.bytes,
            fileName: picked.fileName,
            folder: 'content',
            onProgress: (progress) {
              if (mounted) {
                setState(() => _uploadProgress = progress);
              }
            },
          );
      _form.control('mediaUrl').updateValue(url);
      if (mounted) {
        _showSnack(l10n.adminContentTopicUploadSuccess);
      }
    } catch (e) {
      _showSnack(uploadErrorMessage(l10n, e, constraints: constraints));
    } finally {
      _resetUploadState();
    }
  }

  void _resetUploadState() {
    if (mounted) {
      setState(() {
        _isUploading = false;
        _isCompressing = false;
        _uploadProgress = null;
      });
    }
  }

  void _showSnack(String message) {
    if (!mounted) {
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Widget _loadingState(AppLocalizations l10n) {
    return StaffAdaptivePage(
      web: StaffWebPage(
        title: _pageTitle,
        body: const Center(child: CircularProgressIndicator()),
      ),
      mobile: Scaffold(
        appBar: RafiqAppBar(title: Text(_pageTitle)),
        body: const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Widget _errorState(AppLocalizations l10n, Object error, {VoidCallback? onRetry}) {
    return StaffAdaptivePage(
      web: StaffWebPage(
        title: _pageTitle,
        body: StaffErrorView.fromError(l10n, error: error, onRetry: onRetry),
      ),
      mobile: Scaffold(
        appBar: RafiqAppBar(title: Text(_pageTitle)),
        body: StaffErrorView.fromError(l10n, error: error, onRetry: onRetry),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isSaving = ref.watch(
      adminContentSaveProvider.select((state) => state.isLoading),
    );

    ref.listen(
      adminContentSaveProvider.select((state) => state.isLoading),
      (previous, isLoading) {
        if (isLoading) {
          _form.markAsDisabled();
        } else {
          _form.markAsEnabled();
        }
      },
    );

    if (_isEditing) {
      final contentId = widget.contentId!;
      final detailAsync = ref.watch(adminContentDetailProvider(contentId));
      return detailAsync.when(
        skipLoadingOnReload: true,
        loading: () => _loadingState(l10n),
        error: (error, _) => _errorState(
          l10n,
          error,
          onRetry: () => ref.invalidate(adminContentDetailProvider(contentId)),
        ),
        data: (item) {
          if (item == null) {
            return StaffAdaptivePage(
              web: StaffWebPage(
                title: _pageTitle,
                body: StaffErrorView(message: l10n.adminContentNotFound),
              ),
              mobile: Scaffold(
                appBar: RafiqAppBar(title: Text(_pageTitle)),
                body: StaffErrorView(message: l10n.adminContentNotFound),
              ),
            );
          }
          _bindItem(item);
          return _buildForm(l10n, isSaving);
        },
      );
    }

    return _buildForm(l10n, isSaving);
  }

  Widget _buildForm(AppLocalizations l10n, bool isSaving) {
    final isBusy = isSaving || _isUploading;
    final form = ReactiveForm(
      formGroup: _form,
      child: StaffFormSection(
        icon: Icons.article_outlined,
        title: l10n.adminContentListTitle,
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
                ReactiveDropdownField<ContentType>(
                  formControlName: 'type',
                  decoration: InputDecoration(
                    labelText: l10n.adminContentTypeLabel,
                  ),
                  items: ContentType.values
                      .map(
                        (type) => DropdownMenuItem(
                          value: type,
                          child: Text(contentTypeLabel(l10n, type)),
                        ),
                      )
                      .toList(),
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
                onPressed: isBusy ? null : _uploadImage,
                icon: const Icon(Icons.upload_file_outlined),
                label: Text(l10n.adminContentMediaUploadCover),
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              l10n.adminContentVideoExternalHint,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
            if (_isUploading) ...[
              SizedBox(height: 12.h),
              UploadProgressBanner(
                progress: _uploadProgress,
                compressing: _isCompressing,
              ),
            ],
          ],
        ),
      ),
    );

    return StaffAdaptivePage(
      web: StaffWebPage(
        title: _pageTitle,
        body: form,
        bottomBar: StaffFormActionsBar(
          primaryLabel: l10n.adminContentSave,
          onPrimary: _submit,
          secondaryLabel: l10n.dialogCancel,
          onSecondary: isSaving ? null : _cancel,
          isLoading: isSaving,
        ),
      ),
      mobile: Scaffold(
        appBar: RafiqAppBar(
          title: Text(_pageTitle),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: isSaving ? null : _cancel,
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: form,
        ),
        bottomNavigationBar: isSaving
            ? null
            : StaffFormMobileActionsBar(
                primaryLabel: l10n.adminContentSave,
                onPrimary: _submit,
                secondaryLabel: l10n.dialogCancel,
                onSecondary: _cancel,
              ),
      ),
    );
  }
}
