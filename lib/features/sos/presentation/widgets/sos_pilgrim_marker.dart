import 'package:flutter/material.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';

/// Map flag: a callout pill showing pilgrim name + group above the location pin.
class SosPilgrimMarker extends StatelessWidget {
  const SosPilgrimMarker({
    required this.name,
    required this.group,
    required this.selected,
    required this.onTap,
    super.key,
  });

  final String name;
  final String group;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final pinColor = selected ? AppColors.error : AppColors.accentRed;
    return Semantics(
      button: true,
      selected: selected,
      label: '$name, $group',
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 184),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: selected ? AppColors.error : AppColors.border,
                    width: selected ? 1.5 : 1,
                  ),
                  boxShadow: const [
                    BoxShadow(color: AppColors.shadow, blurRadius: 6),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.person_pin_circle, size: 14, color: pinColor),
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12,
                              height: 1.1,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 1),
                    Text(
                      group,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 10.5,
                        height: 1.1,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Icon(
              Icons.location_on,
              size: 34,
              color: pinColor,
              shadows: const [
                Shadow(color: AppColors.shadow, blurRadius: 4),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
