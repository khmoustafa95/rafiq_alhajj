import 'package:flutter/material.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/features/admin_operators/domain/models/operator_group_grant.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class AdminOperatorGroupAccessSection extends StatelessWidget {
  const AdminOperatorGroupAccessSection({
    required this.groups,
    required this.accessGroupIds,
    required this.writeGroupIds,
    required this.isSaving,
    required this.onAccessChanged,
    required this.onWriteChanged,
    super.key,
  });

  final List<OperatorGroupOption> groups;
  final Set<String> accessGroupIds;
  final Set<String> writeGroupIds;
  final bool isSaving;
  final void Function(String groupId, bool hasAccess) onAccessChanged;
  final void Function(String groupId, bool canWrite) onWriteChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    if (groups.isEmpty) {
      return Text(
        l10n.adminOperatorGroupsEmpty,
        style: const TextStyle(color: AppColors.textSecondary),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final group in groups)
          Row(
            children: [
              Checkbox(
                value: accessGroupIds.contains(group.id),
                onChanged: isSaving
                    ? null
                    : (checked) => onAccessChanged(group.id, checked ?? false),
              ),
              Expanded(child: Text(group.name)),
              if (accessGroupIds.contains(group.id))
                Row(
                  children: [
                    Text(
                      writeGroupIds.contains(group.id)
                          ? l10n.adminOperatorGroupWrite
                          : l10n.adminOperatorGroupRead,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Switch(
                      value: writeGroupIds.contains(group.id),
                      onChanged: isSaving
                          ? null
                          : (write) => onWriteChanged(group.id, write),
                    ),
                  ],
                ),
            ],
          ),
      ],
    );
  }
}
