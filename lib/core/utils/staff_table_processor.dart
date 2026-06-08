import 'package:rafiq_alhajj/core/models/staff_table_query.dart';

typedef StaffTableSortValue<T> = Comparable<Object?>? Function(T item);
typedef StaffTableFilterValue<T> = String? Function(T item);
typedef StaffTableSearchValue<T> = String Function(T item);

class StaffTableProcessor {
  const StaffTableProcessor._();

  static PaginatedResult<T> paginate<T>({
    required List<T> source,
    required StaffTableQuery query,
    StaffTableSearchValue<T>? searchValue,
    Map<String, StaffTableFilterValue<T>>? filterValues,
    Map<String, StaffTableSortValue<T>>? sortValues,
  }) {
    var items = List<T>.from(source);

    final search = query.search.trim().toLowerCase();
    if (search.isNotEmpty && searchValue != null) {
      items = items
          .where((item) => searchValue(item).toLowerCase().contains(search))
          .toList();
    }

    if (filterValues != null) {
      for (final entry in query.filters.entries) {
        if (entry.value.isEmpty) {
          continue;
        }
        final matcher = filterValues[entry.key];
        if (matcher == null) {
          continue;
        }
        items = items
            .where((item) => matcher(item) == entry.value)
            .toList();
      }
    }

    final sortColumn = query.sortColumnId;
    if (sortColumn != null && sortValues != null) {
      final sortFn = sortValues[sortColumn];
      if (sortFn != null) {
        items.sort((a, b) {
          final av = sortFn(a);
          final bv = sortFn(b);
          if (av == null && bv == null) {
            return 0;
          }
          if (av == null) {
            return 1;
          }
          if (bv == null) {
            return -1;
          }
          final cmp = av.compareTo(bv);
          return query.sortAscending ? cmp : -cmp;
        });
      }
    }

    final totalCount = items.length;
    final from = query.from;
    if (from >= totalCount) {
      return PaginatedResult(
        items: const [],
        totalCount: totalCount,
        pageSize: query.pageSize,
      );
    }

    final to = query.to.clamp(0, totalCount - 1);
    final pageItems = items.sublist(from, to + 1);

    return PaginatedResult(
      items: pageItems,
      totalCount: totalCount,
      pageSize: query.pageSize,
    );
  }
}
