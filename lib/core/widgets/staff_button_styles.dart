import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Buttons inside a [Row] must not use the app theme's [Size.fromHeight]
/// minimum width (infinity), which breaks horizontal layout.
ButtonStyle staffRowOutlinedButtonStyle(BuildContext context) {
  return OutlinedButton.styleFrom(
    minimumSize: Size(0, 44.h),
    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
  );
}

ButtonStyle staffRowFilledButtonStyle(BuildContext context) {
  return FilledButton.styleFrom(
    minimumSize: Size(0, 44.h),
    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
  );
}
