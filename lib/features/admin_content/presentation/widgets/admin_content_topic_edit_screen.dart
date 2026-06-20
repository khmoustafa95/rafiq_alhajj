import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/core/domain/models/educational_media.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/widgets/rafiq_app_bar.dart';
import 'package:rafiq_alhajj/features/admin_content/presentation/providers/admin_content_topics_providers.dart';
import 'package:rafiq_alhajj/features/admin_content/presentation/utils/content_meta_l10n.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_topic.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_visibility.dart';
import 'package:rafiq_alhajj/features/content/presentation/providers/content_media_providers.dart';
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
  final List<_MediaDraft> _media = [];
  bool _initialized = false;
  bool _isUploading = false;

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
    _form.control('title').updateValue(topic.title);
    _form.control('description').updateValue(topic.description ?? '');
    _form.control('coverUrl').updateValue(topic.coverImageUrl ?? '');
    _form.control('sortOrder').updateValue('${topic.sortOrder}');
    _form.control('visibility').updateValue(topic.visibility);
    _isActive = topic.isActive;
    for (final m in topic.media) {
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

  Future<void> _uploadCover() async {
    await _pickAndUpload(
      onUploaded: (url) => _form.control('coverUrl').updateValue(url),
      folder: 'covers',
    );
  }

  Future<void> _uploadMediaFile(int index) async {
    await _pickAndUpload(
      onUploaded: (url) => _media[index].urlController.text = url,
      folder: 'media',
    );
  }

  Future<void> _pickAndUpload({
    required void Function(String url) onUploaded,
    required String folder,
  }) async {
    final l10n = AppLocalizations.of(context);
    final result = await FilePicker.platform.pickFiles(withData: true);
    if (result == null || result.files.isEmpty) {
      return;
    }

    final file = result.files.first;
    final bytes = file.bytes;
    if (bytes == null) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.adminContentTopicUploadError)),
      );
      return;
    }

    setState(() => _isUploading = true);
    try {
      final url = await ref.read(contentMediaStorageServiceProvider).uploadBytes(
            bytes: bytes,
            fileName: file.name,
            topicId: widget.topicId,
            folder: folder,
          );
      onUploaded(url);
      if (mounted) {
        setState(() {});
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.adminContentTopicUploadSuccess)),
        );
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.adminContentTopicUploadError)),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isUploading = false);
      }
    }
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
    final title = (_form.control('title').value as String).trim();

    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.adminContentTopicTitleRequired)),
      );
      return;
    }

    final sortOrder =
        int.tryParse((_form.control('sortOrder').value as String).trim()) ?? 1;
    final input = ContentTopicEditorInput(
      title: title,
      description: (_form.control('description').value as String).trim(),
      coverImageUrl: (_form.control('coverUrl').value as String).trim(),
      visibility: _form.control('visibility').value as ContentVisibility,
      sortOrder: sortOrder,
      isActive: _isActive,
    );

    final media = [
      for (var i = 0; i < _media.length; i++)
        if (_media[i].urlController.text.trim().isNotEmpty)
          _media[i].toInput(i + 1),
    ];

    final ok = await ref.read(adminContentTopicSaveProvider.notifier).save(
          id: widget.topicId,
          input: input,
          media: media,
        );

    if (!mounted) {
      return;
    }

    if (!ok) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.adminContentTopicSaveError)),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n.adminContentTopicSaveSuccess)),
    );
    Navigator.pop(context);
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

    return Scaffold(
      appBar: RafiqAppBar(
        title: Text(
          isEditing
              ? l10n.adminContentTopicEditTitle
              : l10n.adminContentTopicNewTitle,
        ),
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
      body: topicAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => Center(child: Text(l10n.adminContentTopicLoadError)),
        data: (topic) {
          if (topic != null) {
            _populate(topic);
          }

          return ReactiveForm(
            formGroup: _form,
            child: ListView(
            padding: EdgeInsets.all(16.w),
            children: [
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
              for (var i = 0; i < _media.length; i++) ...[
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(12.w),
                    child: Column(
                      children: [
                        DropdownButtonFormField<EducationalMediaType>(
                          initialValue: _media[i].mediaType,
                          decoration: InputDecoration(
                            labelText: l10n.adminHajjJourneyMediaType,
                          ),
                          items: EducationalMediaType.values
                              .map(
                                (type) => DropdownMenuItem(
                                  value: type,
                                  child: Text(_mediaTypeLabel(l10n, type)),
                                ),
                              )
                              .toList(),
                          onChanged: (v) {
                            if (v != null) {
                              setState(() => _media[i].mediaType = v);
                            }
                          },
                        ),
                        SizedBox(height: 8.h),
                        TextField(
                          controller: _media[i].titleController,
                          decoration: InputDecoration(
                            labelText: l10n.adminHajjJourneyMediaTitle,
                          ),
                          onChanged: (_) => setState(() {}),
                        ),
                        SizedBox(height: 8.h),
                        TextField(
                          controller: _media[i].urlController,
                          decoration: InputDecoration(
                            labelText: l10n.adminHajjJourneyMediaUrl,
                          ),
                          onChanged: (_) => setState(() {}),
                        ),
                        SizedBox(height: 8.h),
                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: OutlinedButton.icon(
                            onPressed: isBusy ? null : () => _uploadMediaFile(i),
                            icon: const Icon(Icons.upload_file_outlined),
                            label: Text(l10n.adminContentTopicUploadMedia),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional.centerEnd,
                          child: TextButton.icon(
                            onPressed: () => _removeMedia(i),
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
                SizedBox(height: 8.h),
              ],
              if (_previewMedia.isNotEmpty) ...[
                SizedBox(height: 8.h),
                AdminContentMediaPreview(media: _previewMedia),
              ],
            ],
            ),
          );
        },
      ),
    );
  }

  String _mediaTypeLabel(AppLocalizations l10n, EducationalMediaType type) {
    return switch (type) {
      EducationalMediaType.video => l10n.hajjJourneyMediaVideo,
      EducationalMediaType.audio => l10n.hajjJourneyMediaAudio,
      EducationalMediaType.image => l10n.hajjJourneyMediaImage,
    };
  }
}
