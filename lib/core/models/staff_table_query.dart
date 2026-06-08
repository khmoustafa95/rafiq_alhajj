import 'package:flutter/foundation.dart';

enum StaffTableSortDirection { ascending, descending }

@immutable
class StaffTableQuery {
  const StaffTableQuery({
    this.page = 0,
    this.pageSize = 10,
    this.search = '',
    this.sortColumnId,
    this.sortAscending = true,
    this.filters = const {},
  });

  static const defaultPageSize = 10;
  static const pageSizeOptions = [10, 25, 50];

  final int page;
  final int pageSize;
  final String search;
  final String? sortColumnId;
  final bool sortAscending;
  final Map<String, String> filters;

  int get from => page * pageSize;
  int get to => from + pageSize - 1;

  StaffTableQuery copyWith({
    int? page,
    int? pageSize,
    String? search,
    String? sortColumnId,
    bool? sortAscending,
    Map<String, String>? filters,
    bool clearSort = false,
  }) {
    return StaffTableQuery(
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
      search: search ?? this.search,
      sortColumnId: clearSort ? null : (sortColumnId ?? this.sortColumnId),
      sortAscending: sortAscending ?? this.sortAscending,
      filters: filters ?? this.filters,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is StaffTableQuery &&
        other.page == page &&
        other.pageSize == pageSize &&
        other.search == search &&
        other.sortColumnId == sortColumnId &&
        other.sortAscending == sortAscending &&
        mapEquals(other.filters, filters);
  }

  @override
  int get hashCode => Object.hash(
        page,
        pageSize,
        search,
        sortColumnId,
        sortAscending,
        Object.hashAllUnordered(filters.entries.toList()),
      );
}

@immutable
class PaginatedResult<T> {
  const PaginatedResult({
    required this.items,
    required this.totalCount,
    required this.pageSize,
  });

  final List<T> items;
  final int totalCount;
  final int pageSize;

  int get totalPages {
    if (totalCount == 0) {
      return 1;
    }
    return (totalCount / pageSize).ceil();
  }
}
