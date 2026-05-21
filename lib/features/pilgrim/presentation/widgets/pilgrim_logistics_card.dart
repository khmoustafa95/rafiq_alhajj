import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/features/pilgrim/domain/models/pilgrim_details.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class PilgrimLogisticsCard extends StatelessWidget {
  const PilgrimLogisticsCard({
    required this.details,
    super.key,
  });

  final PilgrimDetails? details;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    if (details == null ||
        (details!.hotelName == null &&
            details!.transportationDetails == null &&
            details!.medicalTestStatus == null)) {
      return Card(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Text(
            l10n.pilgrimLogisticsEmpty,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      );
    }

    final d = details!;

    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.pilgrimLogisticsTitle,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 12.h),
            if (d.medicalTestStatus != null)
              _Row(
                icon: Icons.medical_services_outlined,
                label: l10n.pilgrimMedicalStatus,
                value: d.medicalTestStatus!,
              ),
            if (d.travelDate != null)
              _Row(
                icon: Icons.flight_takeoff,
                label: l10n.pilgrimTravelDate,
                value: MaterialLocalizations.of(context)
                    .formatMediumDate(d.travelDate!),
              ),
            if (d.hotelName != null)
              _Row(
                icon: Icons.hotel_outlined,
                label: l10n.pilgrimHotel,
                value: d.hotelName!,
              ),
            if (d.hotelLocationUrl != null &&
                d.hotelLocationUrl!.isNotEmpty) ...[
              SizedBox(height: 8.h),
              TextButton.icon(
                onPressed: () => _openUrl(context, d.hotelLocationUrl!),
                icon: const Icon(Icons.map_outlined),
                label: Text(l10n.pilgrimOpenHotelMap),
              ),
            ],
            if (d.transportationDetails != null)
              _Row(
                icon: Icons.directions_bus_outlined,
                label: l10n.pilgrimTransport,
                value: d.transportationDetails!,
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _openUrl(BuildContext context, String url) async {
    final uri = Uri.tryParse(url);
    if (uri == null || !await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context).contentOpenMediaFailed)),
        );
      }
    }
  }
}

class _Row extends StatelessWidget {
  const _Row({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20.sp),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                Text(value),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
