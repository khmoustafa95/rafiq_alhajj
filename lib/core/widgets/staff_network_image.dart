import 'package:flutter/material.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/theme/app_decorations.dart';

/// Network image with a consistent placeholder for staff/admin surfaces.
class StaffNetworkImage extends StatelessWidget {
  const StaffNetworkImage({
    required this.imageUrl,
    required this.size,
    this.fallbackIcon = Icons.image_outlined,
    this.borderRadius,
    super.key,
  });

  final String? imageUrl;
  final double size;
  final IconData fallbackIcon;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    final url = imageUrl?.trim();
    if (url != null && url.isNotEmpty) {
      final image = Image.network(
        url,
        width: size,
        height: size,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, progress) =>
            progress == null ? child : _placeholder(),
        errorBuilder: (_, _, _) => _placeholder(),
      );
      if (borderRadius != null) {
        return ClipRRect(borderRadius: borderRadius!, child: image);
      }
      return image;
    }
    return _placeholder();
  }

  Widget _placeholder() {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.12),
        borderRadius: borderRadius ?? BorderRadius.circular(AppDecorations.radiusSm),
      ),
      alignment: Alignment.center,
      child: Icon(fallbackIcon, size: size * 0.5, color: AppColors.primary),
    );
  }
}
