import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/core/domain/models/educational_media.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
import 'package:rafiq_alhajj/core/routing/staff_navigation.dart';
import 'package:rafiq_alhajj/core/utils/upload_validation.dart';
import 'package:rafiq_alhajj/core/widgets/rafiq_app_bar.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_layout.dart';
import 'package:rafiq_alhajj/features/admin_content/presentation/forms/topic_media_form.dart';
import 'package:rafiq_alhajj/features/admin_content/presentation/providers/admin_content_providers.dart';
import 'package:rafiq_alhajj/features/admin_content/presentation/providers/admin_content_topics_providers.dart';
import 'package:rafiq_alhajj/features/admin_content/presentation/widgets/admin_content_topic_edit_form.dart';
import 'package:rafiq_alhajj/features/admin_content/presentation/widgets/admin_content_topic_media_upload.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_topic.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_visibility.dart';
import 'package:rafiq_alhajj/features/content/presentation/providers/content_media_providers.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';
import 'package:reactive_forms/reactive_forms.dart';

class AdminContentTopicEditScreen extends ConsumerStatefulWidget {
  const AdminContentTopicEditScreen({this.topicId, super.key});

  final String? topicId;

  @override
  ConsumerState<AdminContentTopicEditScreen> createState() =>
      _AdminContentTopicEditScreenState();
}

class _AdminContentTopicEditScreenState
    extends ConsumerState<AdminContentTopicEditScreen> {
  late final FormGroup _form;
  bool _isActive = true;
  bool _notifyPilgrims = false;
  bool _initialized = false;
  bool _isUploading = false;
  bool _isCompressing = false;
  double? _uploadProgress;

  /// URLs present when the topic loaded — used to clean up orphaned storage
  /// objects when media is replaced or removed before saving.
  final Set<String> _initialMediaUrls = {};

  @override
  void initState() {
    super.initState();
    _form = FormGroup({
      'title': FormControl<String>(value: ''),
      'description': FormControl<String>(value: ''),
      'coverUrl': FormControl<String>(value: ''),
      'sortOrder': FormControl<String>(value: '1'),
      'visibility': FormControl<ContentVisibility>(
        value: ContentVisibility.public,
      ),
      'media': FormArray<dynamic>([]),
    });
  }

  @override
  void dispose() {
    _form.dispose();
    super.dispose();
  }

  void _populate(ContentTopic topic) {
    if (_initialized) {
      return;
    }
    _form.control('title').updateValue(topic.title);
    _form.control('description').updateValue(topic.description ?? '');
    _form.control('coverUrl').updateValue(topic.coverImageUrl ?? '');
    _form.control('sortOrder').updateValue('${topic.sortOrder}');
    _form.control('visibility').updateValue(topic.visibility);
    _isActive = topic.isActive;
    if (topic.coverImageUrl != null && topic.coverImageUrl!.isNotEmpty) {
      _initialMediaUrls.add(topic.coverImageUrl!);
    }
    for (final m in topic.media) {
      _initialMediaUrls.add(m.url);
    }
    TopicMediaForm.bindTopicMedia(_form, topic);
    _initialized = true;
  }

  FormArray<dynamic> get _mediaArray => TopicMediaForm.mediaArray(_form);

  ContentVisibility get _visibility =>
      _form.control('visibility').value as ContentVisibility;

  void _onUploadProgress({
    required bool isUploading,
    required bool isCompressing,
    required double? progress,
  }) {
    if (!mounted) {
      return;
    }
    setState(() {
      _isUploading = isUploading;
      _isCompressing = isCompressing;
      _uploadProgress = progress;
    });
  }

  Future<void> _uploadCover() async {
    await AdminContentTopicMediaUpload.pickAndUpload(
      context: context,
      ref: ref,
      visibility: _visibility,
      topicId: widget.topicId,
      folder: 'covers',
      constraints: UploadConstraints.image,
      kind: UploadMediaKind.image,
      onUploaded: (url) => _form.control('coverUrl').updateValue(url),
      onProgress: _onUploadProgress,
      showMessage: _showSnack,
    );
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _uploadMediaFile(int index) async {
    final group = _mediaArray.controls[index] as FormGroup;
    final type =
        group.control(TopicMediaForm.mediaTypeControl).value as EducationalMediaType;
    await AdminContentTopicMediaUpload.pickAndUpload(
      context: context,
      ref: ref,
      visibility: _visibility,
      topicId: widget.topicId,
      folder: 'media',
      constraints: AdminContentTopicMediaUpload.constraintsFor(type),
      kind: AdminContentTopicMediaUpload.kindFor(type),
      onUploaded: (url) =>
          group.control(TopicMediaForm.urlControl).updateValue(url),
      onProgress: _onUploadProgress,
      showMessage: _showSnack,
    );
    if (mounted) {
      setState(() {});
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

  void _addMedia() {
    setState(() {
      _mediaArray.add(TopicMediaForm.newMediaGroup());
    });
  }

  void _removeMedia(int index) {
    setState(() {
      _mediaArray.removeAt(index);
    });
  }

  void _cancel() {
    staffNavigateBack(context, fallbackRoute: AppRoutes.adminContentTopics);
  }

  Future<void> _save() async {
    final l10n = AppLocalizations.of(context);
    final title = (_form.control('title').value as String).trim();

    if (title.isEmpty) {
      _showSnack(l10n.adminContentTopicTitleRequired);
      return;
    }

    final sortOrder =
        int.tryParse((_form.control('sortOrder').value as String).trim()) ?? 1;
    final coverUrl = (_form.control('coverUrl').value as String).trim();
    final input = ContentTopicEditorInput(
      title: title,
      description: (_form.control('description').value as String).trim(),
      coverImageUrl: coverUrl,
      visibility: _visibility,
      sortOrder: sortOrder,
      isActive: _isActive,
    );

    final media = TopicMediaForm.toInputs(_mediaArray);

    final savedId = await ref.read(adminContentTopicSaveProvider.notifier).save(
          id: widget.topicId,
          input: input,
          media: media,
        );

    if (!mounted) {
      return;
    }

    if (savedId == null) {
      _showSnack(l10n.adminContentTopicSaveError);
      return;
    }

    if (_notifyPilgrims) {
      await ref.read(contentNotificationServiceProvider).publish(
            title: input.title,
            route: 'contentTopic',
            id: savedId,
            visibility: input.visibility,
          );
    }

    await _cleanupOrphanedMedia(coverUrl, media);

    if (!mounted) {
      return;
    }
    _showSnack(l10n.adminContentTopicSaveSuccess);
    Navigator.pop(context);
  }

  Future<void> _cleanupOrphanedMedia(
    String coverUrl,
    List<ContentTopicMediaInput> media,
  ) async {
    if (_initialMediaUrls.isEmpty) {
      return;
    }
    final stillReferenced = <String>{
      if (coverUrl.isNotEmpty) coverUrl,
      for (final m in media) m.url,
    };
    final orphans =
        _initialMediaUrls.where((url) => !stillReferenced.contains(url));
    if (orphans.isEmpty) {
      return;
    }
    await ref
        .read(contentMediaStorageServiceProvider)
        .removeStorageRefs(orphans);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isEditing = widget.topicId != null;
    final topicAsync = isEditing
        ? ref.watch(adminContentTopicDetailProvider(widget.topicId!))
        : const AsyncValue.data(null);
    final isSaving = ref.watch(adminContentTopicSaveProvider).isLoading;
    final isBusy = isSaving || _isUploading;
    final title = isEditing
        ? l10n.adminContentTopicEditTitle
        : l10n.adminContentTopicNewTitle;

    final body = topicAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, _) => Center(child: Text(l10n.adminContentTopicLoadError)),
      data: (topic) {
        if (topic != null) {
          _populate(topic);
        }
        return AdminContentTopicEditForm(
          form: _form,
          isBusy: isBusy,
          isUploading: _isUploading,
          isCompressing: _isCompressing,
          uploadProgress: _uploadProgress,
          isActive: _isActive,
          notifyPilgrims: _notifyPilgrims,
          onActiveChanged: (value) => setState(() => _isActive = value),
          onNotifyChanged: (value) => setState(() => _notifyPilgrims = value),
          onUploadCover: () => unawaited(_uploadCover()),
          onAddMedia: _addMedia,
          onUploadMedia: (index) => unawaited(_uploadMediaFile(index)),
          onRemoveMedia: _removeMedia,
        );
      },
    );

    return StaffAdaptivePage(
      web: StaffWebPage(
        title: title,
        scrollable: false,
        body: body,
        bottomBar: StaffFormActionsBar(
          primaryLabel: l10n.adminContentSave,
          onPrimary: isBusy ? null : _save,
          secondaryLabel: l10n.dialogCancel,
          onSecondary: isBusy ? null : _cancel,
          isLoading: isSaving,
        ),
      ),
      mobile: Scaffold(
        appBar: RafiqAppBar(
          title: Text(title),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: isBusy ? null : _cancel,
          ),
          automaticallyImplyLeading: false,
          actions: [
            TextButton(
              onPressed: isBusy ? null : _save,
              child: isSaving
                  ? SizedBox(
                      width: 20.w,
                      height: 20.w,
                      child: const CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(l10n.adminContentSave),
            ),
          ],
        ),
        body: body,
        bottomNavigationBar: StaffFormMobileActionsBar(
          primaryLabel: l10n.adminContentSave,
          onPrimary: isBusy ? null : _save,
          secondaryLabel: l10n.dialogCancel,
          onSecondary: isBusy ? null : _cancel,
          isLoading: isSaving,
        ),
      ),
    );
  }
}
