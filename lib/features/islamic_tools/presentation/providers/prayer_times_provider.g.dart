// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prayer_times_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(prayerTimesRepository)
final prayerTimesRepositoryProvider = PrayerTimesRepositoryProvider._();

final class PrayerTimesRepositoryProvider
    extends
        $FunctionalProvider<
          PrayerTimesRepository,
          PrayerTimesRepository,
          PrayerTimesRepository
        >
    with $Provider<PrayerTimesRepository> {
  PrayerTimesRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'prayerTimesRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$prayerTimesRepositoryHash();

  @$internal
  @override
  $ProviderElement<PrayerTimesRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PrayerTimesRepository create(Ref ref) {
    return prayerTimesRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PrayerTimesRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PrayerTimesRepository>(value),
    );
  }
}

String _$prayerTimesRepositoryHash() =>
    r'27d45dd99c0970b75bbd60cbbca5d33e77ab450c';

@ProviderFor(prayerTimesSchedule)
final prayerTimesScheduleProvider = PrayerTimesScheduleProvider._();

final class PrayerTimesScheduleProvider
    extends
        $FunctionalProvider<
          AsyncValue<PrayerTimesSchedule>,
          PrayerTimesSchedule,
          FutureOr<PrayerTimesSchedule>
        >
    with
        $FutureModifier<PrayerTimesSchedule>,
        $FutureProvider<PrayerTimesSchedule> {
  PrayerTimesScheduleProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'prayerTimesScheduleProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$prayerTimesScheduleHash();

  @$internal
  @override
  $FutureProviderElement<PrayerTimesSchedule> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<PrayerTimesSchedule> create(Ref ref) {
    return prayerTimesSchedule(ref);
  }
}

String _$prayerTimesScheduleHash() =>
    r'7ecf41c7be981b4808845fbe51ef0bc75b224b41';
