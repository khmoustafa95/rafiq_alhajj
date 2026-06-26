// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pilgrim_import_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PilgrimImportState {

 PilgrimImportStage get stage; String? get fileName; List<List<String>> get table; PilgrimImportPreview? get preview; PilgrimImportResult? get result; String? get error; bool get busy;
/// Create a copy of PilgrimImportState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PilgrimImportStateCopyWith<PilgrimImportState> get copyWith => _$PilgrimImportStateCopyWithImpl<PilgrimImportState>(this as PilgrimImportState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PilgrimImportState&&(identical(other.stage, stage) || other.stage == stage)&&(identical(other.fileName, fileName) || other.fileName == fileName)&&const DeepCollectionEquality().equals(other.table, table)&&(identical(other.preview, preview) || other.preview == preview)&&(identical(other.result, result) || other.result == result)&&(identical(other.error, error) || other.error == error)&&(identical(other.busy, busy) || other.busy == busy));
}


@override
int get hashCode => Object.hash(runtimeType,stage,fileName,const DeepCollectionEquality().hash(table),preview,result,error,busy);

@override
String toString() {
  return 'PilgrimImportState(stage: $stage, fileName: $fileName, table: $table, preview: $preview, result: $result, error: $error, busy: $busy)';
}


}

/// @nodoc
abstract mixin class $PilgrimImportStateCopyWith<$Res>  {
  factory $PilgrimImportStateCopyWith(PilgrimImportState value, $Res Function(PilgrimImportState) _then) = _$PilgrimImportStateCopyWithImpl;
@useResult
$Res call({
 PilgrimImportStage stage, String? fileName, List<List<String>> table, PilgrimImportPreview? preview, PilgrimImportResult? result, String? error, bool busy
});




}
/// @nodoc
class _$PilgrimImportStateCopyWithImpl<$Res>
    implements $PilgrimImportStateCopyWith<$Res> {
  _$PilgrimImportStateCopyWithImpl(this._self, this._then);

  final PilgrimImportState _self;
  final $Res Function(PilgrimImportState) _then;

/// Create a copy of PilgrimImportState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? stage = null,Object? fileName = freezed,Object? table = null,Object? preview = freezed,Object? result = freezed,Object? error = freezed,Object? busy = null,}) {
  return _then(_self.copyWith(
stage: null == stage ? _self.stage : stage // ignore: cast_nullable_to_non_nullable
as PilgrimImportStage,fileName: freezed == fileName ? _self.fileName : fileName // ignore: cast_nullable_to_non_nullable
as String?,table: null == table ? _self.table : table // ignore: cast_nullable_to_non_nullable
as List<List<String>>,preview: freezed == preview ? _self.preview : preview // ignore: cast_nullable_to_non_nullable
as PilgrimImportPreview?,result: freezed == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as PilgrimImportResult?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,busy: null == busy ? _self.busy : busy // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PilgrimImportState].
extension PilgrimImportStatePatterns on PilgrimImportState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PilgrimImportState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PilgrimImportState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PilgrimImportState value)  $default,){
final _that = this;
switch (_that) {
case _PilgrimImportState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PilgrimImportState value)?  $default,){
final _that = this;
switch (_that) {
case _PilgrimImportState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PilgrimImportStage stage,  String? fileName,  List<List<String>> table,  PilgrimImportPreview? preview,  PilgrimImportResult? result,  String? error,  bool busy)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PilgrimImportState() when $default != null:
return $default(_that.stage,_that.fileName,_that.table,_that.preview,_that.result,_that.error,_that.busy);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PilgrimImportStage stage,  String? fileName,  List<List<String>> table,  PilgrimImportPreview? preview,  PilgrimImportResult? result,  String? error,  bool busy)  $default,) {final _that = this;
switch (_that) {
case _PilgrimImportState():
return $default(_that.stage,_that.fileName,_that.table,_that.preview,_that.result,_that.error,_that.busy);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PilgrimImportStage stage,  String? fileName,  List<List<String>> table,  PilgrimImportPreview? preview,  PilgrimImportResult? result,  String? error,  bool busy)?  $default,) {final _that = this;
switch (_that) {
case _PilgrimImportState() when $default != null:
return $default(_that.stage,_that.fileName,_that.table,_that.preview,_that.result,_that.error,_that.busy);case _:
  return null;

}
}

}

/// @nodoc


class _PilgrimImportState implements PilgrimImportState {
  const _PilgrimImportState({this.stage = PilgrimImportStage.idle, this.fileName, final  List<List<String>> table = const <List<String>>[], this.preview, this.result, this.error, this.busy = false}): _table = table;
  

@override@JsonKey() final  PilgrimImportStage stage;
@override final  String? fileName;
 final  List<List<String>> _table;
@override@JsonKey() List<List<String>> get table {
  if (_table is EqualUnmodifiableListView) return _table;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_table);
}

@override final  PilgrimImportPreview? preview;
@override final  PilgrimImportResult? result;
@override final  String? error;
@override@JsonKey() final  bool busy;

/// Create a copy of PilgrimImportState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PilgrimImportStateCopyWith<_PilgrimImportState> get copyWith => __$PilgrimImportStateCopyWithImpl<_PilgrimImportState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PilgrimImportState&&(identical(other.stage, stage) || other.stage == stage)&&(identical(other.fileName, fileName) || other.fileName == fileName)&&const DeepCollectionEquality().equals(other._table, _table)&&(identical(other.preview, preview) || other.preview == preview)&&(identical(other.result, result) || other.result == result)&&(identical(other.error, error) || other.error == error)&&(identical(other.busy, busy) || other.busy == busy));
}


@override
int get hashCode => Object.hash(runtimeType,stage,fileName,const DeepCollectionEquality().hash(_table),preview,result,error,busy);

@override
String toString() {
  return 'PilgrimImportState(stage: $stage, fileName: $fileName, table: $table, preview: $preview, result: $result, error: $error, busy: $busy)';
}


}

/// @nodoc
abstract mixin class _$PilgrimImportStateCopyWith<$Res> implements $PilgrimImportStateCopyWith<$Res> {
  factory _$PilgrimImportStateCopyWith(_PilgrimImportState value, $Res Function(_PilgrimImportState) _then) = __$PilgrimImportStateCopyWithImpl;
@override @useResult
$Res call({
 PilgrimImportStage stage, String? fileName, List<List<String>> table, PilgrimImportPreview? preview, PilgrimImportResult? result, String? error, bool busy
});




}
/// @nodoc
class __$PilgrimImportStateCopyWithImpl<$Res>
    implements _$PilgrimImportStateCopyWith<$Res> {
  __$PilgrimImportStateCopyWithImpl(this._self, this._then);

  final _PilgrimImportState _self;
  final $Res Function(_PilgrimImportState) _then;

/// Create a copy of PilgrimImportState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? stage = null,Object? fileName = freezed,Object? table = null,Object? preview = freezed,Object? result = freezed,Object? error = freezed,Object? busy = null,}) {
  return _then(_PilgrimImportState(
stage: null == stage ? _self.stage : stage // ignore: cast_nullable_to_non_nullable
as PilgrimImportStage,fileName: freezed == fileName ? _self.fileName : fileName // ignore: cast_nullable_to_non_nullable
as String?,table: null == table ? _self._table : table // ignore: cast_nullable_to_non_nullable
as List<List<String>>,preview: freezed == preview ? _self.preview : preview // ignore: cast_nullable_to_non_nullable
as PilgrimImportPreview?,result: freezed == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as PilgrimImportResult?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,busy: null == busy ? _self.busy : busy // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
