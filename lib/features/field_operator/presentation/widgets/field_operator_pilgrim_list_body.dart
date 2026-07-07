import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/features/field_operator/domain/models/pilgrim_search_item.dart';
import 'package:rafiq_alhajj/features/field_operator/presentation/widgets/pilgrim_list_tile.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class FieldOperatorPilgrimListBody extends StatelessWidget {
  const FieldOperatorPilgrimListBody({
    required this.pilgrims,
    required this.onRefresh,
    required this.onPilgrimTap,
    super.key,
  });

  final List<PilgrimSearchItem> pilgrims;
  final Future<void> Function() onRefresh;
  final ValueChanged<PilgrimSearchItem> onPilgrimTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    if (pilgrims.isEmpty) {
      return Center(child: Text(l10n.fieldOperatorNoResults));
    }

    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.separated(
        padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 16.h),
        itemCount: pilgrims.length,
        separatorBuilder: (_, _) => SizedBox(height: 10.h),
        itemBuilder: (context, index) {
          final item = pilgrims[index];
          return PilgrimListTile(
            item: item,
            onTap: () => onPilgrimTap(item),
          );
        },
      ),
    );
  }
}
