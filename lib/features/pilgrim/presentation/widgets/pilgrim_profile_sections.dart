import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/features/pilgrim/domain/models/pilgrim.dart';
import 'package:rafiq_alhajj/features/pilgrim/presentation/utils/pilgrim_profile_labels.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class PilgrimProfileSections extends StatelessWidget {
  const PilgrimProfileSections({
    required this.pilgrim,
    super.key,
  });

  final Pilgrim pilgrim;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    final sections = <_ProfileSection>[
      _ProfileSection(
        title: l10n.pilgrimSectionIdentity,
        icon: Icons.badge_outlined,
        rows: [
          _row(l10n.pilgrimLabelSequence, pilgrim.sequence),
          _row(l10n.pilgrimLabelCluster, pilgrim.cluster),
          _row(l10n.pilgrimLabelCoordinator, pilgrim.coordinatorName),
          _row(l10n.pilgrimLabelSticker, pilgrim.stickerNumber),
          _row(l10n.pilgrimLabelVisa, pilgrim.visaNumber),
          _row(l10n.pilgrimLabelBarcode, pilgrim.barcodeNumber),
          _row(l10n.pilgrimLabelFullNameAr, pilgrim.fullNameAr),
          _row(l10n.pilgrimLabelMotherAr, pilgrim.motherNameAr),
          _row(l10n.pilgrimLabelBirthDate, pilgrim.birthDate),
          _row(l10n.pilgrimLabelFirstNameEn, pilgrim.firstNameEn),
          _row(l10n.pilgrimLabelLastNameEn, pilgrim.lastNameEn),
          _row(l10n.pilgrimLabelFatherEn, pilgrim.fatherNameEn),
          _row(l10n.pilgrimLabelMotherEn, pilgrim.motherNameEn),
        ],
      ),
      _ProfileSection(
        title: l10n.pilgrimSectionTravelDocs,
        icon: Icons.card_travel_outlined,
        rows: [
          _row(l10n.operatorPassport, pilgrim.passportNumber),
          _row(l10n.pilgrimLabelPassportIssue, pilgrim.passportIssueDate),
          _row(l10n.pilgrimLabelPassportExpiry, pilgrim.passportExpiryDate),
          _row(l10n.operatorTravelPermit, pilgrim.travelPermitNumber),
        ],
      ),
      _ProfileSection(
        title: l10n.pilgrimSectionPersonal,
        icon: Icons.person_outline,
        rows: [
          _row(l10n.pilgrimLabelGender, pilgrim.gender),
          _row(l10n.pilgrimLabelBodySize, pilgrim.bodySize),
          _row(l10n.pilgrimLabelGroup, pilgrim.groupName),
          _row(l10n.pilgrimLabelCompanion, pilgrim.companionName),
          _row(l10n.pilgrimLabelRelation, pilgrim.relation),
        ],
      ),
      _ProfileSection(
        title: l10n.pilgrimSectionHousing,
        icon: Icons.home_work_outlined,
        rows: [
          _row(l10n.pilgrimLabelRequestType, pilgrim.requestType),
          _row(l10n.pilgrimLabelHousingType, pilgrim.housingType),
          _row(l10n.pilgrimLabelHadyStatus, pilgrim.hadyStatus),
          _row(l10n.pilgrimLabelResidence, pilgrim.residence),
        ],
      ),
      _ProfileSection(
        title: l10n.pilgrimSectionHealth,
        icon: Icons.health_and_safety_outlined,
        rows: [
          _row(l10n.pilgrimLabelHealthStatus, pilgrim.healthStatus),
          _row(
            l10n.pilgrimLabelWheelchair,
            PilgrimProfileLabels.yesNo(l10n, pilgrim.needsWheelchair),
          ),
          _row(
            l10n.pilgrimLabelSmoking,
            PilgrimProfileLabels.yesNo(l10n, pilgrim.isSmoking),
          ),
          _row(
            l10n.pilgrimLabelHealthCard,
            PilgrimProfileLabels.yesNo(l10n, pilgrim.healthCard),
          ),
          _row(
            l10n.pilgrimLabelVaccinated,
            PilgrimProfileLabels.yesNo(l10n, pilgrim.isVaccinated),
          ),
          _row(l10n.fieldOperatorMedicalLabel, pilgrim.medicalTestStatus),
        ],
      ),
      _ProfileSection(
        title: l10n.pilgrimSectionMakkah,
        icon: Icons.location_city_outlined,
        rows: [
          _row(l10n.pilgrimLabelMakkahHotel, pilgrim.makkahHotel ?? pilgrim.hotelName),
          _row(l10n.pilgrimLabelMakkahFloor, pilgrim.makkahFloor),
          _row(l10n.pilgrimLabelMakkahRoom, pilgrim.makkahRoom),
        ],
      ),
      _ProfileSection(
        title: l10n.pilgrimSectionMadinah,
        icon: Icons.mosque_outlined,
        rows: [
          _row(l10n.pilgrimLabelMadinahTravel, pilgrim.madinahTravelDate),
          _row(l10n.pilgrimLabelMadinahHotel, pilgrim.madinahHotel),
          _row(l10n.pilgrimLabelMadinahFloor, pilgrim.madinahFloor),
          _row(l10n.pilgrimLabelMadinahRoom, pilgrim.madinahRoom),
        ],
      ),
      _ProfileSection(
        title: l10n.pilgrimSectionDepartureFlight,
        icon: Icons.flight_takeoff,
        rows: [
          _row(l10n.pilgrimLabelDepartureAirport, pilgrim.departureAirport),
          _row(l10n.pilgrimLabelDepartureAirline, pilgrim.departureAirline),
          _row(l10n.pilgrimLabelDepartureFlight, pilgrim.departureFlightNo),
          _row(l10n.pilgrimLabelDepartureDate, pilgrim.departureDate),
          _row(l10n.pilgrimLabelDepartureTime, pilgrim.departureTime),
        ],
      ),
      _ProfileSection(
        title: l10n.pilgrimSectionReturnFlight,
        icon: Icons.flight_land,
        rows: [
          _row(l10n.pilgrimLabelReturnAirport, pilgrim.returnAirport),
          _row(l10n.pilgrimLabelReturnAirline, pilgrim.returnAirline),
          _row(l10n.pilgrimLabelReturnFlight, pilgrim.returnFlightNo),
          _row(l10n.pilgrimLabelReturnDate, pilgrim.returnDate),
          _row(l10n.pilgrimLabelReturnTime, pilgrim.returnTime),
        ],
      ),
      _ProfileSection(
        title: l10n.pilgrimSectionHolySites,
        icon: Icons.temple_hindu_outlined,
        rows: [
          _row(l10n.pilgrimLabelServiceCenter, pilgrim.serviceCenterName),
          _row(l10n.pilgrimLabelCenterArafat, pilgrim.serviceCenterArafat),
          _row(l10n.pilgrimLabelCenterMina, pilgrim.serviceCenterMina),
          _row(l10n.pilgrimLabelBusArafat, pilgrim.busArafat),
          _row(l10n.pilgrimLabelBusMina, pilgrim.busMina),
          _row(l10n.pilgrimLabelTentArafat, pilgrim.tentArafat),
          _row(l10n.pilgrimLabelTentMina, pilgrim.tentMina),
          _row(l10n.fieldOperatorTransportLabel, pilgrim.transportationDetails),
        ],
      ),
      _ProfileSection(
        title: l10n.pilgrimSectionContact,
        icon: Icons.phone_outlined,
        rows: [
          _phoneRow(context, l10n.pilgrimLabelPhone, pilgrim.phoneNumber),
          _phoneRow(context, l10n.pilgrimLabelWhatsapp, pilgrim.whatsappNumber,
              isWhatsapp: true),
          _phoneRow(context, l10n.pilgrimLabelSyrianPhone, pilgrim.syrianPhoneNumber),
        ],
      ),
      if (pilgrim.notes != null && pilgrim.notes!.trim().isNotEmpty)
        _ProfileSection(
          title: l10n.pilgrimSectionNotes,
          icon: Icons.notes_outlined,
          rows: [_row(l10n.pilgrimSectionNotes, pilgrim.notes)],
        ),
    ];

    final visible = sections.where((s) => s.hasContent).toList();
    if (visible.isEmpty) {
      return Card(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Text(l10n.pilgrimProfileEmpty),
        ),
      );
    }

    return Column(
      children: [
        for (var i = 0; i < visible.length; i++) ...[
          _SectionCard(section: visible[i]),
          if (i < visible.length - 1) SizedBox(height: 12.h),
        ],
      ],
    );
  }

  _ProfileRow _row(String label, String? value) {
    return _ProfileRow(label: label, value: value);
  }

  _ProfileRow _phoneRow(
    BuildContext context,
    String label,
    String? value, {
    bool isWhatsapp = false,
  }) {
    return _ProfileRow(
      label: label,
      value: value,
      onTap: value == null || value.trim().isEmpty
          ? null
          : () => _launchPhone(context, value, isWhatsapp: isWhatsapp),
      trailing: value == null || value.trim().isEmpty
          ? null
          : Icon(
              isWhatsapp ? Icons.chat_outlined : Icons.call_outlined,
              size: 18.sp,
              color: AppColors.primary,
            ),
    );
  }

  Future<void> _launchPhone(
    BuildContext context,
    String number, {
    bool isWhatsapp = false,
  }) async {
    final cleaned = number.replaceAll(RegExp(r'[^\d+]'), '');
    final uri = isWhatsapp
        ? Uri.parse('https://wa.me/$cleaned')
        : Uri.parse('tel:$cleaned');
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication) &&
        context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context).contentOpenMediaFailed)),
      );
    }
  }
}

class _ProfileSection {
  const _ProfileSection({
    required this.title,
    required this.icon,
    required this.rows,
  });

  final String title;
  final IconData icon;
  final List<_ProfileRow> rows;

  bool get hasContent => rows.any((row) => row.hasValue);
  List<_ProfileRow> get visibleRows =>
      rows.where((row) => row.hasValue).toList();
}

class _ProfileRow {
  const _ProfileRow({
    required this.label,
    required this.value,
    this.onTap,
    this.trailing,
  });

  final String label;
  final String? value;
  final VoidCallback? onTap;
  final Widget? trailing;

  bool get hasValue => value != null && value!.trim().isNotEmpty;
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.section});

  final _ProfileSection section;

  @override
  Widget build(BuildContext context) {
    final rows = section.visibleRows;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          initiallyExpanded: true,
          leading: Icon(section.icon, color: AppColors.primary),
          title: Text(
            section.title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          children: [
            for (final row in rows)
              ListTile(
                dense: true,
                title: Text(
                  row.label,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
                subtitle: Text(row.value!),
                trailing: row.trailing,
                onTap: row.onTap,
              ),
          ],
        ),
      ),
    );
  }
}
