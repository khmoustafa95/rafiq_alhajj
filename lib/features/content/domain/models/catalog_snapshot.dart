/// Wrapper for catalog data with cache metadata (stale-while-revalidate).
class CatalogSnapshot<T> {
  const CatalogSnapshot({
    required this.data,
    required this.cachedAt,
    this.isFromCache = false,
    this.isRefreshing = false,
  });

  final T data;
  final DateTime cachedAt;
  final bool isFromCache;
  final bool isRefreshing;

  bool get isStale =>
      isFromCache ||
      DateTime.now().difference(cachedAt) > ContentCatalogTtl.defaultDuration;

  CatalogSnapshot<T> copyWith({
    T? data,
    DateTime? cachedAt,
    bool? isFromCache,
    bool? isRefreshing,
  }) {
    return CatalogSnapshot<T>(
      data: data ?? this.data,
      cachedAt: cachedAt ?? this.cachedAt,
      isFromCache: isFromCache ?? this.isFromCache,
      isRefreshing: isRefreshing ?? this.isRefreshing,
    );
  }
}

abstract final class ContentCatalogTtl {
  static const defaultDuration = Duration(days: 7);
}

class CatalogSearchHit {
  const CatalogSearchHit({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.kind,
  });

  final String id;
  final String title;
  final String? subtitle;

  /// `topic`, `news`, or `announcement`.
  final String kind;
}
