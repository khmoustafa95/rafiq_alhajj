import 'package:flutter/foundation.dart';

abstract final class AppPlatform {
  static bool get isWeb => kIsWeb;
}
