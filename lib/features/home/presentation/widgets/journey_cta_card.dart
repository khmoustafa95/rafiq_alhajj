import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/theme/app_decorations.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

/// Temporary inquiries WhatsApp number (replace when production contact is set).
const _inquiriesWhatsAppPhone = '963951957301';

class JourneyCtaCard extends StatelessWidget {
  const JourneyCtaCard({
    required this.isPilgrim,
    super.key,
  });

  final bool isPilgrim;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    if (isPilgrim) {
      return const SizedBox.shrink();
    }

    return DecoratedBox(
      decoration: AppDecorations.card(),
      child: Stack(
        children: [
          Positioned(
            right: -8,
            bottom: -8,
            child: Icon(
              Icons.mosque_rounded,
              size: 100.sp,
              color: AppColors.primary.withValues(alpha: 0.06),
            ),
          ),
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  width: 4,
                  decoration: const BoxDecoration(
                    color: AppColors.secondary,
                    borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(AppDecorations.radiusMd),
                    ),
                  ),
                ),
                Expanded(
                child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.homeJourneyTitle,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        l10n.homeJourneyBody,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      SizedBox(height: 16.h),
                      Row(
                        children: [
                          Expanded(
                            child: FilledButton.icon(
                              onPressed: () =>
                                  unawaited(_openWhatsAppInquiries(context)),
                              icon: const Icon(Icons.chat_outlined),
                              label: Text(l10n.homeContactUs),
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () =>
                                  unawaited(context.push(AppRoutes.login)),
                              child: Text(l10n.homeEnterRegistration),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _openWhatsAppInquiries(BuildContext context) async {
    final uri = Uri.parse('https://wa.me/$_inquiriesWhatsAppPhone');
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication) &&
        context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context).contentOpenMediaFailed),
        ),
      );
    }
  }
}
