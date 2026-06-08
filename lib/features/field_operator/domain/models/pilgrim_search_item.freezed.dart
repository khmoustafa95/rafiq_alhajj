// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pilgrim_search_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PilgrimSearchItem {

 String get profileId; String get fullName; String? get passportNumber; String? get travelPermitNumber; String? get fieldStatus; String? get medicalTestStatus; String? get groupName; String? get stickerNumber; String? get visaNumber; String? get phoneNumber; String? get cluster;
/// Create a copy of PilgrimSearchItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PilgrimSearchItemCopyWith<PilgrimSearchItem> get copyWith => _$PilgrimSearchItemCopyWithImpl<PilgrimSearchItem>(this as PilgrimSearchItem, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PilgrimSearchItem&&(identical(other.profileId, profileId) || other.profileId == profileId)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.passportNumber, passportNumber) || other.passportNumber == passportNumber)&&(identical(other.travelPermitNumber, travelPermitNumber) || other.travelPermitNumber == travelPermitNumber)&&(identical(other.fieldStatus, fieldStatus) || other.fieldStatus == fieldStatus)&&(identical(other.medicalTestStatus, medicalTestStatus) || other.medicalTestStatus == medicalTestStatus)&&(identical(other.groupName, groupName) || other.groupName == groupName)&&(identical(other.stickerNumber, stickerNumber) || other.stickerNumber == stickerNumber)&&(identical(other.visaNumber, visaNumber) || other.visaNumber == visaNumber)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.cluster, cluster) || other.cluster == cluster));
}


@override
int get hashCode => Object.hash(runtimeType,profileId,fullName,passportNumber,travelPermitNumber,fieldStatus,medicalTestStatus,groupName,stickerNumber,visaNumber,phoneNumber,cluster);

@override
String toString() {
  return 'PilgrimSearchItem(profileId: $profileId, fullName: $fullName, passportNumber: $passportNumber, travelPermitNumber: $travelPermitNumber, fieldStatus: $fieldStatus, medicalTestStatus: $medicalTestStatus, groupName: $groupName, stickerNumber: $stickerNumber, visaNumber: $visaNumber, phoneNumber: $phoneNumber, cluster: $cluster)';
}


}

/// @nodoc
abstract mixin class $PilgrimSearchItemCopyWith<$Res>  {
  factory $PilgrimSearchItemCopyWith(PilgrimSearchItem value, $Res Function(PilgrimSearchItem) _then) = _$PilgrimSearchItemCopyWithImpl;
@useResult
$Res call({
 String profileId, String fullName, String? passportNumber, String? travelPermitNumber, String? fieldStatus, String? medicalTestStatus, String? groupName, String? stickerNumber, String? visaNumber, String? phoneNumber, String? cluster
});




}
/// @nodoc
class _$PilgrimSearchItemCopyWithImpl<$Res>
    implements $PilgrimSearchItemCopyWith<$Res> {
  _$PilgrimSearchItemCopyWithImpl(this._self, this._then);

  final PilgrimSearchItem _self;
  final $Res Function(PilgrimSearchItem) _then;

/// Create a copy of PilgrimSearchItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? profileId = null,Object? fullName = null,Object? passportNumber = freezed,Object? travelPermitNumber = freezed,Object? fieldStatus = freezed,Object? medicalTestStatus = freezed,Object? groupName = freezed,Object? stickerNumber = freezed,Object? visaNumber = freezed,Object? phoneNumber = freezed,Object? cluster = freezed,}) {
  return _then(_self.copyWith(
profileId: null == profileId ? _self.profileId : profileId // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,passportNumber: freezed == passportNumber ? _self.passportNumber : passportNumber // ignore: cast_nullable_to_non_nullable
as String?,travelPermitNumber: freezed == travelPermitNumber ? _self.travelPermitNumber : travelPermitNumber // ignore: cast_nullable_to_non_nullable
as String?,fieldStatus: freezed == fieldStatus ? _self.fieldStatus : fieldStatus // ignore: cast_nullable_to_non_nullable
as String?,medicalTestStatus: freezed == medicalTestStatus ? _self.medicalTestStatus : medicalTestStatus // ignore: cast_nullable_to_non_nullable
as String?,groupName: freezed == groupName ? _self.groupName : groupName // ignore: cast_nullable_to_non_nullable
as String?,stickerNumber: freezed == stickerNumber ? _self.stickerNumber : stickerNumber // ignore: cast_nullable_to_non_nullable
as String?,visaNumber: freezed == visaNumber ? _self.visaNumber : visaNumber // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,cluster: freezed == cluster ? _self.cluster : cluster // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PilgrimSearchItem].
extension PilgrimSearchItemPatterns on PilgrimSearchItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PilgrimSearchItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PilgrimSearchItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PilgrimSearchItem value)  $default,){
final _that = this;
switch (_that) {
case _PilgrimSearchItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PilgrimSearchItem value)?  $default,){
final _that = this;
switch (_that) {
case _PilgrimSearchItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String profileId,  String fullName,  String? passportNumber,  String? travelPermitNumber,  String? fieldStatus,  String? medicalTestStatus,  String? groupName,  String? stickerNumber,  String? visaNumber,  String? phoneNumber,  String? cluster)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PilgrimSearchItem() when $default != null:
return $default(_that.profileId,_that.fullName,_that.passportNumber,_that.travelPermitNumber,_that.fieldStatus,_that.medicalTestStatus,_that.groupName,_that.stickerNumber,_that.visaNumber,_that.phoneNumber,_that.cluster);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String profileId,  String fullName,  String? passportNumber,  String? travelPermitNumber,  String? fieldStatus,  String? medicalTestStatus,  String? groupName,  String? stickerNumber,  String? visaNumber,  String? phoneNumber,  String? cluster)  $default,) {final _that = this;
switch (_that) {
case _PilgrimSearchItem():
return $default(_that.profileId,_that.fullName,_that.passportNumber,_that.travelPermitNumber,_that.fieldStatus,_that.medicalTestStatus,_that.groupName,_that.stickerNumber,_that.visaNumber,_that.phoneNumber,_that.cluster);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String profileId,  String fullName,  String? passportNumber,  String? travelPermitNumber,  String? fieldStatus,  String? medicalTestStatus,  String? groupName,  String? stickerNumber,  String? visaNumber,  String? phoneNumber,  String? cluster)?  $default,) {final _that = this;
switch (_that) {
case _PilgrimSearchItem() when $default != null:
return $default(_that.profileId,_that.fullName,_that.passportNumber,_that.travelPermitNumber,_that.fieldStatus,_that.medicalTestStatus,_that.groupName,_that.stickerNumber,_that.visaNumber,_that.phoneNumber,_that.cluster);case _:
  return null;

}
}

}

/// @nodoc


class _PilgrimSearchItem implements PilgrimSearchItem {
  const _PilgrimSearchItem({required this.profileId, required this.fullName, required this.passportNumber, required this.travelPermitNumber, required this.fieldStatus, required this.medicalTestStatus, this.groupName, this.stickerNumber, this.visaNumber, this.phoneNumber, this.cluster});
  

@override final  String profileId;
@override final  String fullName;
@override final  String? passportNumber;
@override final  String? travelPermitNumber;
@override final  String? fieldStatus;
@override final  String? medicalTestStatus;
@override final  String? groupName;
@override final  String? stickerNumber;
@override final  String? visaNumber;
@override final  String? phoneNumber;
@override final  String? cluster;

/// Create a copy of PilgrimSearchItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PilgrimSearchItemCopyWith<_PilgrimSearchItem> get copyWith => __$PilgrimSearchItemCopyWithImpl<_PilgrimSearchItem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PilgrimSearchItem&&(identical(other.profileId, profileId) || other.profileId == profileId)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.passportNumber, passportNumber) || other.passportNumber == passportNumber)&&(identical(other.travelPermitNumber, travelPermitNumber) || other.travelPermitNumber == travelPermitNumber)&&(identical(other.fieldStatus, fieldStatus) || other.fieldStatus == fieldStatus)&&(identical(other.medicalTestStatus, medicalTestStatus) || other.medicalTestStatus == medicalTestStatus)&&(identical(other.groupName, groupName) || other.groupName == groupName)&&(identical(other.stickerNumber, stickerNumber) || other.stickerNumber == stickerNumber)&&(identical(other.visaNumber, visaNumber) || other.visaNumber == visaNumber)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.cluster, cluster) || other.cluster == cluster));
}


@override
int get hashCode => Object.hash(runtimeType,profileId,fullName,passportNumber,travelPermitNumber,fieldStatus,medicalTestStatus,groupName,stickerNumber,visaNumber,phoneNumber,cluster);

@override
String toString() {
  return 'PilgrimSearchItem(profileId: $profileId, fullName: $fullName, passportNumber: $passportNumber, travelPermitNumber: $travelPermitNumber, fieldStatus: $fieldStatus, medicalTestStatus: $medicalTestStatus, groupName: $groupName, stickerNumber: $stickerNumber, visaNumber: $visaNumber, phoneNumber: $phoneNumber, cluster: $cluster)';
}


}

/// @nodoc
abstract mixin class _$PilgrimSearchItemCopyWith<$Res> implements $PilgrimSearchItemCopyWith<$Res> {
  factory _$PilgrimSearchItemCopyWith(_PilgrimSearchItem value, $Res Function(_PilgrimSearchItem) _then) = __$PilgrimSearchItemCopyWithImpl;
@override @useResult
$Res call({
 String profileId, String fullName, String? passportNumber, String? travelPermitNumber, String? fieldStatus, String? medicalTestStatus, String? groupName, String? stickerNumber, String? visaNumber, String? phoneNumber, String? cluster
});




}
/// @nodoc
class __$PilgrimSearchItemCopyWithImpl<$Res>
    implements _$PilgrimSearchItemCopyWith<$Res> {
  __$PilgrimSearchItemCopyWithImpl(this._self, this._then);

  final _PilgrimSearchItem _self;
  final $Res Function(_PilgrimSearchItem) _then;

/// Create a copy of PilgrimSearchItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? profileId = null,Object? fullName = null,Object? passportNumber = freezed,Object? travelPermitNumber = freezed,Object? fieldStatus = freezed,Object? medicalTestStatus = freezed,Object? groupName = freezed,Object? stickerNumber = freezed,Object? visaNumber = freezed,Object? phoneNumber = freezed,Object? cluster = freezed,}) {
  return _then(_PilgrimSearchItem(
profileId: null == profileId ? _self.profileId : profileId // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,passportNumber: freezed == passportNumber ? _self.passportNumber : passportNumber // ignore: cast_nullable_to_non_nullable
as String?,travelPermitNumber: freezed == travelPermitNumber ? _self.travelPermitNumber : travelPermitNumber // ignore: cast_nullable_to_non_nullable
as String?,fieldStatus: freezed == fieldStatus ? _self.fieldStatus : fieldStatus // ignore: cast_nullable_to_non_nullable
as String?,medicalTestStatus: freezed == medicalTestStatus ? _self.medicalTestStatus : medicalTestStatus // ignore: cast_nullable_to_non_nullable
as String?,groupName: freezed == groupName ? _self.groupName : groupName // ignore: cast_nullable_to_non_nullable
as String?,stickerNumber: freezed == stickerNumber ? _self.stickerNumber : stickerNumber // ignore: cast_nullable_to_non_nullable
as String?,visaNumber: freezed == visaNumber ? _self.visaNumber : visaNumber // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,cluster: freezed == cluster ? _self.cluster : cluster // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
