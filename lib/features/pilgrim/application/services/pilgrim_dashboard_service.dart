import 'package:rafiq_alhajj/features/pilgrim/data/local/ritual_progress_cache.dart';
import 'package:rafiq_alhajj/features/pilgrim/data/repositories/pilgrim_registry_repository.dart';
import 'package:rafiq_alhajj/features/pilgrim/data/repositories/pilgrim_remote_repository.dart';
import 'package:rafiq_alhajj/features/pilgrim/domain/models/pilgrim.dart';
import 'package:rafiq_alhajj/features/pilgrim/domain/models/pilgrim_dashboard.dart';
import 'package:rafiq_alhajj/features/pilgrim/domain/models/ritual_progress.dart';
import 'package:rafiq_alhajj/features/pilgrim/domain/models/ritual_step_definition.dart';
import 'package:rafiq_alhajj/features/pilgrim/domain/models/ritual_step_status.dart';

class PilgrimDashboardService {
  PilgrimDashboardService(this._remote, this._registry);

  final PilgrimRemoteRepository _remote;
  final PilgrimRegistryRepository _registry;

  Future<PilgrimDashboard> loadDashboard(String pilgrimId) async {
    var local = await RitualProgressCache.read(pilgrimId);
    Pilgrim? registry;

    if (_remote.isAvailable) {
      try {
        final remoteLogs = await _remote.fetchRitualLogs(pilgrimId);
        local = _mergeProgress(local, remoteLogs);
        await RitualProgressCache.write(pilgrimId, local);

        registry = await _tryFetchRegistry(pilgrimId);
      } on PilgrimRemoteException {
        // Keep local-only state when offline or remote fails.
      }
    }

    final rituals = _buildRitualStatuses(local);
    final hasPendingSync = local.values.any((p) => p.pendingSync);

    return PilgrimDashboard(
      registry: registry,
      rituals: rituals,
      hasPendingSync: hasPendingSync,
    );
  }

  Future<PilgrimDashboard> toggleRitual({
    required String pilgrimId,
    required String ritualKey,
    required bool completed,
  }) async {
    final local = await RitualProgressCache.read(pilgrimId);
    final updated = Map<String, RitualProgress>.from(local);
    updated[ritualKey] = RitualProgress(
      ritualKey: ritualKey,
      isCompleted: completed,
      completedAt: completed ? DateTime.now() : null,
      pendingSync: true,
    );
    await RitualProgressCache.write(pilgrimId, updated);

    if (_remote.isAvailable) {
      try {
        await _remote.upsertRitualLog(
          pilgrimId: pilgrimId,
          progress: updated[ritualKey]!.copyWith(pendingSync: false),
        );
        updated[ritualKey] = updated[ritualKey]!.copyWith(pendingSync: false);
        await RitualProgressCache.write(pilgrimId, updated);
      } on PilgrimRemoteException {
        // Remains pendingSync for next sync.
      }
    }

    return PilgrimDashboard(
      registry: await _tryFetchRegistry(pilgrimId),
      rituals: _buildRitualStatuses(updated),
      hasPendingSync: updated.values.any((p) => p.pendingSync),
    );
  }

  Future<void> syncPending(String pilgrimId) async {
    if (!_remote.isAvailable) {
      return;
    }

    final local = await RitualProgressCache.read(pilgrimId);
    for (final entry in local.entries) {
      if (!entry.value.pendingSync) {
        continue;
      }
      await _remote.upsertRitualLog(
        pilgrimId: pilgrimId,
        progress: entry.value.copyWith(pendingSync: false),
      );
      local[entry.key] = entry.value.copyWith(pendingSync: false);
    }
    await RitualProgressCache.write(pilgrimId, local);
  }

  Map<String, RitualProgress> _mergeProgress(
    Map<String, RitualProgress> local,
    Map<String, RitualProgress> remote,
  ) {
    final merged = Map<String, RitualProgress>.from(local);

    for (final entry in remote.entries) {
      final existing = merged[entry.key];
      if (existing == null || !existing.pendingSync) {
        merged[entry.key] = entry.value;
      }
    }

    return merged;
  }

  List<RitualStepStatus> _buildRitualStatuses(
    Map<String, RitualProgress> progressMap,
  ) {
    final steps = List<RitualStepDefinition>.from(HajjRitualSteps.all)
      ..sort((a, b) => a.order.compareTo(b.order));

    return steps.map((step) {
      final progress = progressMap[step.key];
      return RitualStepStatus(
        definition: step,
        isCompleted: progress?.isCompleted ?? false,
        completedAt: progress?.completedAt,
        pendingSync: progress?.pendingSync ?? false,
      );
    }).toList();
  }

  Future<Pilgrim?> _tryFetchRegistry(String pilgrimId) async {
    if (!_registry.isAvailable) {
      return null;
    }

    try {
      return await _registry.fetchByProfileId(pilgrimId);
    } on PilgrimRegistryException {
      return null;
    }
  }
}
