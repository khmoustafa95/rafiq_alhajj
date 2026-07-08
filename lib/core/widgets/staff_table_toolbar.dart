import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rafiq_alhajj/core/models/staff_table_query.dart';
import 'package:rafiq_alhajj/core/widgets/staff_button_styles.dart';
import 'package:rafiq_alhajj/core/widgets/staff_table_models.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_metrics.dart';

/// Search field, filters, and toolbar actions above a staff data table.
class StaffTableToolbar extends StatefulWidget {
  const StaffTableToolbar({
    required this.committedSearch,
    required this.searchHint,
    required this.filters,
    required this.query,
    required this.onSearchCommitted,
    required this.onFilterChanged,
    this.toolbarActions = const [],
    super.key,
  });

  final String committedSearch;
  final String searchHint;
  final List<StaffTableFilter> filters;
  final StaffTableQuery query;
  final ValueChanged<String> onSearchCommitted;
  final ValueChanged<Map<String, String>> onFilterChanged;
  final List<Widget> toolbarActions;

  @override
  State<StaffTableToolbar> createState() => _StaffTableToolbarState();
}

class _StaffTableToolbarState extends State<StaffTableToolbar> {
  late final TextEditingController _searchController;
  Timer? _searchDebounce;
  String _lastEmittedSearch = '';

  @override
  void initState() {
    super.initState();
    _lastEmittedSearch = widget.committedSearch;
    _searchController = TextEditingController(text: widget.committedSearch);
  }

  @override
  void didUpdateWidget(covariant StaffTableToolbar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.committedSearch == oldWidget.committedSearch) {
      return;
    }
    if (widget.committedSearch != _lastEmittedSearch) {
      _searchDebounce?.cancel();
      _lastEmittedSearch = widget.committedSearch;
      _searchController.text = widget.committedSearch;
    }
  }

  @override
  void dispose() {
    _searchDebounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    _searchDebounce?.cancel();
    _searchDebounce = Timer(const Duration(milliseconds: 350), () {
      _lastEmittedSearch = value;
      widget.onSearchCommitted(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return _ToolbarLayout(
      searchController: _searchController,
      searchHint: widget.searchHint,
      filters: widget.filters,
      query: widget.query,
      toolbarActions: widget.toolbarActions,
      onSearchChanged: _onSearchChanged,
      onFilterChanged: widget.onFilterChanged,
    );
  }
}

class _ToolbarLayout extends StatelessWidget {
  const _ToolbarLayout({
    required this.searchController,
    required this.searchHint,
    required this.filters,
    required this.query,
    required this.onSearchChanged,
    required this.onFilterChanged,
    this.toolbarActions = const [],
  });

  final TextEditingController searchController;
  final String searchHint;
  final List<StaffTableFilter> filters;
  final StaffTableQuery query;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<Map<String, String>> onFilterChanged;
  final List<Widget> toolbarActions;

  Widget _toolbarTheme(BuildContext context, Widget child) {
    return Theme(
      data: Theme.of(context).copyWith(
        filledButtonTheme: FilledButtonThemeData(
          style: staffRowFilledButtonStyle(context),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: staffRowOutlinedButtonStyle(context),
        ),
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        final stackSearch = maxWidth < 1100;
        final compact = maxWidth < 720;

        final scheme = Theme.of(context).colorScheme;
        final searchField = Semantics(
          textField: true,
          label: searchHint,
          child: TextField(
            controller: searchController,
            decoration: InputDecoration(
              hintText: searchHint,
              prefixIcon: const Icon(Icons.search, size: 20),
              filled: true,
              fillColor: scheme.surfaceContainerHigh,
              isDense: true,
              contentPadding: EdgeInsets.symmetric(
                horizontal: sw(12),
                vertical: sh(12),
              ),
            ),
            onChanged: onSearchChanged,
          ),
        );

        final filterWidgets = filters.map(
          (filter) => _FilterDropdown(
            filter: filter,
            current: query.filters[filter.id] ?? '',
            fullWidth: compact,
            maxWidth: maxWidth,
            onChanged: onFilterChanged,
            query: query,
          ),
        );

        if (compact) {
          return _toolbarTheme(
            context,
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                searchField,
                SizedBox(height: sh(10)),
                ...filterWidgets.map(
                  (widget) => Padding(
                    padding: EdgeInsets.only(bottom: sh(10)),
                    child: widget,
                  ),
                ),
                Wrap(
                  spacing: sw(8),
                  runSpacing: sh(8),
                  children: toolbarActions,
                ),
              ],
            ),
          );
        }

        if (stackSearch) {
          return _toolbarTheme(
            context,
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                searchField,
                SizedBox(height: sh(10)),
                Wrap(
                  spacing: sw(12),
                  runSpacing: sh(10),
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    ...filterWidgets,
                    ...toolbarActions,
                  ],
                ),
              ],
            ),
          );
        }

        return _toolbarTheme(
          context,
          Wrap(
            spacing: sw(12),
            runSpacing: sh(10),
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: sw(200),
                  maxWidth: sw(360),
                ),
                child: searchField,
              ),
              ...filterWidgets,
              ...toolbarActions,
            ],
          ),
        );
      },
    );
  }
}

class _FilterDropdown extends StatelessWidget {
  const _FilterDropdown({
    required this.filter,
    required this.current,
    required this.fullWidth,
    required this.maxWidth,
    required this.onChanged,
    required this.query,
  });

  final StaffTableFilter filter;
  final String current;
  final bool fullWidth;
  final double maxWidth;
  final ValueChanged<Map<String, String>> onChanged;
  final StaffTableQuery query;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final dropdown = DropdownButtonFormField<String>(
      key: ValueKey('${filter.id}-$current'),
      isExpanded: true,
      initialValue: current.isEmpty ? null : current,
      decoration: InputDecoration(
        labelText: filter.label,
        filled: true,
        fillColor: scheme.surfaceContainerHigh,
        isDense: true,
        contentPadding: EdgeInsets.symmetric(
          horizontal: sw(12),
          vertical: sh(10),
        ),
      ),
      items: [
        DropdownMenuItem(
          value: '',
          child: Text(
            filter.allLabel ?? '—',
            overflow: TextOverflow.ellipsis,
          ),
        ),
        ...filter.options.map(
          (option) => DropdownMenuItem(
            value: option.value,
            child: Text(
              option.label,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
      onChanged: (value) {
        final next = Map<String, String>.from(query.filters);
        if (value == null || value.isEmpty) {
          next.remove(filter.id);
        } else {
          next[filter.id] = value;
        }
        onChanged(next);
      },
    );

    if (fullWidth) {
      return SizedBox(width: maxWidth, child: dropdown);
    }

    return SizedBox(
      width: sw(180),
      child: dropdown,
    );
  }
}
