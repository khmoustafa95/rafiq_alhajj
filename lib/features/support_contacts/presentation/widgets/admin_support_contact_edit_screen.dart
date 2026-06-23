import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
import 'package:rafiq_alhajj/core/routing/staff_navigation.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/widgets/rafiq_app_bar.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_layout.dart';
import 'package:rafiq_alhajj/features/notifications/presentation/providers/notification_providers.dart';
import 'package:rafiq_alhajj/features/support_contacts/domain/models/support_contact.dart';
import 'package:rafiq_alhajj/features/support_contacts/domain/models/support_contact_input.dart';
import 'package:rafiq_alhajj/features/support_contacts/presentation/providers/support_contacts_providers.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';
import 'package:reactive_forms/reactive_forms.dart';

class AdminSupportContactEditScreen extends ConsumerStatefulWidget {
  const AdminSupportContactEditScreen({this.contactId, super.key});

  final String? contactId;

  @override
  ConsumerState<AdminSupportContactEditScreen> createState() =>
      _AdminSupportContactEditScreenState();
}

class _AdminSupportContactEditScreenState
    extends ConsumerState<AdminSupportContactEditScreen> {
  late final FormGroup _form;
  SupportContactScope _scope = SupportContactScope.global;
  String? _groupId;
  bool _isActive = true;
  bool _loaded = false;

  bool get _isEditing => widget.contactId != null;

  @override
  void initState() {
    super.initState();
    _form = FormGroup({
      'labelAr': FormControl<String>(value: '', validators: [Validators.required]),
      'labelEn': FormControl<String>(value: '', validators: [Validators.required]),
      'descriptionAr': FormControl<String>(value: ''),
      'descriptionEn': FormControl<String>(value: ''),
      'phoneNumber': FormControl<String>(value: ''),
      'whatsappNumber': FormControl<String>(value: ''),
      'sortOrder': FormControl<String>(value: '0'),
    });
  }

  @override
  void dispose() {
    _form.dispose();
    super.dispose();
  }

  void _bind(SupportContact contact) {
    if (_loaded) {
      return;
    }
    _form.control('labelAr').updateValue(contact.labelAr);
    _form.control('labelEn').updateValue(contact.labelEn);
    _form.control('descriptionAr').updateValue(contact.descriptionAr ?? '');
    _form.control('descriptionEn').updateValue(contact.descriptionEn ?? '');
    _form.control('phoneNumber').updateValue(contact.phoneNumber ?? '');
    _form.control('whatsappNumber').updateValue(contact.whatsappNumber ?? '');
    _form.control('sortOrder').updateValue('${contact.sortOrder}');
    _scope = contact.scope;
    _groupId = contact.groupId;
    _isActive = contact.isActive;
    _loaded = true;
  }

  void _cancel() {
    staffNavigateBack(context, fallbackRoute: AppRoutes.adminSupportContacts);
  }

  String? _trim(String name) {
    final value = (_form.control(name).value as String?)?.trim();
    return (value == null || value.isEmpty) ? null : value;
  }

  Future<void> _submit() async {
    final l10n = AppLocalizations.of(context);
    if (!_form.valid) {
      _form.markAllAsTouched();
      return;
    }

    final phone = _trim('phoneNumber');
    final whatsapp = _trim('whatsappNumber');
    if (phone == null && whatsapp == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.adminSupportContactChannelRequired)),
      );
      return;
    }

    if (_scope == SupportContactScope.group && _groupId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.adminSupportContactGroupRequired)),
      );
      return;
    }

    final input = SupportContactInput(
      id: widget.contactId,
      labelAr: _form.control('labelAr').value as String,
      labelEn: _form.control('labelEn').value as String,
      descriptionAr: _trim('descriptionAr'),
      descriptionEn: _trim('descriptionEn'),
      phoneNumber: phone,
      whatsappNumber: whatsapp,
      scope: _scope,
      groupId: _scope == SupportContactScope.group ? _groupId : null,
      isActive: _isActive,
      sortOrder: int.tryParse(_trim('sortOrder') ?? '0') ?? 0,
    );

    final ok = await ref.read(supportContactSaveProvider.notifier).save(input);
    if (!mounted) {
      return;
    }

    if (ok) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isEditing
                ? l10n.adminSupportContactSaveSuccess
                : l10n.adminSupportContactCreateSuccess,
          ),
        ),
      );
      _cancel();
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n.adminSupportContactSaveError)),
    );
  }

  Widget _buildForm(AppLocalizations l10n, bool isSaving) {
    final groupsAsync = ref.watch(notificationGroupsProvider);

    final form = ReactiveForm(
      formGroup: _form,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          StaffFormSection(
            icon: Icons.contact_phone_outlined,
            title: l10n.adminSupportContactDetailsSection,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ResponsiveFormGrid(
                  children: [
                    ReactiveTextField<String>(
                      formControlName: 'labelAr',
                      decoration: InputDecoration(
                        labelText: l10n.adminSupportContactLabelAr,
                      ),
                      validationMessages: {
                        ValidationMessage.required: (_) =>
                            l10n.adminSupportContactLabelRequired,
                      },
                    ),
                    ReactiveTextField<String>(
                      formControlName: 'labelEn',
                      decoration: InputDecoration(
                        labelText: l10n.adminSupportContactLabelEn,
                      ),
                      validationMessages: {
                        ValidationMessage.required: (_) =>
                            l10n.adminSupportContactLabelRequired,
                      },
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                ResponsiveFormGrid(
                  children: [
                    ReactiveTextField<String>(
                      formControlName: 'descriptionAr',
                      maxLines: 2,
                      decoration: InputDecoration(
                        labelText: l10n.adminSupportContactDescriptionAr,
                      ),
                    ),
                    ReactiveTextField<String>(
                      formControlName: 'descriptionEn',
                      maxLines: 2,
                      decoration: InputDecoration(
                        labelText: l10n.adminSupportContactDescriptionEn,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                ResponsiveFormGrid(
                  children: [
                    ReactiveTextField<String>(
                      formControlName: 'phoneNumber',
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: l10n.adminSupportContactPhone,
                      ),
                    ),
                    ReactiveTextField<String>(
                      formControlName: 'whatsappNumber',
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: l10n.adminSupportContactWhatsapp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          StaffFormSection(
            icon: Icons.tune_rounded,
            title: l10n.adminSupportContactScopeSection,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DropdownButtonFormField<SupportContactScope>(
                  initialValue: _scope,
                  decoration: InputDecoration(
                    labelText: l10n.adminSupportContactScope,
                  ),
                  items: [
                    DropdownMenuItem(
                      value: SupportContactScope.global,
                      child: Text(l10n.adminSupportContactScopeGlobal),
                    ),
                    DropdownMenuItem(
                      value: SupportContactScope.group,
                      child: Text(l10n.adminSupportContactScopeGroup),
                    ),
                  ],
                  onChanged: isSaving
                      ? null
                      : (value) => setState(
                            () => _scope = value ?? SupportContactScope.global,
                          ),
                ),
                if (_scope == SupportContactScope.group) ...[
                  SizedBox(height: 16.h),
                  groupsAsync.when(
                    loading: () => const LinearProgressIndicator(),
                    error: (_, _) => Text(
                      l10n.adminNotificationGroupsEmpty,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    data: (groups) {
                      if (groups.isEmpty) {
                        return Text(l10n.adminNotificationGroupsEmpty);
                      }
                      final hasValue =
                          groups.any((group) => group.id == _groupId);
                      return DropdownButtonFormField<String>(
                        initialValue: hasValue ? _groupId : null,
                        decoration: InputDecoration(
                          labelText: l10n.adminSupportContactGroup,
                        ),
                        items: [
                          for (final group in groups)
                            DropdownMenuItem(
                              value: group.id,
                              child: Text(group.name),
                            ),
                        ],
                        onChanged: isSaving
                            ? null
                            : (value) => setState(() => _groupId = value),
                      );
                    },
                  ),
                ],
                SizedBox(height: 8.h),
                ResponsiveFormGrid(
                  children: [
                    ReactiveTextField<String>(
                      formControlName: 'sortOrder',
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: l10n.adminSupportContactSortOrder,
                      ),
                    ),
                  ],
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  value: _isActive,
                  onChanged:
                      isSaving ? null : (value) => setState(() => _isActive = value),
                  title: Text(l10n.adminSupportContactActive),
                  subtitle: Text(
                    l10n.adminSupportContactActiveHint,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    final title = _isEditing
        ? l10n.adminSupportContactEditTitle
        : l10n.adminSupportContactNewTitle;

    return StaffAdaptivePage(
      web: StaffWebPage(
        title: title,
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
          title: Text(title),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: isSaving ? null : _cancel,
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: form,
        ),
        bottomNavigationBar: StaffFormMobileActionsBar(
          primaryLabel: l10n.adminContentSave,
          onPrimary: _submit,
          secondaryLabel: l10n.dialogCancel,
          onSecondary: isSaving ? null : _cancel,
          isLoading: isSaving,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isSaving = ref.watch(
      supportContactSaveProvider.select((state) => state.isLoading),
    );

    if (_isEditing) {
      final contactsAsync = ref.watch(adminSupportContactsProvider);
      return contactsAsync.when(
        skipLoadingOnReload: true,
        loading: () => _scaffoldLoading(l10n),
        error: (_, _) => _scaffoldLoading(l10n),
        data: (contacts) {
          final match = contacts.where((c) => c.id == widget.contactId);
          if (match.isNotEmpty) {
            _bind(match.first);
          }
          return _buildForm(l10n, isSaving);
        },
      );
    }

    return _buildForm(l10n, isSaving);
  }

  Widget _scaffoldLoading(AppLocalizations l10n) {
    return StaffAdaptivePage(
      web: StaffWebPage(
        title: l10n.adminSupportContactEditTitle,
        body: const Center(child: CircularProgressIndicator()),
      ),
      mobile: Scaffold(
        appBar: RafiqAppBar(title: Text(l10n.adminSupportContactEditTitle)),
        body: const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
