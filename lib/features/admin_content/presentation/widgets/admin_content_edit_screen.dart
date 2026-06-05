import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
import 'package:rafiq_alhajj/features/admin_content/domain/models/content_editor_input.dart';
import 'package:rafiq_alhajj/features/admin_content/presentation/providers/admin_content_providers.dart';
import 'package:rafiq_alhajj/features/admin_content/presentation/utils/content_meta_l10n.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_item.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_type.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_visibility.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class AdminContentEditScreen extends ConsumerStatefulWidget {
  const AdminContentEditScreen({this.contentId, super.key});

  final String? contentId;

  @override
  ConsumerState<AdminContentEditScreen> createState() =>
      _AdminContentEditScreenState();
}

class _AdminContentEditScreenState extends ConsumerState<AdminContentEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _mediaUrlController = TextEditingController();

  ContentType _type = ContentType.news;
  ContentVisibility _visibility = ContentVisibility.public;
  bool _loaded = false;

  bool get _isEditing => widget.contentId != null;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _mediaUrlController.dispose();
    super.dispose();
  }

  void _bindItem(ContentItem item) {
    if (_loaded) {
      return;
    }
    _titleController.text = item.title;
    _descriptionController.text = item.description ?? '';
    _mediaUrlController.text = item.mediaUrl ?? '';
    _type = item.type;
    _visibility = item.visibility;
    _loaded = true;
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final l10n = AppLocalizations.of(context);
    final input = ContentEditorInput(
      id: widget.contentId,
      title: _titleController.text,
      description: _descriptionController.text,
      mediaUrl: _mediaUrlController.text,
      type: _type,
      visibility: _visibility,
    );

    final ok = await ref
        .read(adminContentSaveProvider.notifier)
        .save(input);

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

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isSaving = ref.watch(
      adminContentSaveProvider.select((state) => state.isLoading),
    );

    if (_isEditing) {
      final listAsync = ref.watch(adminContentListProvider);
      return listAsync.when(
        loading: () => Scaffold(
          appBar: AppBar(title: Text(l10n.adminContentEditTitle)),
          body: const Center(child: CircularProgressIndicator()),
        ),
        error: (_, _) => Scaffold(
          appBar: AppBar(title: Text(l10n.adminContentEditTitle)),
          body: Center(child: Text(l10n.adminContentLoadError)),
        ),
        data: (items) {
          ContentItem? item;
          for (final entry in items) {
            if (entry.id == widget.contentId) {
              item = entry;
              break;
            }
          }
          if (item == null) {
            return Scaffold(
              appBar: AppBar(title: Text(l10n.adminContentEditTitle)),
              body: Center(child: Text(l10n.adminContentNotFound)),
            );
          }
          _bindItem(item);
          return _buildForm(context, l10n, isSaving);
        },
      );
    }

    return _buildForm(context, l10n, isSaving);
  }

  Widget _buildForm(
    BuildContext context,
    AppLocalizations l10n,
    bool isSaving,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isEditing ? l10n.adminContentEditTitle : l10n.adminContentNewTitle,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: isSaving ? null : () => context.pop(),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.w),
          children: [
            TextFormField(
              controller: _titleController,
              enabled: !isSaving,
              decoration: InputDecoration(labelText: l10n.adminContentTitleLabel),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return l10n.adminContentTitleRequired;
                }
                return null;
              },
            ),
            SizedBox(height: 16.h),
            TextFormField(
              controller: _descriptionController,
              enabled: !isSaving,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: l10n.adminContentDescriptionLabel,
              ),
            ),
            SizedBox(height: 16.h),
            TextFormField(
              controller: _mediaUrlController,
              enabled: !isSaving,
              decoration: InputDecoration(
                labelText: l10n.adminContentMediaUrlLabel,
              ),
              keyboardType: TextInputType.url,
            ),
            SizedBox(height: 16.h),
            DropdownButtonFormField<ContentType>(
              key: ValueKey(_type),
              initialValue: _type,
              decoration: InputDecoration(labelText: l10n.adminContentTypeLabel),
              items: ContentType.values
                  .map(
                    (type) => DropdownMenuItem(
                      value: type,
                      child: Text(contentTypeLabel(l10n, type)),
                    ),
                  )
                  .toList(),
              onChanged: isSaving
                  ? null
                  : (value) {
                      if (value != null) {
                        setState(() => _type = value);
                      }
                    },
            ),
            SizedBox(height: 16.h),
            DropdownButtonFormField<ContentVisibility>(
              key: ValueKey(_visibility),
              initialValue: _visibility,
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
              onChanged: isSaving
                  ? null
                  : (value) {
                      if (value != null) {
                        setState(() => _visibility = value);
                      }
                    },
            ),
            SizedBox(height: 24.h),
            FilledButton(
              onPressed: isSaving ? null : _submit,
              child: isSaving
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(l10n.adminContentSave),
            ),
          ],
        ),
      ),
    );
  }
}
