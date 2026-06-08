import 'package:flutter/material.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/features/field_operator/domain/models/field_pilgrim_status.dart';

abstract final class FieldStatusColors {
  static Color background(String? status) {
    return switch (status) {
      FieldPilgrimStatus.completed => AppColors.success.withValues(alpha: 0.12),
      FieldPilgrimStatus.medicalDone => AppColors.info.withValues(alpha: 0.12),
      FieldPilgrimStatus.arrivedHotel =>
        AppColors.accentTeal.withValues(alpha: 0.12),
      FieldPilgrimStatus.inTransit => AppColors.warning.withValues(alpha: 0.12),
      FieldPilgrimStatus.pending => AppColors.chipInactive,
      _ => AppColors.chipInactive,
    };
  }

  static Color foreground(String? status) {
    return switch (status) {
      FieldPilgrimStatus.completed => AppColors.success,
      FieldPilgrimStatus.medicalDone => AppColors.info,
      FieldPilgrimStatus.arrivedHotel => AppColors.accentTeal,
      FieldPilgrimStatus.inTransit => AppColors.warning,
      FieldPilgrimStatus.pending => AppColors.chipInactiveText,
      _ => AppColors.chipInactiveText,
    };
  }
}
