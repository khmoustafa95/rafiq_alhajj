/// Parses and compares semantic versions (`major.minor.patch`, optional suffix ignored).
abstract final class SemanticVersion {
  static int compare(String a, String b) {
    final partsA = _parse(a);
    final partsB = _parse(b);
    for (var i = 0; i < 3; i++) {
      final diff = partsA[i] - partsB[i];
      if (diff != 0) {
        return diff < 0 ? -1 : 1;
      }
    }
    return 0;
  }

  static bool isValid(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) {
      return false;
    }
    return RegExp(r'^\d+\.\d+\.\d+').hasMatch(trimmed);
  }

  static List<int> _parse(String raw) {
    final core = raw.trim().split(RegExp(r'[-+]')).first;
    final segments = core.split('.');
    int at(int index) =>
        index < segments.length ? int.tryParse(segments[index]) ?? 0 : 0;
    return [at(0), at(1), at(2)];
  }
}
