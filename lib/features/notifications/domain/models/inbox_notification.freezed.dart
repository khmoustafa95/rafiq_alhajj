// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'inbox_notification.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$InboxNotification {

 String get id; String get recipientId; String? get senderId; InboxNotificationType get type; String get titleAr; String get titleEn; String? get bodyAr; String? get bodyEn; Map<String, dynamic> get payload; DateTime? get readAt; DateTime get createdAt;
/// Create a copy of InboxNotification
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InboxNotificationCopyWith<InboxNotification> get copyWith => _$InboxNotificationCopyWithImpl<InboxNotification>(this as InboxNotification, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InboxNotification&&(identical(other.id, id) || other.id == id)&&(identical(other.recipientId, recipientId) || other.recipientId == recipientId)&&(identical(other.senderId, senderId) || other.senderId == senderId)&&(identical(other.type, type) || other.type == type)&&(identical(other.titleAr, titleAr) || other.titleAr == titleAr)&&(identical(other.titleEn, titleEn) || other.titleEn == titleEn)&&(identical(other.bodyAr, bodyAr) || other.bodyAr == bodyAr)&&(identical(other.bodyEn, bodyEn) || other.bodyEn == bodyEn)&&const DeepCollectionEquality().equals(other.payload, payload)&&(identical(other.readAt, readAt) || other.readAt == readAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,recipientId,senderId,type,titleAr,titleEn,bodyAr,bodyEn,const DeepCollectionEquality().hash(payload),readAt,createdAt);

@override
String toString() {
  return 'InboxNotification(id: $id, recipientId: $recipientId, senderId: $senderId, type: $type, titleAr: $titleAr, titleEn: $titleEn, bodyAr: $bodyAr, bodyEn: $bodyEn, payload: $payload, readAt: $readAt, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $InboxNotificationCopyWith<$Res>  {
  factory $InboxNotificationCopyWith(InboxNotification value, $Res Function(InboxNotification) _then) = _$InboxNotificationCopyWithImpl;
@useResult
$Res call({
 String id, String recipientId, String? senderId, InboxNotificationType type, String titleAr, String titleEn, String? bodyAr, String? bodyEn, Map<String, dynamic> payload, DateTime? readAt, DateTime createdAt
});




}
/// @nodoc
class _$InboxNotificationCopyWithImpl<$Res>
    implements $InboxNotificationCopyWith<$Res> {
  _$InboxNotificationCopyWithImpl(this._self, this._then);

  final InboxNotification _self;
  final $Res Function(InboxNotification) _then;

/// Create a copy of InboxNotification
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? recipientId = null,Object? senderId = freezed,Object? type = null,Object? titleAr = null,Object? titleEn = null,Object? bodyAr = freezed,Object? bodyEn = freezed,Object? payload = null,Object? readAt = freezed,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,recipientId: null == recipientId ? _self.recipientId : recipientId // ignore: cast_nullable_to_non_nullable
as String,senderId: freezed == senderId ? _self.senderId : senderId // ignore: cast_nullable_to_non_nullable
as String?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as InboxNotificationType,titleAr: null == titleAr ? _self.titleAr : titleAr // ignore: cast_nullable_to_non_nullable
as String,titleEn: null == titleEn ? _self.titleEn : titleEn // ignore: cast_nullable_to_non_nullable
as String,bodyAr: freezed == bodyAr ? _self.bodyAr : bodyAr // ignore: cast_nullable_to_non_nullable
as String?,bodyEn: freezed == bodyEn ? _self.bodyEn : bodyEn // ignore: cast_nullable_to_non_nullable
as String?,payload: null == payload ? _self.payload : payload // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,readAt: freezed == readAt ? _self.readAt : readAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [InboxNotification].
extension InboxNotificationPatterns on InboxNotification {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InboxNotification value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InboxNotification() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InboxNotification value)  $default,){
final _that = this;
switch (_that) {
case _InboxNotification():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InboxNotification value)?  $default,){
final _that = this;
switch (_that) {
case _InboxNotification() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String recipientId,  String? senderId,  InboxNotificationType type,  String titleAr,  String titleEn,  String? bodyAr,  String? bodyEn,  Map<String, dynamic> payload,  DateTime? readAt,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InboxNotification() when $default != null:
return $default(_that.id,_that.recipientId,_that.senderId,_that.type,_that.titleAr,_that.titleEn,_that.bodyAr,_that.bodyEn,_that.payload,_that.readAt,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String recipientId,  String? senderId,  InboxNotificationType type,  String titleAr,  String titleEn,  String? bodyAr,  String? bodyEn,  Map<String, dynamic> payload,  DateTime? readAt,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _InboxNotification():
return $default(_that.id,_that.recipientId,_that.senderId,_that.type,_that.titleAr,_that.titleEn,_that.bodyAr,_that.bodyEn,_that.payload,_that.readAt,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String recipientId,  String? senderId,  InboxNotificationType type,  String titleAr,  String titleEn,  String? bodyAr,  String? bodyEn,  Map<String, dynamic> payload,  DateTime? readAt,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _InboxNotification() when $default != null:
return $default(_that.id,_that.recipientId,_that.senderId,_that.type,_that.titleAr,_that.titleEn,_that.bodyAr,_that.bodyEn,_that.payload,_that.readAt,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc


class _InboxNotification extends InboxNotification {
  const _InboxNotification({required this.id, required this.recipientId, this.senderId, required this.type, required this.titleAr, required this.titleEn, this.bodyAr, this.bodyEn, final  Map<String, dynamic> payload = const {}, this.readAt, required this.createdAt}): _payload = payload,super._();
  

@override final  String id;
@override final  String recipientId;
@override final  String? senderId;
@override final  InboxNotificationType type;
@override final  String titleAr;
@override final  String titleEn;
@override final  String? bodyAr;
@override final  String? bodyEn;
 final  Map<String, dynamic> _payload;
@override@JsonKey() Map<String, dynamic> get payload {
  if (_payload is EqualUnmodifiableMapView) return _payload;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_payload);
}

@override final  DateTime? readAt;
@override final  DateTime createdAt;

/// Create a copy of InboxNotification
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InboxNotificationCopyWith<_InboxNotification> get copyWith => __$InboxNotificationCopyWithImpl<_InboxNotification>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InboxNotification&&(identical(other.id, id) || other.id == id)&&(identical(other.recipientId, recipientId) || other.recipientId == recipientId)&&(identical(other.senderId, senderId) || other.senderId == senderId)&&(identical(other.type, type) || other.type == type)&&(identical(other.titleAr, titleAr) || other.titleAr == titleAr)&&(identical(other.titleEn, titleEn) || other.titleEn == titleEn)&&(identical(other.bodyAr, bodyAr) || other.bodyAr == bodyAr)&&(identical(other.bodyEn, bodyEn) || other.bodyEn == bodyEn)&&const DeepCollectionEquality().equals(other._payload, _payload)&&(identical(other.readAt, readAt) || other.readAt == readAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,recipientId,senderId,type,titleAr,titleEn,bodyAr,bodyEn,const DeepCollectionEquality().hash(_payload),readAt,createdAt);

@override
String toString() {
  return 'InboxNotification(id: $id, recipientId: $recipientId, senderId: $senderId, type: $type, titleAr: $titleAr, titleEn: $titleEn, bodyAr: $bodyAr, bodyEn: $bodyEn, payload: $payload, readAt: $readAt, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$InboxNotificationCopyWith<$Res> implements $InboxNotificationCopyWith<$Res> {
  factory _$InboxNotificationCopyWith(_InboxNotification value, $Res Function(_InboxNotification) _then) = __$InboxNotificationCopyWithImpl;
@override @useResult
$Res call({
 String id, String recipientId, String? senderId, InboxNotificationType type, String titleAr, String titleEn, String? bodyAr, String? bodyEn, Map<String, dynamic> payload, DateTime? readAt, DateTime createdAt
});




}
/// @nodoc
class __$InboxNotificationCopyWithImpl<$Res>
    implements _$InboxNotificationCopyWith<$Res> {
  __$InboxNotificationCopyWithImpl(this._self, this._then);

  final _InboxNotification _self;
  final $Res Function(_InboxNotification) _then;

/// Create a copy of InboxNotification
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? recipientId = null,Object? senderId = freezed,Object? type = null,Object? titleAr = null,Object? titleEn = null,Object? bodyAr = freezed,Object? bodyEn = freezed,Object? payload = null,Object? readAt = freezed,Object? createdAt = null,}) {
  return _then(_InboxNotification(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,recipientId: null == recipientId ? _self.recipientId : recipientId // ignore: cast_nullable_to_non_nullable
as String,senderId: freezed == senderId ? _self.senderId : senderId // ignore: cast_nullable_to_non_nullable
as String?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as InboxNotificationType,titleAr: null == titleAr ? _self.titleAr : titleAr // ignore: cast_nullable_to_non_nullable
as String,titleEn: null == titleEn ? _self.titleEn : titleEn // ignore: cast_nullable_to_non_nullable
as String,bodyAr: freezed == bodyAr ? _self.bodyAr : bodyAr // ignore: cast_nullable_to_non_nullable
as String?,bodyEn: freezed == bodyEn ? _self.bodyEn : bodyEn // ignore: cast_nullable_to_non_nullable
as String?,payload: null == payload ? _self._payload : payload // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,readAt: freezed == readAt ? _self.readAt : readAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
