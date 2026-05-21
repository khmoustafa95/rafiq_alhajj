import 'package:flutter_compass/flutter_compass.dart';
import 'package:rafiq_alhajj/features/islamic_tools/data/qibla/qibla_repository.dart';
import 'package:rafiq_alhajj/features/islamic_tools/domain/models/qibla_state.dart';
import 'package:rafiq_alhajj/features/islamic_tools/presentation/providers/location_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'qibla_provider.g.dart';

@Riverpod(keepAlive: true)
QiblaRepository qiblaRepository(Ref ref) => QiblaRepository();

@riverpod
Stream<QiblaState> qiblaState(Ref ref) async* {
  final location = await ref.watch(deviceLocationProvider.future);
  final repository = ref.watch(qiblaRepositoryProvider);

  yield repository.buildState(location: location, compassHeading: null);

  final events = FlutterCompass.events;
  if (events == null) {
    return;
  }

  await for (final event in events) {
    yield repository.buildState(
      location: location,
      compassHeading: event.heading,
    );
  }
}
