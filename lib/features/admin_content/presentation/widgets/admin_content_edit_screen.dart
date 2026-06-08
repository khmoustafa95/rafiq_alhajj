import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
import 'package:rafiq_alhajj/core/routing/staff_navigation.dart';
import 'package:rafiq_alhajj/core/widgets/rafiq_app_bar.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_layout.dart';
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

  String get _pageTitle {
    final l10n = AppLocalizations.of(context);
    return _isEditing ? l10n.adminContentEditTitle : l10n.adminContentNewTitle;
  }

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

  void _cancel() {
    staffNavigateBack(context, fallbackRoute: AppRoutes.adminContent);
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

  Widget _errorState(AppLocalizations l10n, String message) {
    return StaffAdaptivePage(
      web: StaffWebPage(
        title: _pageTitle,
        body: StaffEmptyState(message: message),
      ),
      mobile: Scaffold(
        appBar: RafiqAppBar(title: Text(_pageTitle)),
        body: Center(child: Text(message)),
      ),
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
        loading: () => _loadingState(l10n),
        error: (_, _) => _errorState(l10n, l10n.adminContentLoadError),
        data: (items) {
          ContentItem? item;
          for (final entry in items) {
            if (entry.id == widget.contentId) {
              item = entry;
              break;
            }
          }
          if (item == null) {
            return _errorState(l10n, l10n.adminContentNotFound);
          }
          _bindItem(item);
          return _buildForm(l10n, isSaving);
        },
      );
    }

    return _buildForm(l10n, isSaving);
  }

  Widget _buildForm(AppLocalizations l10n, bool isSaving) {
    final form = Form(
      key: _formKey,
      child: StaffFormSection(
        icon: Icons.article_outlined,
        title: l10n.adminContentListTitle,
        child: ResponsiveFormGrid(
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
            TextFormField(
              controller: _mediaUrlController,
              enabled: !isSaving,
              decoration: InputDecoration(
                labelText: l10n.adminContentMediaUrlLabel,
              ),
              keyboardType: TextInputType.url,
            ),
            TextFormField(
              controller: _descriptionController,
              enabled: !isSaving,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: l10n.adminContentDescriptionLabel,
              ),
            ),
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
