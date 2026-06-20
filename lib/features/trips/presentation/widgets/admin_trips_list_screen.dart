import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq_alhajj/core/platform/app_platform.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
import 'package:rafiq_alhajj/core/widgets/rafiq_app_bar.dart';
import 'package:rafiq_alhajj/core/widgets/staff_error_view.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_layout.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_metrics.dart';
import 'package:rafiq_alhajj/features/trips/domain/models/trip.dart';
import 'package:rafiq_alhajj/features/trips/presentation/providers/trips_providers.dart';
import 'package:rafiq_alhajj/features/trips/presentation/widgets/trip_editor_dialog.dart';
import 'package:rafiq_alhajj/features/trips/presentation/widgets/trip_labels.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class AdminTripsListScreen extends ConsumerWidget {
  const AdminTripsListScreen({super.key});

  Future<void> _openEditor(BuildContext context, {Trip? trip}) async {
    await showTripEditorDialog(context, trip: trip);
  }

  void _openOffices(BuildContext context, String tripId) {
    final path = AppRoutes.adminTripOfficesPath(tripId);
    if (AppPlatform.isWeb) {
      context.go(path);
    } else {
      unawaited(context.push(path));
    }
  }

  Future<void> _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    Trip trip,
  ) async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.adminTripDeleteTitle),
        content: Text(l10n.adminTripDeleteMessage(trip.name)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n.dialogCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(l10n.adminTripDeleteConfirm),
          ),
        ],
      ),
    );

    if (confirmed != true || !context.mounted) {
      return;
    }

    final ok = await ref.read(tripDeleteProvider.notifier).remove(trip.id);
    if (!context.mounted) {
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          ok ? l10n.adminTripDeleteSuccess : l10n.adminTripDeleteError,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final tripsAsync = ref.watch(tripsListProvider);

    final body = tripsAsync.when(
      skipLoadingOnReload: true,
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => StaffErrorView.fromError(
        l10n,
        error: error,
        onRetry: () => ref.invalidate(tripsListProvider),
      ),
      data: (trips) {
        if (trips.isEmpty) {
          return StaffEmptyState(
            message: l10n.adminTripsEmpty,
            icon: Icons.flight_takeoff_outlined,
            actionLabel: l10n.adminTripAdd,
            onAction: () => _openEditor(context),
          );
        }

        return ListView.separated(
          padding: EdgeInsets.all(sw(16)),
          itemCount: trips.length,
          separatorBuilder: (_, _) => SizedBox(height: sh(10)),
          itemBuilder: (context, index) {
            final trip = trips[index];
            return _TripCard(
              trip: trip,
              onTap: () => _openOffices(context, trip.id),
              onEdit: () => _openEditor(context, trip: trip),
              onDelete: () => unawaited(_confirmDelete(context, ref, trip)),
              onOffices: () => _openOffices(context, trip.id),
            );
          },
        );
      },
    );

    if (AppPlatform.isWeb) {
      return StaffWebPage(
        title: l10n.adminTripsTitle,
        subtitle: l10n.adminTripsSubtitle,
        scrollable: false,
        actions: [
          FilledButton.icon(
            onPressed: () => _openEditor(context),
            icon: const Icon(Icons.add_rounded),
            label: Text(l10n.adminTripAdd),
          ),
        ],
        body: body,
      );
    }

    return Scaffold(
      appBar: RafiqAppBar(
        title: Text(l10n.adminTripsTitle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go(AppRoutes.adminDashboard),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openEditor(context),
        icon: const Icon(Icons.add),
        label: Text(l10n.adminTripAdd),
      ),
      body: body,
    );
  }
}

class _TripCard extends StatelessWidget {
  const _TripCard({
    required this.trip,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
    required this.onOffices,
  });

  final Trip trip;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onOffices;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.12),
          child: Icon(
            trip.isHajj ? Icons.mosque : Icons.mosque_outlined,
            color: theme.colorScheme.primary,
          ),
        ),
        title: Text(trip.name, maxLines: 1, overflow: TextOverflow.ellipsis),
        subtitle: Text(
          '${tripTypeLabel(l10n, trip.type)} · ${trip.seasonYear} · '
          '${tripStatusLabel(l10n, trip.status)}',
          style: theme.textTheme.bodySmall,
        ),
        trailing: Wrap(
          spacing: sw(4),
          children: [
            IconButton(
              tooltip: l10n.adminTripManageOffices,
              icon: const Icon(Icons.groups_2_outlined),
              onPressed: onOffices,
            ),
            IconButton(
              tooltip: l10n.adminTripEditTitle,
              icon: const Icon(Icons.edit_outlined),
              onPressed: onEdit,
            ),
            IconButton(
              tooltip: l10n.adminTripDeleteConfirm,
              icon: const Icon(Icons.delete_outline),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
