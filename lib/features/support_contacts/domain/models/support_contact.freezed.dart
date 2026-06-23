// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'support_contact.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SupportContact {

 String get id; String get labelAr; String get labelEn; String? get descriptionAr; String? get descriptionEn; String? get phoneNumber; String? get whatsappNumber; SupportContactScope get scope; String? get groupId; String? get groupName; bool get isActive; int get sortOrder;
/// Create a copy of SupportContact
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SupportContactCopyWith<SupportContact> get copyWith => _$SupportContactCopyWithImpl<SupportContact>(this as SupportContact, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SupportContact&&(identical(other.id, id) || other.id == id)&&(identical(other.labelAr, labelAr) || other.labelAr == labelAr)&&(identical(other.labelEn, labelEn) || other.labelEn == labelEn)&&(identical(other.descriptionAr, descriptionAr) || other.descriptionAr == descriptionAr)&&(identical(other.descriptionEn, descriptionEn) || other.descriptionEn == descriptionEn)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.whatsappNumber, whatsappNumber) || other.whatsappNumber == whatsappNumber)&&(identical(other.scope, scope) || other.scope == scope)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.groupName, groupName) || other.groupName == groupName)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder));
}


@override
int get hashCode => Object.hash(runtimeType,id,labelAr,labelEn,descriptionAr,descriptionEn,phoneNumber,whatsappNumber,scope,groupId,groupName,isActive,sortOrder);

@override
String toString() {
  return 'SupportContact(id: $id, labelAr: $labelAr, labelEn: $labelEn, descriptionAr: $descriptionAr, descriptionEn: $descriptionEn, phoneNumber: $phoneNumber, whatsappNumber: $whatsappNumber, scope: $scope, groupId: $groupId, groupName: $groupName, isActive: $isActive, sortOrder: $sortOrder)';
}


}

/// @nodoc
abstract mixin class $SupportContactCopyWith<$Res>  {
  factory $SupportContactCopyWith(SupportContact value, $Res Function(SupportContact) _then) = _$SupportContactCopyWithImpl;
@useResult
$Res call({
 String id, String labelAr, String labelEn, String? descriptionAr, String? descriptionEn, String? phoneNumber, String? whatsappNumber, SupportContactScope scope, String? groupId, String? groupName, bool isActive, int sortOrder
});




}
/// @nodoc
class _$SupportContactCopyWithImpl<$Res>
    implements $SupportContactCopyWith<$Res> {
  _$SupportContactCopyWithImpl(this._self, this._then);

  final SupportContact _self;
  final $Res Function(SupportContact) _then;

/// Create a copy of SupportContact
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? labelAr = null,Object? labelEn = null,Object? descriptionAr = freezed,Object? descriptionEn = freezed,Object? phoneNumber = freezed,Object? whatsappNumber = freezed,Object? scope = null,Object? groupId = freezed,Object? groupName = freezed,Object? isActive = null,Object? sortOrder = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,labelAr: null == labelAr ? _self.labelAr : labelAr // ignore: cast_nullable_to_non_nullable
as String,labelEn: null == labelEn ? _self.labelEn : labelEn // ignore: cast_nullable_to_non_nullable
as String,descriptionAr: freezed == descriptionAr ? _self.descriptionAr : descriptionAr // ignore: cast_nullable_to_non_nullable
as String?,descriptionEn: freezed == descriptionEn ? _self.descriptionEn : descriptionEn // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,whatsappNumber: freezed == whatsappNumber ? _self.whatsappNumber : whatsappNumber // ignore: cast_nullable_to_non_nullable
as String?,scope: null == scope ? _self.scope : scope // ignore: cast_nullable_to_non_nullable
as SupportContactScope,groupId: freezed == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String?,groupName: freezed == groupName ? _self.groupName : groupName // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [SupportContact].
extension SupportContactPatterns on SupportContact {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SupportContact value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SupportContact() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SupportContact value)  $default,){
final _that = this;
switch (_that) {
case _SupportContact():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SupportContact value)?  $default,){
final _that = this;
switch (_that) {
case _SupportContact() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String labelAr,  String labelEn,  String? descriptionAr,  String? descriptionEn,  String? phoneNumber,  String? whatsappNumber,  SupportContactScope scope,  String? groupId,  String? groupName,  bool isActive,  int sortOrder)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SupportContact() when $default != null:
return $default(_that.id,_that.labelAr,_that.labelEn,_that.descriptionAr,_that.descriptionEn,_that.phoneNumber,_that.whatsappNumber,_that.scope,_that.groupId,_that.groupName,_that.isActive,_that.sortOrder);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String labelAr,  String labelEn,  String? descriptionAr,  String? descriptionEn,  String? phoneNumber,  String? whatsappNumber,  SupportContactScope scope,  String? groupId,  String? groupName,  bool isActive,  int sortOrder)  $default,) {final _that = this;
switch (_that) {
case _SupportContact():
return $default(_that.id,_that.labelAr,_that.labelEn,_that.descriptionAr,_that.descriptionEn,_that.phoneNumber,_that.whatsappNumber,_that.scope,_that.groupId,_that.groupName,_that.isActive,_that.sortOrder);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String labelAr,  String labelEn,  String? descriptionAr,  String? descriptionEn,  String? phoneNumber,  String? whatsappNumber,  SupportContactScope scope,  String? groupId,  String? groupName,  bool isActive,  int sortOrder)?  $default,) {final _that = this;
switch (_that) {
case _SupportContact() when $default != null:
return $default(_that.id,_that.labelAr,_that.labelEn,_that.descriptionAr,_that.descriptionEn,_that.phoneNumber,_that.whatsappNumber,_that.scope,_that.groupId,_that.groupName,_that.isActive,_that.sortOrder);case _:
  return null;

}
}

}

/// @nodoc


class _SupportContact extends SupportContact {
  const _SupportContact({required this.id, required this.labelAr, required this.labelEn, this.descriptionAr, this.descriptionEn, this.phoneNumber, this.whatsappNumber, this.scope = SupportContactScope.global, this.groupId, this.groupName, this.isActive = true, this.sortOrder = 0}): super._();
  

@override final  String id;
@override final  String labelAr;
@override final  String labelEn;
@override final  String? descriptionAr;
@override final  String? descriptionEn;
@override final  String? phoneNumber;
@override final  String? whatsappNumber;
@override@JsonKey() final  SupportContactScope scope;
@override final  String? groupId;
@override final  String? groupName;
@override@JsonKey() final  bool isActive;
@override@JsonKey() final  int sortOrder;

/// Create a copy of SupportContact
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SupportContactCopyWith<_SupportContact> get copyWith => __$SupportContactCopyWithImpl<_SupportContact>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SupportContact&&(identical(other.id, id) || other.id == id)&&(identical(other.labelAr, labelAr) || other.labelAr == labelAr)&&(identical(other.labelEn, labelEn) || other.labelEn == labelEn)&&(identical(other.descriptionAr, descriptionAr) || other.descriptionAr == descriptionAr)&&(identical(other.descriptionEn, descriptionEn) || other.descriptionEn == descriptionEn)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.whatsappNumber, whatsappNumber) || other.whatsappNumber == whatsappNumber)&&(identical(other.scope, scope) || other.scope == scope)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.groupName, groupName) || other.groupName == groupName)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder));
}


@override
int get hashCode => Object.hash(runtimeType,id,labelAr,labelEn,descriptionAr,descriptionEn,phoneNumber,whatsappNumber,scope,groupId,groupName,isActive,sortOrder);

@override
String toString() {
  return 'SupportContact(id: $id, labelAr: $labelAr, labelEn: $labelEn, descriptionAr: $descriptionAr, descriptionEn: $descriptionEn, phoneNumber: $phoneNumber, whatsappNumber: $whatsappNumber, scope: $scope, groupId: $groupId, groupName: $groupName, isActive: $isActive, sortOrder: $sortOrder)';
}


}

/// @nodoc
abstract mixin class _$SupportContactCopyWith<$Res> implements $SupportContactCopyWith<$Res> {
  factory _$SupportContactCopyWith(_SupportContact value, $Res Function(_SupportContact) _then) = __$SupportContactCopyWithImpl;
@override @useResult
$Res call({
 String id, String labelAr, String labelEn, String? descriptionAr, String? descriptionEn, String? phoneNumber, String? whatsappNumber, SupportContactScope scope, String? groupId, String? groupName, bool isActive, int sortOrder
});




}
/// @nodoc
class __$SupportContactCopyWithImpl<$Res>
    implements _$SupportContactCopyWith<$Res> {
  __$SupportContactCopyWithImpl(this._self, this._then);

  final _SupportContact _self;
  final $Res Function(_SupportContact) _then;

/// Create a copy of SupportContact
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? labelAr = null,Object? labelEn = null,Object? descriptionAr = freezed,Object? descriptionEn = freezed,Object? phoneNumber = freezed,Object? whatsappNumber = freezed,Object? scope = null,Object? groupId = freezed,Object? groupName = freezed,Object? isActive = null,Object? sortOrder = null,}) {
  return _then(_SupportContact(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,labelAr: null == labelAr ? _self.labelAr : labelAr // ignore: cast_nullable_to_non_nullable
as String,labelEn: null == labelEn ? _self.labelEn : labelEn // ignore: cast_nullable_to_non_nullable
as String,descriptionAr: freezed == descriptionAr ? _self.descriptionAr : descriptionAr // ignore: cast_nullable_to_non_nullable
as String?,descriptionEn: freezed == descriptionEn ? _self.descriptionEn : descriptionEn // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,whatsappNumber: freezed == whatsappNumber ? _self.whatsappNumber : whatsappNumber // ignore: cast_nullable_to_non_nullable
as String?,scope: null == scope ? _self.scope : scope // ignore: cast_nullable_to_non_nullable
as SupportContactScope,groupId: freezed == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String?,groupName: freezed == groupName ? _self.groupName : groupName // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
