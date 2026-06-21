import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/core/platform/app_platform.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
import 'package:rafiq_alhajj/core/routing/staff_navigation.dart';
import 'package:rafiq_alhajj/core/widgets/rafiq_app_bar.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_layout.dart';
import 'package:rafiq_alhajj/features/auth/domain/models/app_user_role.dart';
import 'package:rafiq_alhajj/features/auth/presentation/providers/auth_session_provider.dart';
import 'package:rafiq_alhajj/features/operator_intake/data/repositories/operator_registry_repository.dart';
import 'package:rafiq_alhajj/features/operator_intake/domain/models/operator_pilgrim_record.dart';
import 'package:rafiq_alhajj/features/operator_intake/domain/models/operator_pilgrim_update.dart';
import 'package:rafiq_alhajj/features/operator_intake/presentation/forms/pilgrim_field_catalog.dart';
import 'package:rafiq_alhajj/features/operator_intake/presentation/providers/operator_registry_providers.dart';
import 'package:rafiq_alhajj/features/operator_intake/presentation/widgets/pilgrim_fields_form.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';
import 'package:reactive_forms/reactive_forms.dart';

class OperatorPilgrimDetailScreen extends ConsumerStatefulWidget {
  const OperatorPilgrimDetailScreen({required this.pilgrimId, super.key});

  final String pilgrimId;

  @override
  ConsumerState<OperatorPilgrimDetailScreen> createState() =>
      _OperatorPilgrimDetailScreenState();
}

class _OperatorPilgrimDetailScreenState
    extends ConsumerState<OperatorPilgrimDetailScreen> {
  late final FormGroup _form;
  bool _initialized = false;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _form = PilgrimFormCatalog.buildFormGroup()
      ..addAll({'groupId': FormControl<String?>()});
  }

  @override
  void dispose() {
    _form.dispose();
    super.dispose();
  }

  void _bindRecord(OperatorPilgrimRecord record) {
    if (_initialized) {
      return;
    }
    PilgrimFormCatalog.bind(_form, record.raw);
    _form.control('groupId').updateValue(record.groupId);
    _initialized = true;
  }

  void _cancel() {
    staffNavigateBack(context, fallbackRoute: AppRoutes.operatorPilgrims);
  }

  Future<void> _save() async {
    if (!_form.valid) {
      _form.markAllAsTouched();
      return;
    }

    setState(() => _isSaving = true);
    final l10n = AppLocalizations.of(context);
    final isAdmin = ref.read(authAccessModeProvider) == AppAccessMode.admin;

    final ok = await ref
        .read(operatorPilgrimDetailProvider(widget.pilgrimId).notifier)
        .save(
          update: OperatorPilgrimUpdate(
            person: PilgrimFormCatalog.payload(_form, PilgrimFieldTable.person),
            enrollment: PilgrimFormCatalog.payload(
              _form,
              PilgrimFieldTable.enrollment,
            ),
            groupId: isAdmin ? _form.control('groupId').value as String? : null,
          ),
          includeProfileFields: isAdmin,
        );

    if (!mounted) {
      return;
    }

    setState(() => _isSaving = false);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          ok ? l10n.operatorPilgrimSaveSuccess : l10n.operatorPilgrimSaveError,
        ),
      ),
    );
  }

  Widget _buildForm(
    AppLocalizations l10n,
    OperatorPilgrimRecord record,
    List<PilgrimGroupOption> groups,
    bool isAdmin,
  ) {
    return ReactiveForm(
      formGroup: _form,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (isAdmin) ...[
            StaffFormSection(
              icon: Icons.groups_outlined,
              title: l10n.staffTableFilterGroup,
              child: ReactiveDropdownField<String?>(
                formControlName: 'groupId',
                decoration: InputDecoration(
                  labelText: l10n.staffTableFilterGroup,
                ),
                items: [
                  DropdownMenuItem(child: Text(l10n.staffTableFilterAll)),
                  ...groups.map(
                    (group) => DropdownMenuItem(
                      value: group.id,
                      child: Text(group.name),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
          ],
          PilgrimFieldsForm(enabled: !_isSaving),
          if (!AppPlatform.isWeb) ...[
            SizedBox(height: 24.h),
            FilledButton(
              onPressed: _isSaving ? null : _save,
              style: FilledButton.styleFrom(minimumSize: Size.fromHeight(48.h)),
              child: _isSaving
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(l10n.operatorPilgrimSave),
            ),
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isAdmin = ref.watch(authAccessModeProvider) == AppAccessMode.admin;
    final detailAsync =
        ref.watch(operatorPilgrimDetailProvider(widget.pilgrimId));
    final groupsAsync = ref.watch(pilgrimGroupFilterOptionsProvider);

    return groupsAsync.when(
      loading: () => _scaffold(
        l10n,
        const Center(child: CircularProgressIndicator()),
      ),
      error: (_, _) => _scaffold(
        l10n,
        StaffEmptyState(message: l10n.adminGroupsLoadError),
      ),
      data: (groups) => detailAsync.when(
        loading: () => _scaffold(
          l10n,
          const Center(child: CircularProgressIndicator()),
        ),
        error: (_, _) => _scaffold(
          l10n,
          StaffEmptyState(message: l10n.operatorPilgrimListLoadError),
        ),
        data: (record) {
          if (record == null) {
            return _scaffold(
              l10n,
              StaffEmptyState(message: l10n.operatorPilgrimNotFound),
            );
          }

          _bindRecord(record);
          final form = _buildForm(l10n, record, groups, isAdmin);

          return StaffAdaptivePage(
            web: StaffWebPage(
              title: l10n.operatorPilgrimDetailTitle,
              subtitle: record.fullName,
              body: form,
              bottomBar: StaffFormActionsBar(
                primaryLabel: l10n.operatorPilgrimSave,
                onPrimary: _save,
                secondaryLabel: l10n.dialogCancel,
                onSecondary: _isSaving ? null : _cancel,
                isLoading: _isSaving,
              ),
            ),
            mobile: Scaffold(
              appBar: RafiqAppBar(
                title: Text(l10n.operatorPilgrimDetailTitle),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: _isSaving ? null : _cancel,
                ),
              ),
              body: SingleChildScrollView(
                padding: EdgeInsets.all(16.w),
                child: form,
              ),
              bottomNavigationBar: StaffFormMobileActionsBar(
                primaryLabel: l10n.operatorPilgrimSave,
                onPrimary: _save,
                secondaryLabel: l10n.dialogCancel,
                onSecondary: _isSaving ? null : _cancel,
                isLoading: _isSaving,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _scaffold(AppLocalizations l10n, Widget body) {
    return StaffAdaptivePage(
      web: StaffWebPage(title: l10n.operatorPilgrimDetailTitle, body: body),
      mobile: Scaffold(
        appBar: RafiqAppBar(title: Text(l10n.operatorPilgrimDetailTitle)),
        body: body,
      ),
    );
  }
}
