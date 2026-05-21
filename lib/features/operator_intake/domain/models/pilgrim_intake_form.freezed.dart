// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pilgrim_intake_form.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PilgrimIntakeForm {

 String get fullName; String get email; String? get passportNumber; String? get travelPermitNumber; String? get medicalTestStatus; DateTime? get travelDate; String? get hotelName; String? get hotelLocationUrl; String? get transportationDetails;
/// Create a copy of PilgrimIntakeForm
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PilgrimIntakeFormCopyWith<PilgrimIntakeForm> get copyWith => _$PilgrimIntakeFormCopyWithImpl<PilgrimIntakeForm>(this as PilgrimIntakeForm, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PilgrimIntakeForm&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.email, email) || other.email == email)&&(identical(other.passportNumber, passportNumber) || other.passportNumber == passportNumber)&&(identical(other.travelPermitNumber, travelPermitNumber) || other.travelPermitNumber == travelPermitNumber)&&(identical(other.medicalTestStatus, medicalTestStatus) || other.medicalTestStatus == medicalTestStatus)&&(identical(other.travelDate, travelDate) || other.travelDate == travelDate)&&(identical(other.hotelName, hotelName) || other.hotelName == hotelName)&&(identical(other.hotelLocationUrl, hotelLocationUrl) || other.hotelLocationUrl == hotelLocationUrl)&&(identical(other.transportationDetails, transportationDetails) || other.transportationDetails == transportationDetails));
}


@override
int get hashCode => Object.hash(runtimeType,fullName,email,passportNumber,travelPermitNumber,medicalTestStatus,travelDate,hotelName,hotelLocationUrl,transportationDetails);

@override
String toString() {
  return 'PilgrimIntakeForm(fullName: $fullName, email: $email, passportNumber: $passportNumber, travelPermitNumber: $travelPermitNumber, medicalTestStatus: $medicalTestStatus, travelDate: $travelDate, hotelName: $hotelName, hotelLocationUrl: $hotelLocationUrl, transportationDetails: $transportationDetails)';
}


}

/// @nodoc
abstract mixin class $PilgrimIntakeFormCopyWith<$Res>  {
  factory $PilgrimIntakeFormCopyWith(PilgrimIntakeForm value, $Res Function(PilgrimIntakeForm) _then) = _$PilgrimIntakeFormCopyWithImpl;
@useResult
$Res call({
 String fullName, String email, String? passportNumber, String? travelPermitNumber, String? medicalTestStatus, DateTime? travelDate, String? hotelName, String? hotelLocationUrl, String? transportationDetails
});




}
/// @nodoc
class _$PilgrimIntakeFormCopyWithImpl<$Res>
    implements $PilgrimIntakeFormCopyWith<$Res> {
  _$PilgrimIntakeFormCopyWithImpl(this._self, this._then);

  final PilgrimIntakeForm _self;
  final $Res Function(PilgrimIntakeForm) _then;

/// Create a copy of PilgrimIntakeForm
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fullName = null,Object? email = null,Object? passportNumber = freezed,Object? travelPermitNumber = freezed,Object? medicalTestStatus = freezed,Object? travelDate = freezed,Object? hotelName = freezed,Object? hotelLocationUrl = freezed,Object? transportationDetails = freezed,}) {
  return _then(_self.copyWith(
fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,passportNumber: freezed == passportNumber ? _self.passportNumber : passportNumber // ignore: cast_nullable_to_non_nullable
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


/// Adds pattern-matching-related methods to [PilgrimIntakeForm].
extension PilgrimIntakeFormPatterns on PilgrimIntakeForm {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PilgrimIntakeForm value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PilgrimIntakeForm() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PilgrimIntakeForm value)  $default,){
final _that = this;
switch (_that) {
case _PilgrimIntakeForm():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PilgrimIntakeForm value)?  $default,){
final _that = this;
switch (_that) {
case _PilgrimIntakeForm() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String fullName,  String email,  String? passportNumber,  String? travelPermitNumber,  String? medicalTestStatus,  DateTime? travelDate,  String? hotelName,  String? hotelLocationUrl,  String? transportationDetails)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PilgrimIntakeForm() when $default != null:
return $default(_that.fullName,_that.email,_that.passportNumber,_that.travelPermitNumber,_that.medicalTestStatus,_that.travelDate,_that.hotelName,_that.hotelLocationUrl,_that.transportationDetails);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String fullName,  String email,  String? passportNumber,  String? travelPermitNumber,  String? medicalTestStatus,  DateTime? travelDate,  String? hotelName,  String? hotelLocationUrl,  String? transportationDetails)  $default,) {final _that = this;
switch (_that) {
case _PilgrimIntakeForm():
return $default(_that.fullName,_that.email,_that.passportNumber,_that.travelPermitNumber,_that.medicalTestStatus,_that.travelDate,_that.hotelName,_that.hotelLocationUrl,_that.transportationDetails);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String fullName,  String email,  String? passportNumber,  String? travelPermitNumber,  String? medicalTestStatus,  DateTime? travelDate,  String? hotelName,  String? hotelLocationUrl,  String? transportationDetails)?  $default,) {final _that = this;
switch (_that) {
case _PilgrimIntakeForm() when $default != null:
return $default(_that.fullName,_that.email,_that.passportNumber,_that.travelPermitNumber,_that.medicalTestStatus,_that.travelDate,_that.hotelName,_that.hotelLocationUrl,_that.transportationDetails);case _:
  return null;

}
}

}

/// @nodoc


class _PilgrimIntakeForm implements PilgrimIntakeForm {
  const _PilgrimIntakeForm({required this.fullName, required this.email, this.passportNumber, this.travelPermitNumber, this.medicalTestStatus, this.travelDate, this.hotelName, this.hotelLocationUrl, this.transportationDetails});
  

@override final  String fullName;
@override final  String email;
@override final  String? passportNumber;
@override final  String? travelPermitNumber;
@override final  String? medicalTestStatus;
@override final  DateTime? travelDate;
@override final  String? hotelName;
@override final  String? hotelLocationUrl;
@override final  String? transportationDetails;

/// Create a copy of PilgrimIntakeForm
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PilgrimIntakeFormCopyWith<_PilgrimIntakeForm> get copyWith => __$PilgrimIntakeFormCopyWithImpl<_PilgrimIntakeForm>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PilgrimIntakeForm&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.email, email) || other.email == email)&&(identical(other.passportNumber, passportNumber) || other.passportNumber == passportNumber)&&(identical(other.travelPermitNumber, travelPermitNumber) || other.travelPermitNumber == travelPermitNumber)&&(identical(other.medicalTestStatus, medicalTestStatus) || other.medicalTestStatus == medicalTestStatus)&&(identical(other.travelDate, travelDate) || other.travelDate == travelDate)&&(identical(other.hotelName, hotelName) || other.hotelName == hotelName)&&(identical(other.hotelLocationUrl, hotelLocationUrl) || other.hotelLocationUrl == hotelLocationUrl)&&(identical(other.transportationDetails, transportationDetails) || other.transportationDetails == transportationDetails));
}


@override
int get hashCode => Object.hash(runtimeType,fullName,email,passportNumber,travelPermitNumber,medicalTestStatus,travelDate,hotelName,hotelLocationUrl,transportationDetails);

@override
String toString() {
  return 'PilgrimIntakeForm(fullName: $fullName, email: $email, passportNumber: $passportNumber, travelPermitNumber: $travelPermitNumber, medicalTestStatus: $medicalTestStatus, travelDate: $travelDate, hotelName: $hotelName, hotelLocationUrl: $hotelLocationUrl, transportationDetails: $transportationDetails)';
}


}

/// @nodoc
abstract mixin class _$PilgrimIntakeFormCopyWith<$Res> implements $PilgrimIntakeFormCopyWith<$Res> {
  factory _$PilgrimIntakeFormCopyWith(_PilgrimIntakeForm value, $Res Function(_PilgrimIntakeForm) _then) = __$PilgrimIntakeFormCopyWithImpl;
@override @useResult
$Res call({
 String fullName, String email, String? passportNumber, String? travelPermitNumber, String? medicalTestStatus, DateTime? travelDate, String? hotelName, String? hotelLocationUrl, String? transportationDetails
});




}
/// @nodoc
class __$PilgrimIntakeFormCopyWithImpl<$Res>
    implements _$PilgrimIntakeFormCopyWith<$Res> {
  __$PilgrimIntakeFormCopyWithImpl(this._self, this._then);

  final _PilgrimIntakeForm _self;
  final $Res Function(_PilgrimIntakeForm) _then;

/// Create a copy of PilgrimIntakeForm
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fullName = null,Object? email = null,Object? passportNumber = freezed,Object? travelPermitNumber = freezed,Object? medicalTestStatus = freezed,Object? travelDate = freezed,Object? hotelName = freezed,Object? hotelLocationUrl = freezed,Object? transportationDetails = freezed,}) {
  return _then(_PilgrimIntakeForm(
fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,passportNumber: freezed == passportNumber ? _self.passportNumber : passportNumber // ignore: cast_nullable_to_non_nullable
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
