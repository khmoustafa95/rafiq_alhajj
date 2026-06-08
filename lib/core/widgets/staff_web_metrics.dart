import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/core/platform/app_platform.dart';

/// Staff web layouts use fixed logical pixels on desktop.
/// [ScreenUtil] mobile scaling breaks wide web dashboards (overflow + giant controls).
double sw(double value) => AppPlatform.isWeb ? value : value.w;

double sh(double value) => AppPlatform.isWeb ? value : value.h;

double sr(double value) => AppPlatform.isWeb ? value : value.r;

double ss(double value) => AppPlatform.isWeb ? value : value.sp;
