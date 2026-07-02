import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/core/domain/models/educational_media.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/utils/file_pick_upload.dart';
import 'package:rafiq_alhajj/core/utils/upload_validation.dart';
import 'package:rafiq_alhajj/core/widgets/rafiq_app_bar.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_layout.dart';
import 'package:rafiq_alhajj/core/widgets/upload_progress_banner.dart';
import 'package:rafiq_alhajj/features/admin_content/presentation/providers/admin_content_providers.dart';
import 'package:rafiq_alhajj/features/admin_content/presentation/providers/admin_content_topics_providers.dart';
import 'package:rafiq_alhajj/features/admin_content/presentation/utils/content_meta_l10n.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_publication_status.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_topic.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_visibility.dart';
import 'package:rafiq_alhajj/features/content/presentation/providers/content_media_providers.dart';
import 'package:rafiq_alhajj/features/content/presentation/utils/content_cover_utils.dart';
import 'package:rafiq_alhajj/features/content/presentation/widgets/content_markdown_preview.dart';
import 'package:rafiq_alhajj/features/content/presentation/widgets/resolved_cover_image.dart';
import 'package:rafiq_alhajj/features/content/presentation/widgets/content_topic_offline_actions.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';
import 'package:reactive_forms/reactive_forms.dart';

class AdminContentTopicEditScreen extends ConsumerStatefulWidget {
  const AdminContentTopicEditScreen({this.topicId, super.key});

  final String? topicId;

  @override
  ConsumerState<AdminContentTopicEditScreen> createState() =>
      _AdminContentTopicEditScreenState();
}

class _MediaDraft {
  _MediaDraft({
    required this.mediaType,
    required this.urlController,
    required this.titleController,
  });

  EducationalMediaType mediaType;
  final TextEditingController urlController;
  final TextEditingController titleController;

  ContentTopicMediaInput toInput(int sortOrder) => ContentTopicMediaInput(
        mediaType: mediaType,
        url: urlController.text.trim(),
        title: titleController.text.trim().isEmpty
            ? null
            : titleController.text.trim(),
        sortOrder: sortOrder,
      );
}

class _AdminContentTopicEditScreenState
    extends ConsumerState<AdminContentTopicEditScreen> {
  late final FormGroup _form;
  bool _isActive = true;
  bool _notifyPilgrims = false;
  final List<_MediaDraft> _media = [];
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
      'titleAr': FormControl<String>(value: ''),
      'titleEn': FormControl<String>(value: ''),
      'descriptionAr': FormControl<String>(value: ''),
      'descriptionEn': FormControl<String>(value: ''),
      'coverUrl': FormControl<String>(value: ''),
      'sortOrder': FormControl<String>(value: '1'),
      'visibility': FormControl<ContentVisibility>(
        value: ContentVisibility.public,
      ),
      'publicationStatus': FormControl<ContentPublicationStatus>(
        value: ContentPublicationStatus.published,
      ),
    });
  }

  @override
  void dispose() {
    _form.dispose();
    for (final item in _media) {
      item.urlController.dispose();
      item.titleController.dispose();
    }
    super.dispose();
  }

  void _populate(ContentTopic topic) {
    if (_initialized) {
      return;
    }
    _form.control('titleAr').updateValue(topic.titleAr);
    _form.control('titleEn').updateValue(topic.titleEn ?? '');
    _form.control('descriptionAr').updateValue(topic.descriptionAr ?? '');
    _form.control('descriptionEn').updateValue(topic.descriptionEn ?? '');
    _form.control('coverUrl').updateValue(topic.coverImageUrl ?? '');
    _form.control('sortOrder').updateValue('${topic.sortOrder}');
    _form.control('visibility').updateValue(topic.visibility);
    _form.control('publicationStatus').updateValue(topic.publicationStatus);
    _isActive = topic.isActive;
    if (topic.coverImageUrl != null && topic.coverImageUrl!.isNotEmpty) {
      _initialMediaUrls.add(topic.coverImageUrl!);
    }
    for (final m in topic.media) {
      _initialMediaUrls.add(m.url);
      _media.add(
        _MediaDraft(
          mediaType: m.mediaType,
          urlController: TextEditingController(text: m.url),
          titleController: TextEditingController(text: m.title ?? ''),
        ),
      );
    }
    _initialized = true;
  }

  List<EducationalMediaItem> get _previewMedia {
    return [
      for (var i = 0; i < _media.length; i++)
        if (_media[i].urlController.text.trim().isNotEmpty)
          EducationalMediaItem(
            id: 'preview-$i',
            mediaType: _media[i].mediaType,
            title: _media[i].titleController.text.trim().isEmpty
                ? null
                : _media[i].titleController.text.trim(),
            url: _media[i].urlController.text.trim(),
            sortOrder: i + 1,
          ),
    ];
  }

  UploadConstraints _constraintsFor(EducationalMediaType type) {
    return switch (type) {
      EducationalMediaType.video => UploadConstraints.video,
      EducationalMediaType.audio => UploadConstraints.audio,
      EducationalMediaType.image => UploadConstraints.image,
      EducationalMediaType.pdf => UploadConstraints.pdf,
    };
  }

  UploadMediaKind _kindFor(EducationalMediaType type) {
    return switch (type) {
      EducationalMediaType.video => UploadMediaKind.video,
      EducationalMediaType.audio => UploadMediaKind.audio,
      EducationalMediaType.image => UploadMediaKind.image,
      EducationalMediaType.pdf => UploadMediaKind.other,
    };
  }

  Future<void> _uploadCover() async {
    await _pickAndUpload(
      onUploaded: (url) => _form.control('coverUrl').updateValue(url),
      folder: 'covers',
      constraints: UploadConstraints.image,
      kind: UploadMediaKind.image,
    );
  }

  Future<void> _uploadMediaFile(int index) async {
    final type = _media[index].mediaType;
    await _pickAndUpload(
      onUploaded: (url) => _media[index].urlController.text = url,
      folder: 'media',
      constraints: _constraintsFor(type),
      kind: _kindFor(type),
    );
  }

  Future<void> _pickAndUpload({
    required void Function(String url) onUploaded,
    required String folder,
    required UploadConstraints constraints,
    required UploadMediaKind kind,
  }) async {
    final l10n = AppLocalizations.of(context);

    PickedUpload? picked;
    try {
      picked = await pickValidatedUpload(
        constraints,
        kind: kind,
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

    final isPrivate = (_form.control('visibility').value as ContentVisibility) ==
        ContentVisibility.pilgrimOnly;

    try {
      final url = await ref.read(contentMediaStorageServiceProvider).uploadBytes(
            bytes: picked.bytes,
            fileName: picked.fileName,
            topicId: widget.topicId,
            folder: folder,
            constraints: constraints,
            isPrivate: isPrivate,
            onProgress: (progress) {
              if (mounted) {
                setState(() => _uploadProgress = progress);
              }
            },
          );
      onUploaded(url);
      if (mounted) {
        setState(() {});
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

  void _addMedia() {
    setState(() {
      _media.add(
        _MediaDraft(
          mediaType: EducationalMediaType.video,
          urlController: TextEditingController(),
          titleController: TextEditingController(),
        ),
      );
    });
  }

  void _removeMedia(int index) {
    setState(() {
      final item = _media.removeAt(index);
      item.urlController.dispose();
      item.titleController.dispose();
    });
  }

  Future<void> _save() async {
    final l10n = AppLocalizations.of(context);
    final titleAr = (_form.control('titleAr').value as String).trim();

    if (titleAr.isEmpty) {
      _showSnack(l10n.adminContentTopicTitleRequired);
      return;
    }

    final sortOrder =
        int.tryParse((_form.control('sortOrder').value as String).trim()) ?? 1;
    final coverUrl = (_form.control('coverUrl').value as String).trim();
    final input = ContentTopicEditorInput(
      titleAr: titleAr,
      titleEn: (_form.control('titleEn').value as String).trim(),
      descriptionAr: (_form.control('descriptionAr').value as String).trim(),
      descriptionEn: (_form.control('descriptionEn').value as String).trim(),
      coverImageUrl: coverUrl,
      visibility: _form.control('visibility').value as ContentVisibility,
      sortOrder: sortOrder,
      isActive: _isActive,
      publicationStatus:
          _form.control('publicationStatus').value as ContentPublicationStatus,
    );

    final media = [
      for (var i = 0; i < _media.length; i++)
        if (_media[i].urlController.text.trim().isNotEmpty)
          _media[i].toInput(i + 1),
    ];

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
            title: input.titleAr,
            route: 'contentTopic',
            id: savedId,
            visibility: input.visibility,
          );
    }

    // Best-effort: drop storage objects that are no longer referenced.
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
        return _buildForm(l10n, isBusy);
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
          isLoading: isSaving,
        ),
      ),
      mobile: Scaffold(
        appBar: RafiqAppBar(
          title: Text(title),
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
      ),
    );
  }

  Widget _buildForm(AppLocalizations l10n, bool isBusy) {
    return ReactiveForm(
      formGroup: _form,
      child: ListView(
        padding: EdgeInsets.all(16.w),
        children: [
          if (_isUploading)
            Padding(
              padding: EdgeInsets.only(bottom: 16.h),
              child: UploadProgressBanner(
                progress: _uploadProgress,
                compressing: _isCompressing,
              ),
            ),
          ReactiveTextField<String>(
            formControlName: 'titleAr',
            decoration: InputDecoration(
              labelText: l10n.adminContentTitleArLabel,
            ),
          ),
          SizedBox(height: 12.h),
          ReactiveTextField<String>(
            formControlName: 'titleEn',
            decoration: InputDecoration(
              labelText: l10n.adminContentTitleEnLabel,
            ),
          ),
          SizedBox(height: 12.h),
          ReactiveTextField<String>(
            formControlName: 'descriptionAr',
            decoration: InputDecoration(
              labelText: l10n.adminContentDescriptionArLabel,
              alignLabelWithHint: true,
            ),
            minLines: 3,
            maxLines: 8,
          ),
          SizedBox(height: 12.h),
          ReactiveTextField<String>(
            formControlName: 'descriptionEn',
            decoration: InputDecoration(
              labelText: l10n.adminContentDescriptionEnLabel,
              alignLabelWithHint: true,
            ),
            minLines: 3,
            maxLines: 8,
          ),
          Builder(
            builder: (context) {
              final descriptionAr =
                  _form.control('descriptionAr').value as String? ?? '';
              if (descriptionAr.trim().isEmpty) {
                return const SizedBox.shrink();
              }
              return Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: ContentMarkdownPreview(
                  label: l10n.adminContentMarkdownPreviewLabel,
                  markdown: descriptionAr,
                ),
              );
            },
          ),
          SizedBox(height: 12.h),
          ReactiveTextField<String>(
            formControlName: 'coverUrl',
            decoration: InputDecoration(
              labelText: l10n.adminContentTopicCoverUrl,
            ),
          ),
          Builder(
            builder: (context) {
              final coverUrl = _form.control('coverUrl').value as String? ?? '';
              if (!isContentCoverImageUrl(coverUrl)) {
                return const SizedBox.shrink();
              }
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: widget.topicId != null
                      ? ResolvedCoverImage(
                          cacheMediaId: ContentMediaDownloadController
                              .coverMediaId(widget.topicId!),
                          remoteUrl: coverUrl,
                          fit: BoxFit.cover,
                          height: 160.h,
                        )
                      : Image.network(
                          coverUrl,
                          height: 160.h,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (_, _, _) => const SizedBox.shrink(),
                        ),
                ),
              );
            },
          ),
          SizedBox(height: 8.h),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: OutlinedButton.icon(
              onPressed: isBusy ? null : _uploadCover,
              icon: const Icon(Icons.upload_file_outlined),
              label: Text(l10n.adminContentTopicUploadCover),
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
          ReactiveDropdownField<ContentPublicationStatus>(
            formControlName: 'publicationStatus',
            decoration: InputDecoration(
              labelText: l10n.adminContentPublicationStatusLabel,
            ),
            items: ContentPublicationStatus.values
                .map(
                  (status) => DropdownMenuItem(
                    value: status,
                    child: Text(
                      status == ContentPublicationStatus.draft
                          ? l10n.adminContentPublicationDraft
                          : l10n.adminContentPublicationPublished,
                    ),
                  ),
                )
                .toList(),
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
            value: _isActive,
            onChanged: (v) => setState(() => _isActive = v),
            title: Text(l10n.adminHajjJourneyActive),
          ),
          SwitchListTile(
            value: _notifyPilgrims,
            onChanged: isBusy ? null : (v) => setState(() => _notifyPilgrims = v),
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
              IconButton(
                onPressed: _addMedia,
                icon: const Icon(Icons.add_circle_outline),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: Text(
              l10n.adminContentVideoExternalHint,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
          ),
          for (var i = 0; i < _media.length; i++) ...[
            _MediaDraftCard(
              draft: _media[i],
              isBusy: isBusy,
              onTypeChanged: (v) => setState(() => _media[i].mediaType = v),
              onUpload: () => _uploadMediaFile(i),
              onRemove: () => _removeMedia(i),
              onChanged: () => setState(() {}),
              mediaTypeLabel: (type) => _mediaTypeLabel(l10n, type),
              l10n: l10n,
            ),
            SizedBox(height: 8.h),
          ],
          if (_previewMedia.isNotEmpty) ...[
            SizedBox(height: 8.h),
            AdminContentMediaPreview(media: _previewMedia),
          ],
        ],
      ),
    );
  }

  String _mediaTypeLabel(AppLocalizations l10n, EducationalMediaType type) {
    return switch (type) {
      EducationalMediaType.video => l10n.hajjJourneyMediaVideo,
      EducationalMediaType.audio => l10n.hajjJourneyMediaAudio,
      EducationalMediaType.image => l10n.hajjJourneyMediaImage,
      EducationalMediaType.pdf => l10n.contentMediaPdf,
    };
  }
}

class _MediaDraftCard extends StatelessWidget {
  const _MediaDraftCard({
    required this.draft,
    required this.isBusy,
    required this.onTypeChanged,
    required this.onUpload,
    required this.onRemove,
    required this.onChanged,
    required this.mediaTypeLabel,
    required this.l10n,
  });

  final _MediaDraft draft;
  final bool isBusy;
  final ValueChanged<EducationalMediaType> onTypeChanged;
  final VoidCallback onUpload;
  final VoidCallback onRemove;
  final VoidCallback onChanged;
  final String Function(EducationalMediaType) mediaTypeLabel;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Column(
          children: [
            DropdownButtonFormField<EducationalMediaType>(
              initialValue: draft.mediaType,
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
              onChanged: (v) {
                if (v != null) {
                  onTypeChanged(v);
                }
              },
            ),
            SizedBox(height: 8.h),
            TextField(
              controller: draft.titleController,
              decoration: InputDecoration(
                labelText: l10n.adminHajjJourneyMediaTitle,
              ),
              onChanged: (_) => onChanged(),
            ),
            SizedBox(height: 8.h),
            TextField(
              controller: draft.urlController,
              decoration: InputDecoration(
                labelText: l10n.adminHajjJourneyMediaUrl,
              ),
              onChanged: (_) => onChanged(),
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
    );
  }
}
