// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pilgrim_field_record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PilgrimFieldRecord {

 String get profileId; String get fullName; String? get passportNumber; String? get travelPermitNumber; String? get fieldStatus; String? get medicalTestStatus; String? get hotelName; String? get transportationDetails;
/// Create a copy of PilgrimFieldRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PilgrimFieldRecordCopyWith<PilgrimFieldRecord> get copyWith => _$PilgrimFieldRecordCopyWithImpl<PilgrimFieldRecord>(this as PilgrimFieldRecord, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PilgrimFieldRecord&&(identical(other.profileId, profileId) || other.profileId == profileId)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.passportNumber, passportNumber) || other.passportNumber == passportNumber)&&(identical(other.travelPermitNumber, travelPermitNumber) || other.travelPermitNumber == travelPermitNumber)&&(identical(other.fieldStatus, fieldStatus) || other.fieldStatus == fieldStatus)&&(identical(other.medicalTestStatus, medicalTestStatus) || other.medicalTestStatus == medicalTestStatus)&&(identical(other.hotelName, hotelName) || other.hotelName == hotelName)&&(identical(other.transportationDetails, transportationDetails) || other.transportationDetails == transportationDetails));
}


@override
int get hashCode => Object.hash(runtimeType,profileId,fullName,passportNumber,travelPermitNumber,fieldStatus,medicalTestStatus,hotelName,transportationDetails);

@override
String toString() {
  return 'PilgrimFieldRecord(profileId: $profileId, fullName: $fullName, passportNumber: $passportNumber, travelPermitNumber: $travelPermitNumber, fieldStatus: $fieldStatus, medicalTestStatus: $medicalTestStatus, hotelName: $hotelName, transportationDetails: $transportationDetails)';
}


}

/// @nodoc
abstract mixin class $PilgrimFieldRecordCopyWith<$Res>  {
  factory $PilgrimFieldRecordCopyWith(PilgrimFieldRecord value, $Res Function(PilgrimFieldRecord) _then) = _$PilgrimFieldRecordCopyWithImpl;
@useResult
$Res call({
 String profileId, String fullName, String? passportNumber, String? travelPermitNumber, String? fieldStatus, String? medicalTestStatus, String? hotelName, String? transportationDetails
});




}
/// @nodoc
class _$PilgrimFieldRecordCopyWithImpl<$Res>
    implements $PilgrimFieldRecordCopyWith<$Res> {
  _$PilgrimFieldRecordCopyWithImpl(this._self, this._then);

  final PilgrimFieldRecord _self;
  final $Res Function(PilgrimFieldRecord) _then;

/// Create a copy of PilgrimFieldRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? profileId = null,Object? fullName = null,Object? passportNumber = freezed,Object? travelPermitNumber = freezed,Object? fieldStatus = freezed,Object? medicalTestStatus = freezed,Object? hotelName = freezed,Object? transportationDetails = freezed,}) {
  return _then(_self.copyWith(
profileId: null == profileId ? _self.profileId : profileId // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,passportNumber: freezed == passportNumber ? _self.passportNumber : passportNumber // ignore: cast_nullable_to_non_nullable
as String?,travelPermitNumber: freezed == travelPermitNumber ? _self.travelPermitNumber : travelPermitNumber // ignore: cast_nullable_to_non_nullable
as String?,fieldStatus: freezed == fieldStatus ? _self.fieldStatus : fieldStatus // ignore: cast_nullable_to_non_nullable
as String?,medicalTestStatus: freezed == medicalTestStatus ? _self.medicalTestStatus : medicalTestStatus // ignore: cast_nullable_to_non_nullable
as String?,hotelName: freezed == hotelName ? _self.hotelName : hotelName // ignore: cast_nullable_to_non_nullable
as String?,transportationDetails: freezed == transportationDetails ? _self.transportationDetails : transportationDetails // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PilgrimFieldRecord].
extension PilgrimFieldRecordPatterns on PilgrimFieldRecord {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PilgrimFieldRecord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PilgrimFieldRecord() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PilgrimFieldRecord value)  $default,){
final _that = this;
switch (_that) {
case _PilgrimFieldRecord():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PilgrimFieldRecord value)?  $default,){
final _that = this;
switch (_that) {
case _PilgrimFieldRecord() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String profileId,  String fullName,  String? passportNumber,  String? travelPermitNumber,  String? fieldStatus,  String? medicalTestStatus,  String? hotelName,  String? transportationDetails)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PilgrimFieldRecord() when $default != null:
return $default(_that.profileId,_that.fullName,_that.passportNumber,_that.travelPermitNumber,_that.fieldStatus,_that.medicalTestStatus,_that.hotelName,_that.transportationDetails);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String profileId,  String fullName,  String? passportNumber,  String? travelPermitNumber,  String? fieldStatus,  String? medicalTestStatus,  String? hotelName,  String? transportationDetails)  $default,) {final _that = this;
switch (_that) {
case _PilgrimFieldRecord():
return $default(_that.profileId,_that.fullName,_that.passportNumber,_that.travelPermitNumber,_that.fieldStatus,_that.medicalTestStatus,_that.hotelName,_that.transportationDetails);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String profileId,  String fullName,  String? passportNumber,  String? travelPermitNumber,  String? fieldStatus,  String? medicalTestStatus,  String? hotelName,  String? transportationDetails)?  $default,) {final _that = this;
switch (_that) {
case _PilgrimFieldRecord() when $default != null:
return $default(_that.profileId,_that.fullName,_that.passportNumber,_that.travelPermitNumber,_that.fieldStatus,_that.medicalTestStatus,_that.hotelName,_that.transportationDetails);case _:
  return null;

}
}

}

/// @nodoc


class _PilgrimFieldRecord implements PilgrimFieldRecord {
  const _PilgrimFieldRecord({required this.profileId, required this.fullName, required this.passportNumber, required this.travelPermitNumber, required this.fieldStatus, required this.medicalTestStatus, required this.hotelName, required this.transportationDetails});
  

@override final  String profileId;
@override final  String fullName;
@override final  String? passportNumber;
@override final  String? travelPermitNumber;
@override final  String? fieldStatus;
@override final  String? medicalTestStatus;
@override final  String? hotelName;
@override final  String? transportationDetails;

/// Create a copy of PilgrimFieldRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PilgrimFieldRecordCopyWith<_PilgrimFieldRecord> get copyWith => __$PilgrimFieldRecordCopyWithImpl<_PilgrimFieldRecord>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PilgrimFieldRecord&&(identical(other.profileId, profileId) || other.profileId == profileId)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.passportNumber, passportNumber) || other.passportNumber == passportNumber)&&(identical(other.travelPermitNumber, travelPermitNumber) || other.travelPermitNumber == travelPermitNumber)&&(identical(other.fieldStatus, fieldStatus) || other.fieldStatus == fieldStatus)&&(identical(other.medicalTestStatus, medicalTestStatus) || other.medicalTestStatus == medicalTestStatus)&&(identical(other.hotelName, hotelName) || other.hotelName == hotelName)&&(identical(other.transportationDetails, transportationDetails) || other.transportationDetails == transportationDetails));
}


@override
int get hashCode => Object.hash(runtimeType,profileId,fullName,passportNumber,travelPermitNumber,fieldStatus,medicalTestStatus,hotelName,transportationDetails);

@override
String toString() {
  return 'PilgrimFieldRecord(profileId: $profileId, fullName: $fullName, passportNumber: $passportNumber, travelPermitNumber: $travelPermitNumber, fieldStatus: $fieldStatus, medicalTestStatus: $medicalTestStatus, hotelName: $hotelName, transportationDetails: $transportationDetails)';
}


}

/// @nodoc
abstract mixin class _$PilgrimFieldRecordCopyWith<$Res> implements $PilgrimFieldRecordCopyWith<$Res> {
  factory _$PilgrimFieldRecordCopyWith(_PilgrimFieldRecord value, $Res Function(_PilgrimFieldRecord) _then) = __$PilgrimFieldRecordCopyWithImpl;
@override @useResult
$Res call({
 String profileId, String fullName, String? passportNumber, String? travelPermitNumber, String? fieldStatus, String? medicalTestStatus, String? hotelName, String? transportationDetails
});




}
/// @nodoc
class __$PilgrimFieldRecordCopyWithImpl<$Res>
    implements _$PilgrimFieldRecordCopyWith<$Res> {
  __$PilgrimFieldRecordCopyWithImpl(this._self, this._then);

  final _PilgrimFieldRecord _self;
  final $Res Function(_PilgrimFieldRecord) _then;

/// Create a copy of PilgrimFieldRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? profileId = null,Object? fullName = null,Object? passportNumber = freezed,Object? travelPermitNumber = freezed,Object? fieldStatus = freezed,Object? medicalTestStatus = freezed,Object? hotelName = freezed,Object? transportationDetails = freezed,}) {
  return _then(_PilgrimFieldRecord(
profileId: null == profileId ? _self.profileId : profileId // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,passportNumber: freezed == passportNumber ? _self.passportNumber : passportNumber // ignore: cast_nullable_to_non_nullable
as String?,travelPermitNumber: freezed == travelPermitNumber ? _self.travelPermitNumber : travelPermitNumber // ignore: cast_nullable_to_non_nullable
as String?,fieldStatus: freezed == fieldStatus ? _self.fieldStatus : fieldStatus // ignore: cast_nullable_to_non_nullable
as String?,medicalTestStatus: freezed == medicalTestStatus ? _self.medicalTestStatus : medicalTestStatus // ignore: cast_nullable_to_non_nullable
as String?,hotelName: freezed == hotelName ? _self.hotelName : hotelName // ignore: cast_nullable_to_non_nullable
as String?,transportationDetails: freezed == transportationDetails ? _self.transportationDetails : transportationDetails // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
