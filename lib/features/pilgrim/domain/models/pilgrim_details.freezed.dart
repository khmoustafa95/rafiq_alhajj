// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pilgrim_details.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PilgrimDetails {

 String? get passportNumber; String? get travelPermitNumber; String? get medicalTestStatus; DateTime? get travelDate; String? get hotelName; String? get hotelLocationUrl; String? get transportationDetails;
/// Create a copy of PilgrimDetails
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PilgrimDetailsCopyWith<PilgrimDetails> get copyWith => _$PilgrimDetailsCopyWithImpl<PilgrimDetails>(this as PilgrimDetails, _$identity);

  /// Serializes this PilgrimDetails to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PilgrimDetails&&(identical(other.passportNumber, passportNumber) || other.passportNumber == passportNumber)&&(identical(other.travelPermitNumber, travelPermitNumber) || other.travelPermitNumber == travelPermitNumber)&&(identical(other.medicalTestStatus, medicalTestStatus) || other.medicalTestStatus == medicalTestStatus)&&(identical(other.travelDate, travelDate) || other.travelDate == travelDate)&&(identical(other.hotelName, hotelName) || other.hotelName == hotelName)&&(identical(other.hotelLocationUrl, hotelLocationUrl) || other.hotelLocationUrl == hotelLocationUrl)&&(identical(other.transportationDetails, transportationDetails) || other.transportationDetails == transportationDetails));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,passportNumber,travelPermitNumber,medicalTestStatus,travelDate,hotelName,hotelLocationUrl,transportationDetails);

@override
String toString() {
  return 'PilgrimDetails(passportNumber: $passportNumber, travelPermitNumber: $travelPermitNumber, medicalTestStatus: $medicalTestStatus, travelDate: $travelDate, hotelName: $hotelName, hotelLocationUrl: $hotelLocationUrl, transportationDetails: $transportationDetails)';
}


}

/// @nodoc
abstract mixin class $PilgrimDetailsCopyWith<$Res>  {
  factory $PilgrimDetailsCopyWith(PilgrimDetails value, $Res Function(PilgrimDetails) _then) = _$PilgrimDetailsCopyWithImpl;
@useResult
$Res call({
 String? passportNumber, String? travelPermitNumber, String? medicalTestStatus, DateTime? travelDate, String? hotelName, String? hotelLocationUrl, String? transportationDetails
});




}
/// @nodoc
class _$PilgrimDetailsCopyWithImpl<$Res>
    implements $PilgrimDetailsCopyWith<$Res> {
  _$PilgrimDetailsCopyWithImpl(this._self, this._then);

  final PilgrimDetails _self;
  final $Res Function(PilgrimDetails) _then;

/// Create a copy of PilgrimDetails
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? passportNumber = freezed,Object? travelPermitNumber = freezed,Object? medicalTestStatus = freezed,Object? travelDate = freezed,Object? hotelName = freezed,Object? hotelLocationUrl = freezed,Object? transportationDetails = freezed,}) {
  return _then(_self.copyWith(
passportNumber: freezed == passportNumber ? _self.passportNumber : passportNumber // ignore: cast_nullable_to_non_nullable
as String?,travelPermitNumber: freezed == travelPermitNumber ? _self.travelPermitNumber : travelPermitNumber // ignore: cast_nullable_to_non_nullable
as String?,medicalTestStatus: freezed == medicalTestStatus ? _self.medicalTestStatus : medicalTestStatus // ignore: cast_nullable_to_non_nullable
as String?,travelDate: freezed == travelDate ? _self.travelDate : travelDate // ignore: cast_nullable_to_non_nullable
as DateTime?,hotelName: freezed == hotelName ? _self.hotelName : hotelName // ignore: cast_nullable_to_non_nullable
as String?,hotelLocationUrl: freezed == hotelLocationUrl ? _self.hotelLocationUrl : hotelLocationUrl // ignore: cast_nullable_to_non_nullable
as String?,transportationDetails: freezed == transportationDetails ? _self.transportationDetails : transportationDetails // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PilgrimDetails].
extension PilgrimDetailsPatterns on PilgrimDetails {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PilgrimDetails value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PilgrimDetails() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PilgrimDetails value)  $default,){
final _that = this;
switch (_that) {
case _PilgrimDetails():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PilgrimDetails value)?  $default,){
final _that = this;
switch (_that) {
case _PilgrimDetails() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? passportNumber,  String? travelPermitNumber,  String? medicalTestStatus,  DateTime? travelDate,  String? hotelName,  String? hotelLocationUrl,  String? transportationDetails)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PilgrimDetails() when $default != null:
return $default(_that.passportNumber,_that.travelPermitNumber,_that.medicalTestStatus,_that.travelDate,_that.hotelName,_that.hotelLocationUrl,_that.transportationDetails);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? passportNumber,  String? travelPermitNumber,  String? medicalTestStatus,  DateTime? travelDate,  String? hotelName,  String? hotelLocationUrl,  String? transportationDetails)  $default,) {final _that = this;
switch (_that) {
case _PilgrimDetails():
return $default(_that.passportNumber,_that.travelPermitNumber,_that.medicalTestStatus,_that.travelDate,_that.hotelName,_that.hotelLocationUrl,_that.transportationDetails);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? passportNumber,  String? travelPermitNumber,  String? medicalTestStatus,  DateTime? travelDate,  String? hotelName,  String? hotelLocationUrl,  String? transportationDetails)?  $default,) {final _that = this;
switch (_that) {
case _PilgrimDetails() when $default != null:
return $default(_that.passportNumber,_that.travelPermitNumber,_that.medicalTestStatus,_that.travelDate,_that.hotelName,_that.hotelLocationUrl,_that.transportationDetails);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PilgrimDetails implements PilgrimDetails {
  const _PilgrimDetails({required this.passportNumber, required this.travelPermitNumber, required this.medicalTestStatus, required this.travelDate, required this.hotelName, required this.hotelLocationUrl, required this.transportationDetails});
  factory _PilgrimDetails.fromJson(Map<String, dynamic> json) => _$PilgrimDetailsFromJson(json);

@override final  String? passportNumber;
@override final  String? travelPermitNumber;
@override final  String? medicalTestStatus;
@override final  DateTime? travelDate;
@override final  String? hotelName;
@override final  String? hotelLocationUrl;
@override final  String? transportationDetails;

/// Create a copy of PilgrimDetails
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PilgrimDetailsCopyWith<_PilgrimDetails> get copyWith => __$PilgrimDetailsCopyWithImpl<_PilgrimDetails>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PilgrimDetailsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PilgrimDetails&&(identical(other.passportNumber, passportNumber) || other.passportNumber == passportNumber)&&(identical(other.travelPermitNumber, travelPermitNumber) || other.travelPermitNumber == travelPermitNumber)&&(identical(other.medicalTestStatus, medicalTestStatus) || other.medicalTestStatus == medicalTestStatus)&&(identical(other.travelDate, travelDate) || other.travelDate == travelDate)&&(identical(other.hotelName, hotelName) || other.hotelName == hotelName)&&(identical(other.hotelLocationUrl, hotelLocationUrl) || other.hotelLocationUrl == hotelLocationUrl)&&(identical(other.transportationDetails, transportationDetails) || other.transportationDetails == transportationDetails));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,passportNumber,travelPermitNumber,medicalTestStatus,travelDate,hotelName,hotelLocationUrl,transportationDetails);

@override
String toString() {
  return 'PilgrimDetails(passportNumber: $passportNumber, travelPermitNumber: $travelPermitNumber, medicalTestStatus: $medicalTestStatus, travelDate: $travelDate, hotelName: $hotelName, hotelLocationUrl: $hotelLocationUrl, transportationDetails: $transportationDetails)';
}


}

/// @nodoc
abstract mixin class _$PilgrimDetailsCopyWith<$Res> implements $PilgrimDetailsCopyWith<$Res> {
  factory _$PilgrimDetailsCopyWith(_PilgrimDetails value, $Res Function(_PilgrimDetails) _then) = __$PilgrimDetailsCopyWithImpl;
@override @useResult
$Res call({
 String? passportNumber, String? travelPermitNumber, String? medicalTestStatus, DateTime? travelDate, String? hotelName, String? hotelLocationUrl, String? transportationDetails
});




}
/// @nodoc
class __$PilgrimDetailsCopyWithImpl<$Res>
    implements _$PilgrimDetailsCopyWith<$Res> {
  __$PilgrimDetailsCopyWithImpl(this._self, this._then);

  final _PilgrimDetails _self;
  final $Res Function(_PilgrimDetails) _then;

/// Create a copy of PilgrimDetails
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? passportNumber = freezed,Object? travelPermitNumber = freezed,Object? medicalTestStatus = freezed,Object? travelDate = freezed,Object? hotelName = freezed,Object? hotelLocationUrl = freezed,Object? transportationDetails = freezed,}) {
  return _then(_PilgrimDetails(
passportNumber: freezed == passportNumber ? _self.passportNumber : passportNumber // ignore: cast_nullable_to_non_nullable
as String?,travelPermitNumber: freezed == travelPermitNumber ? _self.travelPermitNumber : travelPermitNumber // ignore: cast_nullable_to_non_nullable
as String?,medicalTestStatus: freezed == medicalTestStatus ? _self.medicalTestStatus : medicalTestStatus // ignore: cast_nullable_to_non_nullable
as String?,travelDate: freezed == travelDate ? _self.travelDate : travelDate // ignore: cast_nullable_to_non_nullable
as DateTime?,hotelName: freezed == hotelName ? _self.hotelName : hotelName // ignore: cast_nullable_to_non_nullable
as String?,hotelLocationUrl: freezed == hotelLocationUrl ? _self.hotelLocationUrl : hotelLocationUrl // ignore: cast_nullable_to_non_nullable
as String?,transportationDetails: freezed == transportationDetails ? _self.transportationDetails : transportationDetails // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
