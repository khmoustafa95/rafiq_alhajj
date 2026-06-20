import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/features/trips/data/repositories/trips_repository.dart';
import 'package:rafiq_alhajj/features/trips/domain/models/trip.dart';
import 'package:rafiq_alhajj/features/trips/domain/models/trip_editor_input.dart';
import 'package:rafiq_alhajj/features/trips/domain/models/trip_office.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'trips_providers.g.dart';

const _activeTripPrefsKey = 'active_trip_id';

@Riverpod(keepAlive: true)
TripsRepository tripsRepository(Ref ref) {
  return TripsRepository(
    AppConfig.hasSupabase ? Supabase.instance.client : null,
  );
}

@riverpod
Future<List<Trip>> tripsList(Ref ref) async {
  return ref.watch(tripsRepositoryProvider).fetchTrips();
}

@riverpod
Future<Trip> tripDetail(Ref ref, String id) async {
  return ref.watch(tripsRepositoryProvider).fetchById(id);
}

@riverpod
Future<List<TripOffice>> tripOffices(Ref ref, String tripId) async {
  return ref.watch(tripsRepositoryProvider).fetchOffices(tripId);
}

@riverpod
Future<List<TripGroupOption>> tripAvailableGroups(Ref ref, String tripId) async {
  return ref.watch(tripsRepositoryProvider).fetchAvailableGroups(tripId);
}

/// Currently selected trip id used to scope pilgrim reads. Null = all trips.
@Riverpod(keepAlive: true)
class ActiveTrip extends _$ActiveTrip {
  @override
  Future<String?> build() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getString(_activeTripPrefsKey);
    if (stored != null && stored.isNotEmpty) {
      return stored;
    }

    // Default to the first active trip, otherwise the most recent one.
    final trips = await ref.read(tripsRepositoryProvider).fetchTrips();
    if (trips.isEmpty) {
      return null;
    }
    final active = trips.where((t) => t.status == 'active');
    return active.isNotEmpty ? active.first.id : trips.first.id;
  }

  Future<void> setTrip(String? tripId) async {
    final prefs = await SharedPreferences.getInstance();
    if (tripId == null || tripId.isEmpty) {
      await prefs.remove(_activeTripPrefsKey);
    } else {
      await prefs.setString(_activeTripPrefsKey, tripId);
    }
    state = AsyncData(tripId);
  }
}

@riverpod
class TripSave extends _$TripSave {
  @override
  FutureOr<void> build() {}

  Future<bool> save(TripEditorInput input) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(tripsRepositoryProvider).save(input);
      ref.invalidate(tripsListProvider);
      if (input.id != null) {
        ref.invalidate(tripDetailProvider(input.id!));
      }
    });
    return !state.hasError;
  }
}

@riverpod
class TripDelete extends _$TripDelete {
  @override
  FutureOr<void> build() {}

  Future<bool> remove(String id) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(tripsRepositoryProvider).delete(id);
      ref.invalidate(tripsListProvider);
    });
    return !state.hasError;
  }
}

@riverpod
class TripOfficeMutation extends _$TripOfficeMutation {
  @override
  FutureOr<void> build() {}

  Future<bool> add({required String tripId, required String groupId}) async {
    return _run(tripId, () async {
      await ref.read(tripsRepositoryProvider).addOffice(
            tripId: tripId,
            groupId: groupId,
          );
    });
  }

  Future<bool> setStatus({
    required String tripId,
    required String tripGroupId,
    required String status,
  }) async {
    return _run(tripId, () async {
      await ref.read(tripsRepositoryProvider).setOfficeStatus(
            tripGroupId: tripGroupId,
            status: status,
          );
    });
  }

  Future<bool> remove({
    required String tripId,
    required String tripGroupId,
  }) async {
    return _run(tripId, () async {
      await ref.read(tripsRepositoryProvider).removeOffice(tripGroupId);
    });
  }

  Future<bool> _run(String tripId, Future<void> Function() action) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await action();
      ref.invalidate(tripOfficesProvider(tripId));
      ref.invalidate(tripAvailableGroupsProvider(tripId));
    });
    return !state.hasError;
  }
}
