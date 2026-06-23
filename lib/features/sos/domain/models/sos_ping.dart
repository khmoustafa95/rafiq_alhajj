import 'package:freezed_annotation/freezed_annotation.dart';

part 'sos_ping.freezed.dart';

@freezed
abstract class SosPing with _$SosPing {
  const factory SosPing({
    required String id,
    required String alertId,
    required double latitude,
    required double longitude,
    double? accuracy,
    required DateTime createdAt,
  }) = _SosPing;
}
