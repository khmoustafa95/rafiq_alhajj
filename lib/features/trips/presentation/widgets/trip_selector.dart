import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rafiq_alhajj/features/trips/domain/models/trip.dart';
import 'package:rafiq_alhajj/features/trips/presentation/providers/trips_providers.dart';
import 'package:rafiq_alhajj/features/trips/presentation/widgets/trip_labels.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

/// Compact dropdown that scopes pilgrim reads to a trip. Bound to [ActiveTrip].
///
/// Selecting `null` ("All trips") clears the scope. Returns an empty widget
/// while trips are unavailable so it can be dropped into any toolbar safely.
class TripSelector extends ConsumerWidget {
  const TripSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final tripsAsync = ref.watch(tripsListProvider);
    final activeAsync = ref.watch(activeTripProvider);

    final trips = tripsAsync.asData?.value ?? const <Trip>[];
    if (trips.isEmpty) {
      return const SizedBox.shrink();
    }

    final activeId = activeAsync.asData?.value;
    final value = trips.any((Trip t) => t.id == activeId) ? activeId : null;

    return DropdownButtonHideUnderline(
      child: DropdownButton<String?>(
        value: value,
        isDense: true,
        borderRadius: BorderRadius.circular(12),
        icon: const Icon(Icons.expand_more_rounded),
        hint: Text(l10n.tripSelectorLabel),
        items: [
          DropdownMenuItem<String?>(
            child: Text(l10n.tripSelectorAll),
          ),
          for (final trip in trips)
            DropdownMenuItem<String?>(
              value: trip.id,
              child: Text(
                '${tripTypeLabel(l10n, trip.type)} ${trip.seasonYear} · ${trip.name}',
                overflow: TextOverflow.ellipsis,
              ),
            ),
        ],
        onChanged: (id) =>
            ref.read(activeTripProvider.notifier).setTrip(id),
      ),
    );
  }
}
