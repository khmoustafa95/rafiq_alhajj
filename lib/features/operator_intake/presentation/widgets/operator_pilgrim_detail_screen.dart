import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq_alhajj/core/platform/app_platform.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/widgets/rafiq_app_bar.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_layout.dart';
import 'package:rafiq_alhajj/features/operator_intake/domain/models/operator_pilgrim_record.dart';
import 'package:rafiq_alhajj/features/operator_intake/domain/models/operator_pilgrim_update.dart';
import 'package:rafiq_alhajj/features/operator_intake/presentation/providers/operator_registry_providers.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class OperatorPilgrimDetailScreen extends ConsumerStatefulWidget {
  const OperatorPilgrimDetailScreen({required this.profileId, super.key});

  final String profileId;

  @override
  ConsumerState<OperatorPilgrimDetailScreen> createState() =>
      _OperatorPilgrimDetailScreenState();
}

class _OperatorPilgrimDetailScreenState
    extends ConsumerState<OperatorPilgrimDetailScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passportController = TextEditingController();
  final _permitController = TextEditingController();
  final _medicalController = TextEditingController();
  final _hotelController = TextEditingController();
  final _hotelUrlController = TextEditingController();
  final _transportController = TextEditingController();
  DateTime? _travelDate;
  bool _initialized = false;
  bool _isSaving = false;

  @override
  void dispose() {
    _passportController.dispose();
    _permitController.dispose();
    _medicalController.dispose();
    _hotelController.dispose();
    _hotelUrlController.dispose();
    _transportController.dispose();
    super.dispose();
  }

  void _bindRecord(OperatorPilgrimRecord record) {
    if (_initialized) {
      return;
    }
    _passportController.text = record.passportNumber ?? '';
    _permitController.text = record.travelPermitNumber ?? '';
    _medicalController.text = record.medicalTestStatus ?? '';
    _hotelController.text = record.hotelName ?? '';
    _hotelUrlController.text = record.hotelLocationUrl ?? '';
    _transportController.text = record.transportationDetails ?? '';
    _travelDate = record.travelDate;
    _initialized = true;
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isSaving = true);
    final l10n = AppLocalizations.of(context);

    final ok = await ref
        .read(operatorPilgrimDetailProvider(widget.profileId).notifier)
        .save(
          update: OperatorPilgrimUpdate(
            passportNumber: _passportController.text,
            travelPermitNumber: _permitController.text,
            medicalTestStatus: _medicalController.text,
            travelDate: _travelDate,
            hotelName: _hotelController.text,
            hotelLocationUrl: _hotelUrlController.text,
            transportationDetails: _transportController.text,
          ),
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

  Widget _buildForm(AppLocalizations l10n, OperatorPilgrimRecord record) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
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
                TextFormField(
                  controller: _passportController,
                  enabled: !_isSaving,
                  decoration: InputDecoration(
                    labelText: l10n.operatorPassport,
                    prefixIcon: const Icon(Icons.credit_card_outlined),
                  ),
                ),
                TextFormField(
                  controller: _permitController,
                  enabled: !_isSaving,
                  decoration: InputDecoration(
                    labelText: l10n.operatorTravelPermit,
                    prefixIcon: const Icon(Icons.assignment_outlined),
                  ),
                ),
                TextFormField(
                  controller: _medicalController,
                  enabled: !_isSaving,
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
                TextFormField(
                  controller: _hotelController,
                  enabled: !_isSaving,
                  decoration: InputDecoration(
                    labelText: l10n.pilgrimHotel,
                    prefixIcon: const Icon(Icons.hotel_outlined),
                  ),
                ),
                TextFormField(
                  controller: _hotelUrlController,
                  enabled: !_isSaving,
                  keyboardType: TextInputType.url,
                  decoration: InputDecoration(
                    labelText: l10n.operatorHotelMapUrl,
                    prefixIcon: const Icon(Icons.map_outlined),
                  ),
                ),
                TextFormField(
                  controller: _transportController,
                  enabled: !_isSaving,
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
    final detailAsync =
        ref.watch(operatorPilgrimDetailProvider(widget.profileId));

    return detailAsync.when(
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
        final form = _buildForm(l10n, record);

        return StaffAdaptivePage(
          web: StaffWebPage(
            title: l10n.operatorPilgrimDetailTitle,
            subtitle: record.fullName,
            body: form,
            bottomBar: StaffFormActionsBar(
              primaryLabel: l10n.operatorPilgrimSave,
              onPrimary: _save,
              secondaryLabel: l10n.dialogCancel,
              onSecondary: _isSaving ? null : () => context.pop(),
              isLoading: _isSaving,
            ),
          ),
          mobile: Scaffold(
            appBar: RafiqAppBar(
              title: Text(l10n.operatorPilgrimDetailTitle),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: _isSaving ? null : () => context.pop(),
              ),
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: form,
            ),
          ),
        );
      },
    );
  }
}
