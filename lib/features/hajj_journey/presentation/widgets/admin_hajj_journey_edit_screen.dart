import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/widgets/rafiq_app_bar.dart';
import 'package:rafiq_alhajj/features/hajj_journey/domain/models/hajj_journey_media.dart';
import 'package:rafiq_alhajj/features/hajj_journey/domain/models/hajj_journey_step.dart';
import 'package:rafiq_alhajj/features/hajj_journey/presentation/providers/hajj_journey_providers.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class AdminHajjJourneyEditScreen extends ConsumerStatefulWidget {
  const AdminHajjJourneyEditScreen({required this.ritualKey, super.key});

  final String ritualKey;

  @override
  ConsumerState<AdminHajjJourneyEditScreen> createState() =>
      _AdminHajjJourneyEditScreenState();
}

class _MediaDraft {
  _MediaDraft({
    required this.mediaType,
    required this.urlController,
    required this.titleController,
  });

  HajjMediaType mediaType;
  final TextEditingController urlController;
  final TextEditingController titleController;

  HajjJourneyMediaInput toInput(int sortOrder) => HajjJourneyMediaInput(
        mediaType: mediaType,
        url: urlController.text.trim(),
        title: titleController.text.trim().isEmpty
            ? null
            : titleController.text.trim(),
        sortOrder: sortOrder,
      );
}

class _AdminHajjJourneyEditScreenState
    extends ConsumerState<AdminHajjJourneyEditScreen> {
  final _titleArController = TextEditingController();
  final _titleEnController = TextEditingController();
  final _descriptionArController = TextEditingController();
  final _descriptionEnController = TextEditingController();
  final _sortOrderController = TextEditingController(text: '1');
  bool _isActive = true;
  final List<_MediaDraft> _media = [];
  bool _initialized = false;

  @override
  void dispose() {
    _titleArController.dispose();
    _titleEnController.dispose();
    _descriptionArController.dispose();
    _descriptionEnController.dispose();
    _sortOrderController.dispose();
    for (final item in _media) {
      item.urlController.dispose();
      item.titleController.dispose();
    }
    super.dispose();
  }

  void _populate(HajjJourneyStep step) {
    if (_initialized) {
      return;
    }
    _titleArController.text = step.titleAr;
    _titleEnController.text = step.titleEn;
    _descriptionArController.text = step.descriptionAr;
    _descriptionEnController.text = step.descriptionEn;
    _sortOrderController.text = '${step.sortOrder}';
    _isActive = step.isActive;
    for (final m in step.media) {
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

  void _addMedia() {
    setState(() {
      _media.add(
        _MediaDraft(
          mediaType: HajjMediaType.image,
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
    final sortOrder = int.tryParse(_sortOrderController.text.trim()) ?? 1;

    final input = HajjJourneyEditorInput(
      ritualKey: widget.ritualKey,
      sortOrder: sortOrder,
      titleAr: _titleArController.text.trim(),
      titleEn: _titleEnController.text.trim(),
      descriptionAr: _descriptionArController.text.trim(),
      descriptionEn: _descriptionEnController.text.trim(),
      isActive: _isActive,
    );

    if (input.titleAr.isEmpty || input.titleEn.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.adminHajjJourneyTitleRequired)),
      );
      return;
    }

    final media = [
      for (var i = 0; i < _media.length; i++)
        if (_media[i].urlController.text.trim().isNotEmpty)
          _media[i].toInput(i + 1),
    ];

    await ref.read(adminHajjJourneySaveProvider.notifier).save(
          ritualKey: widget.ritualKey,
          input: input,
          media: media,
        );

    if (!mounted) {
      return;
    }

    final saveState = ref.read(adminHajjJourneySaveProvider);
    if (saveState.hasError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.adminHajjJourneySaveError)),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n.adminHajjJourneySaveSuccess)),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final stepAsync = ref.watch(adminHajjJourneyStepProvider(widget.ritualKey));
    final isSaving = ref.watch(adminHajjJourneySaveProvider).isLoading;

    return Scaffold(
      appBar: RafiqAppBar(
        title: Text(l10n.adminHajjJourneyEditTitle),
        actions: [
          TextButton(
            onPressed: isSaving ? null : _save,
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
      body: stepAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => Center(child: Text(l10n.adminHajjJourneyLoadError)),
        data: (step) {
          if (step != null) {
            _populate(step);
          }

          return ListView(
            padding: EdgeInsets.all(16.w),
            children: [
              TextField(
                controller: _titleArController,
                decoration: InputDecoration(
                  labelText: l10n.adminHajjJourneyTitleAr,
                ),
              ),
              SizedBox(height: 12.h),
              TextField(
                controller: _titleEnController,
                decoration: InputDecoration(
                  labelText: l10n.adminHajjJourneyTitleEn,
                ),
              ),
              SizedBox(height: 12.h),
              TextField(
                controller: _descriptionArController,
                decoration: InputDecoration(
                  labelText: l10n.adminHajjJourneyDescriptionAr,
                ),
                minLines: 4,
                maxLines: 8,
              ),
              SizedBox(height: 12.h),
              TextField(
                controller: _descriptionEnController,
                decoration: InputDecoration(
                  labelText: l10n.adminHajjJourneyDescriptionEn,
                ),
                minLines: 4,
                maxLines: 8,
              ),
              SizedBox(height: 12.h),
              TextField(
                controller: _sortOrderController,
                decoration: InputDecoration(
                  labelText: l10n.adminHajjJourneySortOrder,
                ),
                keyboardType: TextInputType.number,
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
                      l10n.adminHajjJourneyMediaSection,
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
                        DropdownButtonFormField<HajjMediaType>(
                          initialValue: _media[i].mediaType,
                          decoration: InputDecoration(
                            labelText: l10n.adminHajjJourneyMediaType,
                          ),
                          items: HajjMediaType.values
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
                        ),
                        SizedBox(height: 8.h),
                        TextField(
                          controller: _media[i].urlController,
                          decoration: InputDecoration(
                            labelText: l10n.adminHajjJourneyMediaUrl,
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
            ],
          );
        },
      ),
    );
  }

  String _mediaTypeLabel(AppLocalizations l10n, HajjMediaType type) {
    return switch (type) {
      HajjMediaType.video => l10n.hajjJourneyMediaVideo,
      HajjMediaType.audio => l10n.hajjJourneyMediaAudio,
      HajjMediaType.image => l10n.hajjJourneyMediaImage,
    };
  }
}
