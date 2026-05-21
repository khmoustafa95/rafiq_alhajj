import 'package:freezed_annotation/freezed_annotation.dart';

part 'chart_slice.freezed.dart';

@freezed
abstract class ChartSlice with _$ChartSlice {
  const factory ChartSlice({
    required String label,
    required int value,
  }) = _ChartSlice;
}
