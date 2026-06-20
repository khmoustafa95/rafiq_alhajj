import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/core/platform/app_platform.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
import 'package:rafiq_alhajj/core/routing/staff_navigation.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/widgets/rafiq_app_bar.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_layout.dart';
import 'package:rafiq_alhajj/features/auth/domain/models/app_user_role.dart';
import 'package:rafiq_alhajj/features/auth/presentation/providers/auth_session_provider.dart';
import 'package:rafiq_alhajj/features/operator_intake/data/repositories/operator_registry_repository.dart';
import 'package:rafiq_alhajj/features/operator_intake/domain/models/operator_pilgrim_record.dart';
import 'package:rafiq_alhajj/features/operator_intake/domain/models/operator_pilgrim_update.dart';
import 'package:rafiq_alhajj/features/operator_intake/presentation/providers/operator_registry_providers.dart';
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
  DateTime? _travelDate;
  bool _initialized = false;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _form = FormGroup({
      'fullName': FormControl<String>(value: '', validators: [Validators.required]),
      'gender': FormControl<String?>(),
      'groupId': FormControl<String?>(),
      'passport': FormControl<String>(value: ''),
      'permit': FormControl<String>(value: ''),
      'medical': FormControl<String>(value: ''),
      'hotel': FormControl<String>(value: ''),
      'hotelUrl': FormControl<String>(value: ''),
      'transport': FormControl<String>(value: ''),
    });
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
    _form.control('passport').updateValue(record.passportNumber ?? '');
    _form.control('fullName').updateValue(record.fullName);
    _form.control('gender').updateValue(record.gender);
    _form.control('groupId').updateValue(record.groupId);
    _form.control('permit').updateValue(record.travelPermitNumber ?? '');
    _form.control('medical').updateValue(record.medicalTestStatus ?? '');
    _form.control('hotel').updateValue(record.hotelName ?? '');
    _form.control('hotelUrl').updateValue(record.hotelLocationUrl ?? '');
    _form.control('transport').updateValue(record.transportationDetails ?? '');
    _travelDate = record.travelDate;
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
            fullName: isAdmin ? _form.control('fullName').value as String : null,
            groupId: isAdmin ? _form.control('groupId').value as String? : null,
            gender: _form.control('gender').value as String?,
            passportNumber: _form.control('passport').value as String? ?? '',
            travelPermitNumber: _form.control('permit').value as String? ?? '',
            medicalTestStatus: _form.control('medical').value as String? ?? '',
            travelDate: _travelDate,
            hotelName: _form.control('hotel').value as String? ?? '',
            hotelLocationUrl: _form.control('hotelUrl').value as String? ?? '',
            transportationDetails:
                _form.control('transport').value as String? ?? '',
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

  Future<void> _pickTravelDate() async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
      initialDate: _travelDate ?? DateTime.now(),
    );
    if (picked != null) {
      setState(() => _travelDate = picked);
    }
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
          if (isAdmin)
            StaffFormSection(
              icon: Icons.person_outline,
              title: l10n.adminPilgrimProfileSection,
              child: ResponsiveFormGrid(
                maxColumns: 3,
                children: [
                  ReactiveTextField<String>(
                    formControlName: 'fullName',
                    decoration: InputDecoration(labelText: l10n.operatorFullName),
                    validationMessages: {
                      ValidationMessage.required: (_) =>
                          l10n.adminOperatorFullNameRequired,
                    },
                  ),
                  ReactiveDropdownField<String?>(
                    formControlName: 'gender',
                    decoration: InputDecoration(
                      labelText: l10n.staffTableFilterGender,
                    ),
                    items: [
                      DropdownMenuItem(
                        child: Text(l10n.staffTableFilterAll),
                      ),
                      DropdownMenuItem(
                        value: 'male',
                        child: Text(l10n.pilgrimGenderMale),
                      ),
                      DropdownMenuItem(
                        value: 'female',
                        child: Text(l10n.pilgrimGenderFemale),
                      ),
                    ],
                  ),
                  ReactiveDropdownField<String?>(
                    formControlName: 'groupId',
                    decoration: InputDecoration(
                      labelText: l10n.staffTableFilterGroup,
                    ),
                    items: [
                      DropdownMenuItem(
                        child: Text(l10n.staffTableFilterAll),
                      ),
                      ...groups.map(
                        (group) => DropdownMenuItem(
                          value: group.id,
                          child: Text(group.name),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          else
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 28.r,
                    backgroundColor: AppColors.primary,
                    child: Text(
                      record.fullName.isNotEmpty
                          ? record.fullName[0].toUpperCase()
                          : '?',
                      style: TextStyle(
                        color: AppColors.onPrimary,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          record.fullName,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          l10n.operatorPilgrimDetailSubtitle,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.textSecondary,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          SizedBox(height: 16.h),
          StaffFormSection(
            icon: Icons.flight_takeoff_outlined,
            title: l10n.pilgrimLogisticsTitle,
            child: ResponsiveFormGrid(
              maxColumns: 3,
              children: [
                ReactiveTextField<String>(
                  formControlName: 'passport',
                  decoration: InputDecoration(
                    labelText: l10n.operatorPassport,
                    prefixIcon: const Icon(Icons.credit_card_outlined),
                  ),
                ),
                ReactiveTextField<String>(
                  formControlName: 'permit',
                  decoration: InputDecoration(
                    labelText: l10n.operatorTravelPermit,
                    prefixIcon: const Icon(Icons.assignment_outlined),
                  ),
                ),
                ReactiveTextField<String>(
                  formControlName: 'medical',
                  decoration: InputDecoration(
                    labelText: l10n.pilgrimMedicalStatus,
                    prefixIcon: const Icon(Icons.medical_services_outlined),
                  ),
                ),
                StaffDateFormField(
                  label: l10n.pilgrimTravelDate,
                  value: _travelDate,
                  unsetLabel: l10n.operatorPilgrimTravelDateUnset,
                  onPick: _isSaving ? null : _pickTravelDate,
                  enabled: !_isSaving,
                ),
                ReactiveTextField<String>(
                  formControlName: 'hotel',
                  decoration: InputDecoration(
                    labelText: l10n.pilgrimHotel,
                    prefixIcon: const Icon(Icons.hotel_outlined),
                  ),
                ),
                ReactiveTextField<String>(
                  formControlName: 'hotelUrl',
                  keyboardType: TextInputType.url,
                  decoration: InputDecoration(
                    labelText: l10n.operatorHotelMapUrl,
                    prefixIcon: const Icon(Icons.map_outlined),
                  ),
                ),
                ReactiveTextField<String>(
                  formControlName: 'transport',
                  decoration: InputDecoration(
                    labelText: l10n.pilgrimTransport,
                    prefixIcon: const Icon(Icons.directions_bus_outlined),
                  ),
                ),
              ],
            ),
          ),
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
    if (_isSaving && _form.enabled) {
      _form.markAsDisabled();
    } else if (!_isSaving && _form.disabled) {
      _form.markAsEnabled();
    }
    final isAdmin = ref.watch(authAccessModeProvider) == AppAccessMode.admin;
    final detailAsync =
        ref.watch(operatorPilgrimDetailProvider(widget.pilgrimId));
    final groupsAsync = ref.watch(pilgrimGroupFilterOptionsProvider);

    return groupsAsync.when(
      loading: () => StaffAdaptivePage(
        web: StaffWebPage(
          title: l10n.operatorPilgrimDetailTitle,
          body: const Center(child: CircularProgressIndicator()),
        ),
        mobile: Scaffold(
          appBar: RafiqAppBar(title: Text(l10n.operatorPilgrimDetailTitle)),
          body: const Center(child: CircularProgressIndicator()),
        ),
      ),
      error: (_, _) => StaffAdaptivePage(
        web: StaffWebPage(
          title: l10n.operatorPilgrimDetailTitle,
          body: StaffEmptyState(message: l10n.adminGroupsLoadError),
        ),
        mobile: Scaffold(
          appBar: RafiqAppBar(title: Text(l10n.operatorPilgrimDetailTitle)),
          body: Center(child: Text(l10n.adminGroupsLoadError)),
        ),
      ),
      data: (groups) => detailAsync.when(
        loading: () => StaffAdaptivePage(
          web: StaffWebPage(
            title: l10n.operatorPilgrimDetailTitle,
            body: const Center(child: CircularProgressIndicator()),
          ),
          mobile: Scaffold(
            appBar: RafiqAppBar(title: Text(l10n.operatorPilgrimDetailTitle)),
            body: const Center(child: CircularProgressIndicator()),
          ),
        ),
        error: (_, _) => StaffAdaptivePage(
          web: StaffWebPage(
            title: l10n.operatorPilgrimDetailTitle,
            body: StaffEmptyState(message: l10n.operatorPilgrimListLoadError),
          ),
          mobile: Scaffold(
            appBar: RafiqAppBar(title: Text(l10n.operatorPilgrimDetailTitle)),
            body: Center(child: Text(l10n.operatorPilgrimListLoadError)),
          ),
        ),
        data: (record) {
          if (record == null) {
            return StaffAdaptivePage(
              web: StaffWebPage(
                title: l10n.operatorPilgrimDetailTitle,
                body: StaffEmptyState(message: l10n.operatorPilgrimNotFound),
              ),
              mobile: Scaffold(
                appBar: RafiqAppBar(title: Text(l10n.operatorPilgrimDetailTitle)),
                body: Center(child: Text(l10n.operatorPilgrimNotFound)),
              ),
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
}
