/// Picks the best localized string for the given [languageCode].
String localizedBilingualText({
  required String languageCode,
  required String primaryAr,
  String? primaryEn,
  String? fallback,
}) {
  final useArabic = languageCode.startsWith('ar');
  if (useArabic) {
    if (primaryAr.trim().isNotEmpty) {
      return primaryAr;
    }
    return primaryEn?.trim().isNotEmpty == true
        ? primaryEn!.trim()
        : (fallback ?? primaryAr);
  }

  if (primaryEn != null && primaryEn.trim().isNotEmpty) {
    return primaryEn.trim();
  }
  if (primaryAr.trim().isNotEmpty) {
    return primaryAr;
  }
  return fallback ?? '';
}
