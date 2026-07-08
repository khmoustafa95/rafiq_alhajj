import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/theme/app_decorations.dart';
import 'package:rafiq_alhajj/core/widgets/staff_network_image.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_metrics.dart';

class AdminGroupLogoPreview extends StatelessWidget {
  const AdminGroupLogoPreview({
    this.logoBytes,
    this.logoUrl,
    super.key,
  });

  final Uint8List? logoBytes;
  final String? logoUrl;

  @override
  Widget build(BuildContext context) {
    if (logoBytes != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(AppDecorations.radiusMd),
        child: Image.memory(
          logoBytes!,
          width: sw(96),
          height: sh(96),
          fit: BoxFit.cover,
        ),
      );
    }
    if (logoUrl != null && logoUrl!.isNotEmpty) {
      return StaffNetworkImage(
        imageUrl: logoUrl,
        size: sw(96),
        borderRadius: BorderRadius.circular(AppDecorations.radiusMd),
      );
    }
    return const _AdminGroupLogoPlaceholder();
  }
}

class AdminGroupMemberPhotoPreview extends StatelessWidget {
  const AdminGroupMemberPhotoPreview({
    this.photoBytes,
    this.photoUrl,
    super.key,
  });

  final Uint8List? photoBytes;
  final String? photoUrl;

  @override
  Widget build(BuildContext context) {
    if (photoBytes != null) {
      return ClipOval(
        child: Image.memory(
          photoBytes!,
          width: sw(56),
          height: sh(56),
          fit: BoxFit.cover,
        ),
      );
    }
    if (photoUrl != null && photoUrl!.isNotEmpty) {
      return StaffNetworkImage(
        imageUrl: photoUrl,
        size: sw(56),
        fallbackIcon: Icons.person_outline,
        borderRadius: BorderRadius.circular(sw(28)),
      );
    }
    return const _AdminGroupMemberPhotoPlaceholder();
  }
}

class _AdminGroupLogoPlaceholder extends StatelessWidget {
  const _AdminGroupLogoPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: sw(96),
      height: sh(96),
      decoration: BoxDecoration(
        color: AppColors.surfaceMuted,
        borderRadius: BorderRadius.circular(AppDecorations.radiusMd),
        border: Border.all(color: AppColors.border),
      ),
      child: Icon(
        Icons.image_outlined,
        color: AppColors.textSecondary,
        size: ss(32),
      ),
    );
  }
}

class _AdminGroupMemberPhotoPlaceholder extends StatelessWidget {
  const _AdminGroupMemberPhotoPlaceholder();

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: sr(28),
      backgroundColor: AppColors.primary.withValues(alpha: 0.12),
      child: const Icon(Icons.person_outline, color: AppColors.primary),
    );
  }
}
