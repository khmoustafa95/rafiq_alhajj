import 'package:flutter/material.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/theme/app_decorations.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_metrics.dart';
import 'package:rafiq_alhajj/features/sos/domain/models/sos_alert.dart';
import 'package:rafiq_alhajj/features/sos/presentation/utils/sos_time_format.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

/// List tile for an active SOS alert on the staff monitor screen.
class SosMonitorAlertCard extends StatelessWidget {
  const SosMonitorAlertCard({
    required this.alert,
    required this.selected,
    required this.onTap,
    required this.onResolve,
    required this.onOpenMaps,
    super.key,
  });

  final SosAlert alert;
  final bool selected;
  final VoidCallback onTap;
  final VoidCallback onResolve;
  final VoidCallback onOpenMaps;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final name = alert.pilgrimName ?? l10n.sosUnknownPilgrim;
    final group = alert.groupName ?? l10n.sosNoGroup;
    final lastUpdate = alert.lastLocationAt;

    return Semantics(
      button: true,
      selected: selected,
      label: '$name, $group',
      child: Material(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDecorations.radiusLg),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppDecorations.radiusLg),
          child: Container(
            decoration:
                AppDecorations.card(radius: AppDecorations.radiusLg).copyWith(
              border: Border.all(
                color: selected ? AppColors.error : AppColors.border,
                width: selected ? 1.5 : 1,
              ),
            ),
            padding: EdgeInsets.all(sw(14)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: ss(40),
                      height: ss(40),
                      decoration: BoxDecoration(
                        color: AppColors.error.withValues(alpha: 0.12),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.sos_rounded,
                        color: AppColors.error,
                        size: ss(22),
                      ),
                    ),
                    SizedBox(width: sw(12)),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                          Text(
                            group,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: AppColors.textSecondary),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: sh(10)),
                Row(
                  children: [
                    Icon(
                      lastUpdate != null
                          ? Icons.my_location
                          : Icons.location_searching,
                      size: ss(15),
                      color: AppColors.textSecondary,
                    ),
                    SizedBox(width: sw(6)),
                    Expanded(
                      child: Text(
                        lastUpdate != null
                            ? l10n.sosLastUpdate(
                                formatSosLocationFreshness(lastUpdate, l10n),
                              )
                            : l10n.sosNoLocationYet,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.textSecondary,
                            ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: sh(12)),
                Row(
                  children: [
                    Expanded(
                      child: Semantics(
                        button: true,
                        label: l10n.sosOpenInMaps,
                        enabled: alert.hasLocation,
                        child: OutlinedButton.icon(
                          onPressed: alert.hasLocation ? onOpenMaps : null,
                          icon: const Icon(Icons.map_outlined, size: 18),
                          label: Text(
                            l10n.sosOpenInMaps,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: sw(10)),
                    Expanded(
                      child: Semantics(
                        button: true,
                        label: l10n.sosResolveButton,
                        child: FilledButton.icon(
                          onPressed: onResolve,
                          icon: const Icon(Icons.check_circle_outline, size: 18),
                          label: Text(
                            l10n.sosResolveButton,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
