import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
import 'package:rafiq_alhajj/core/routing/staff_navigation.dart';
import 'package:rafiq_alhajj/core/widgets/rafiq_app_bar.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_layout.dart';
import 'package:rafiq_alhajj/features/support_contacts/domain/models/support_contact.dart';
import 'package:rafiq_alhajj/features/support_contacts/domain/models/support_contact_input.dart';
import 'package:rafiq_alhajj/features/support_contacts/presentation/providers/support_contacts_providers.dart';
import 'package:rafiq_alhajj/features/support_contacts/presentation/widgets/admin_support_contact_edit_form.dart';
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

  Widget _buildScaffold(AppLocalizations l10n, bool isSaving) {
    final title = _isEditing
        ? l10n.adminSupportContactEditTitle
        : l10n.adminSupportContactNewTitle;

    final form = AdminSupportContactEditForm(
      form: _form,
      scope: _scope,
      groupId: _groupId,
      isActive: _isActive,
      isSaving: isSaving,
      onScopeChanged: (value) => setState(() => _scope = value),
      onGroupChanged: (value) => setState(() => _groupId = value),
      onActiveChanged: (value) => setState(() => _isActive = value),
    );

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
          return _buildScaffold(l10n, isSaving);
        },
      );
    }

    return _buildScaffold(l10n, isSaving);
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
