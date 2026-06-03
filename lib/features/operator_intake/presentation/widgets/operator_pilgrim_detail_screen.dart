import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
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

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final detailAsync =
        ref.watch(operatorPilgrimDetailProvider(widget.profileId));

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.operatorPilgrimDetailTitle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: _isSaving ? null : () => context.pop(),
        ),
      ),
      body: detailAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => Center(child: Text(l10n.operatorPilgrimListLoadError)),
        data: (record) {
          if (record == null) {
            return Center(child: Text(l10n.operatorPilgrimNotFound));
          }

          _bindRecord(record);

          return Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(24.w),
              children: [
                Text(
                  record.fullName,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                SizedBox(height: 8.h),
                Text(
                  l10n.operatorPilgrimDetailSubtitle,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                SizedBox(height: 24.h),
                Text(
                  l10n.pilgrimLogisticsTitle,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(height: 12.h),
                Wrap(
                  spacing: 16.w,
                  runSpacing: 16.h,
                  children: [
                    _field(_passportController, l10n.operatorPassport, 280.w),
                    _field(_permitController, l10n.operatorTravelPermit, 280.w),
                    _field(_medicalController, l10n.pilgrimMedicalStatus, 280.w),
                    SizedBox(
                      width: 280.w,
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(l10n.pilgrimTravelDate),
                        subtitle: Text(
                          _travelDate == null
                              ? l10n.operatorPilgrimTravelDateUnset
                              : MaterialLocalizations.of(context)
                                  .formatMediumDate(_travelDate!),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.calendar_today),
                          onPressed: _isSaving ? null : _pickTravelDate,
                        ),
                      ),
                    ),
                    _field(_hotelController, l10n.pilgrimHotel, 280.w),
                    _field(_hotelUrlController, l10n.operatorHotelMapUrl, 320.w),
                    _field(_transportController, l10n.pilgrimTransport, 320.w),
                  ],
                ),
                SizedBox(height: 24.h),
                FilledButton(
                  onPressed: _isSaving ? null : _save,
                  child: _isSaving
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(l10n.operatorPilgrimSave),
                ),
              ],
            ),
          );
        },
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

  Widget _field(TextEditingController controller, String label, double width) {
    return SizedBox(
      width: width,
      child: TextFormField(
        controller: controller,
        enabled: !_isSaving,
        decoration: InputDecoration(labelText: label),
      ),
    );
  }
}
