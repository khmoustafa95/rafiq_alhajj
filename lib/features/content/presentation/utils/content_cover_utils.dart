/// Returns true when [url] points to a raster image suitable as a cover.
bool isContentCoverImageUrl(String? url) {
  if (url == null || url.isEmpty) {
    return false;
  }
  final path = Uri.tryParse(url)?.path.toLowerCase() ?? url.toLowerCase();
  return path.endsWith('.jpg') ||
      path.endsWith('.jpeg') ||
      path.endsWith('.png') ||
      path.endsWith('.webp') ||
      path.endsWith('.gif');
}
