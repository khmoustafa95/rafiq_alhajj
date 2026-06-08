// Escapes user input before embedding in PostgREST `.or()` / `ilike` filters.
String sanitizePostgrestSearchTerm(String raw) {
  final trimmed = raw.trim();
  if (trimmed.isEmpty) {
    return '';
  }

  const special = r'\%_(),.';
  final buffer = StringBuffer();
  for (final rune in trimmed.runes) {
    final char = String.fromCharCode(rune);
    if (char == r'\') {
      buffer.write(r'\\');
    } else if (special.contains(char)) {
      buffer.write(r'\');
      buffer.write(char);
    } else {
      buffer.write(char);
    }
  }
  return buffer.toString();
}
