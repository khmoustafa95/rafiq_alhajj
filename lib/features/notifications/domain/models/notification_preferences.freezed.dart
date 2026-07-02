// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_preferences.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NotificationPreferences {

 bool get pushEnabled; bool get pushAnnouncements; bool get pushContent; bool get pushCompetitions; bool get pushUrgent; bool get quietHoursEnabled; TimeOfDay get quietHoursStart; TimeOfDay get quietHoursEnd; int? get timezoneOffsetMinutes;
/// Create a copy of NotificationPreferences
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationPreferencesCopyWith<NotificationPreferences> get copyWith => _$NotificationPreferencesCopyWithImpl<NotificationPreferences>(this as NotificationPreferences, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationPreferences&&(identical(other.pushEnabled, pushEnabled) || other.pushEnabled == pushEnabled)&&(identical(other.pushAnnouncements, pushAnnouncements) || other.pushAnnouncements == pushAnnouncements)&&(identical(other.pushContent, pushContent) || other.pushContent == pushContent)&&(identical(other.pushCompetitions, pushCompetitions) || other.pushCompetitions == pushCompetitions)&&(identical(other.pushUrgent, pushUrgent) || other.pushUrgent == pushUrgent)&&(identical(other.quietHoursEnabled, quietHoursEnabled) || other.quietHoursEnabled == quietHoursEnabled)&&(identical(other.quietHoursStart, quietHoursStart) || other.quietHoursStart == quietHoursStart)&&(identical(other.quietHoursEnd, quietHoursEnd) || other.quietHoursEnd == quietHoursEnd)&&(identical(other.timezoneOffsetMinutes, timezoneOffsetMinutes) || other.timezoneOffsetMinutes == timezoneOffsetMinutes));
}


@override
int get hashCode => Object.hash(runtimeType,pushEnabled,pushAnnouncements,pushContent,pushCompetitions,pushUrgent,quietHoursEnabled,quietHoursStart,quietHoursEnd,timezoneOffsetMinutes);

@override
String toString() {
  return 'NotificationPreferences(pushEnabled: $pushEnabled, pushAnnouncements: $pushAnnouncements, pushContent: $pushContent, pushCompetitions: $pushCompetitions, pushUrgent: $pushUrgent, quietHoursEnabled: $quietHoursEnabled, quietHoursStart: $quietHoursStart, quietHoursEnd: $quietHoursEnd, timezoneOffsetMinutes: $timezoneOffsetMinutes)';
}


}

/// @nodoc
abstract mixin class $NotificationPreferencesCopyWith<$Res>  {
  factory $NotificationPreferencesCopyWith(NotificationPreferences value, $Res Function(NotificationPreferences) _then) = _$NotificationPreferencesCopyWithImpl;
@useResult
$Res call({
 bool pushEnabled, bool pushAnnouncements, bool pushContent, bool pushCompetitions, bool pushUrgent, bool quietHoursEnabled, TimeOfDay quietHoursStart, TimeOfDay quietHoursEnd, int? timezoneOffsetMinutes
});




}
/// @nodoc
class _$NotificationPreferencesCopyWithImpl<$Res>
    implements $NotificationPreferencesCopyWith<$Res> {
  _$NotificationPreferencesCopyWithImpl(this._self, this._then);

  final NotificationPreferences _self;
  final $Res Function(NotificationPreferences) _then;

/// Create a copy of NotificationPreferences
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pushEnabled = null,Object? pushAnnouncements = null,Object? pushContent = null,Object? pushCompetitions = null,Object? pushUrgent = null,Object? quietHoursEnabled = null,Object? quietHoursStart = null,Object? quietHoursEnd = null,Object? timezoneOffsetMinutes = freezed,}) {
  return _then(_self.copyWith(
pushEnabled: null == pushEnabled ? _self.pushEnabled : pushEnabled // ignore: cast_nullable_to_non_nullable
as bool,pushAnnouncements: null == pushAnnouncements ? _self.pushAnnouncements : pushAnnouncements // ignore: cast_nullable_to_non_nullable
as bool,pushContent: null == pushContent ? _self.pushContent : pushContent // ignore: cast_nullable_to_non_nullable
as bool,pushCompetitions: null == pushCompetitions ? _self.pushCompetitions : pushCompetitions // ignore: cast_nullable_to_non_nullable
as bool,pushUrgent: null == pushUrgent ? _self.pushUrgent : pushUrgent // ignore: cast_nullable_to_non_nullable
as bool,quietHoursEnabled: null == quietHoursEnabled ? _self.quietHoursEnabled : quietHoursEnabled // ignore: cast_nullable_to_non_nullable
as bool,quietHoursStart: null == quietHoursStart ? _self.quietHoursStart : quietHoursStart // ignore: cast_nullable_to_non_nullable
as TimeOfDay,quietHoursEnd: null == quietHoursEnd ? _self.quietHoursEnd : quietHoursEnd // ignore: cast_nullable_to_non_nullable
as TimeOfDay,timezoneOffsetMinutes: freezed == timezoneOffsetMinutes ? _self.timezoneOffsetMinutes : timezoneOffsetMinutes // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationPreferences].
extension NotificationPreferencesPatterns on NotificationPreferences {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationPreferences value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationPreferences() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationPreferences value)  $default,){
final _that = this;
switch (_that) {
case _NotificationPreferences():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationPreferences value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationPreferences() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool pushEnabled,  bool pushAnnouncements,  bool pushContent,  bool pushCompetitions,  bool pushUrgent,  bool quietHoursEnabled,  TimeOfDay quietHoursStart,  TimeOfDay quietHoursEnd,  int? timezoneOffsetMinutes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationPreferences() when $default != null:
return $default(_that.pushEnabled,_that.pushAnnouncements,_that.pushContent,_that.pushCompetitions,_that.pushUrgent,_that.quietHoursEnabled,_that.quietHoursStart,_that.quietHoursEnd,_that.timezoneOffsetMinutes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool pushEnabled,  bool pushAnnouncements,  bool pushContent,  bool pushCompetitions,  bool pushUrgent,  bool quietHoursEnabled,  TimeOfDay quietHoursStart,  TimeOfDay quietHoursEnd,  int? timezoneOffsetMinutes)  $default,) {final _that = this;
switch (_that) {
case _NotificationPreferences():
return $default(_that.pushEnabled,_that.pushAnnouncements,_that.pushContent,_that.pushCompetitions,_that.pushUrgent,_that.quietHoursEnabled,_that.quietHoursStart,_that.quietHoursEnd,_that.timezoneOffsetMinutes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool pushEnabled,  bool pushAnnouncements,  bool pushContent,  bool pushCompetitions,  bool pushUrgent,  bool quietHoursEnabled,  TimeOfDay quietHoursStart,  TimeOfDay quietHoursEnd,  int? timezoneOffsetMinutes)?  $default,) {final _that = this;
switch (_that) {
case _NotificationPreferences() when $default != null:
return $default(_that.pushEnabled,_that.pushAnnouncements,_that.pushContent,_that.pushCompetitions,_that.pushUrgent,_that.quietHoursEnabled,_that.quietHoursStart,_that.quietHoursEnd,_that.timezoneOffsetMinutes);case _:
  return null;

}
}

}

/// @nodoc


class _NotificationPreferences extends NotificationPreferences {
  const _NotificationPreferences({this.pushEnabled = true, this.pushAnnouncements = true, this.pushContent = true, this.pushCompetitions = true, this.pushUrgent = true, this.quietHoursEnabled = false, this.quietHoursStart = const TimeOfDay(hour: 22, minute: 0), this.quietHoursEnd = const TimeOfDay(hour: 7, minute: 0), this.timezoneOffsetMinutes}): super._();
  

@override@JsonKey() final  bool pushEnabled;
@override@JsonKey() final  bool pushAnnouncements;
@override@JsonKey() final  bool pushContent;
@override@JsonKey() final  bool pushCompetitions;
@override@JsonKey() final  bool pushUrgent;
@override@JsonKey() final  bool quietHoursEnabled;
@override@JsonKey() final  TimeOfDay quietHoursStart;
@override@JsonKey() final  TimeOfDay quietHoursEnd;
@override final  int? timezoneOffsetMinutes;

/// Create a copy of NotificationPreferences
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationPreferencesCopyWith<_NotificationPreferences> get copyWith => __$NotificationPreferencesCopyWithImpl<_NotificationPreferences>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationPreferences&&(identical(other.pushEnabled, pushEnabled) || other.pushEnabled == pushEnabled)&&(identical(other.pushAnnouncements, pushAnnouncements) || other.pushAnnouncements == pushAnnouncements)&&(identical(other.pushContent, pushContent) || other.pushContent == pushContent)&&(identical(other.pushCompetitions, pushCompetitions) || other.pushCompetitions == pushCompetitions)&&(identical(other.pushUrgent, pushUrgent) || other.pushUrgent == pushUrgent)&&(identical(other.quietHoursEnabled, quietHoursEnabled) || other.quietHoursEnabled == quietHoursEnabled)&&(identical(other.quietHoursStart, quietHoursStart) || other.quietHoursStart == quietHoursStart)&&(identical(other.quietHoursEnd, quietHoursEnd) || other.quietHoursEnd == quietHoursEnd)&&(identical(other.timezoneOffsetMinutes, timezoneOffsetMinutes) || other.timezoneOffsetMinutes == timezoneOffsetMinutes));
}


@override
int get hashCode => Object.hash(runtimeType,pushEnabled,pushAnnouncements,pushContent,pushCompetitions,pushUrgent,quietHoursEnabled,quietHoursStart,quietHoursEnd,timezoneOffsetMinutes);

@override
String toString() {
  return 'NotificationPreferences(pushEnabled: $pushEnabled, pushAnnouncements: $pushAnnouncements, pushContent: $pushContent, pushCompetitions: $pushCompetitions, pushUrgent: $pushUrgent, quietHoursEnabled: $quietHoursEnabled, quietHoursStart: $quietHoursStart, quietHoursEnd: $quietHoursEnd, timezoneOffsetMinutes: $timezoneOffsetMinutes)';
}


}

/// @nodoc
abstract mixin class _$NotificationPreferencesCopyWith<$Res> implements $NotificationPreferencesCopyWith<$Res> {
  factory _$NotificationPreferencesCopyWith(_NotificationPreferences value, $Res Function(_NotificationPreferences) _then) = __$NotificationPreferencesCopyWithImpl;
@override @useResult
$Res call({
 bool pushEnabled, bool pushAnnouncements, bool pushContent, bool pushCompetitions, bool pushUrgent, bool quietHoursEnabled, TimeOfDay quietHoursStart, TimeOfDay quietHoursEnd, int? timezoneOffsetMinutes
});




}
/// @nodoc
class __$NotificationPreferencesCopyWithImpl<$Res>
    implements _$NotificationPreferencesCopyWith<$Res> {
  __$NotificationPreferencesCopyWithImpl(this._self, this._then);

  final _NotificationPreferences _self;
  final $Res Function(_NotificationPreferences) _then;

/// Create a copy of NotificationPreferences
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pushEnabled = null,Object? pushAnnouncements = null,Object? pushContent = null,Object? pushCompetitions = null,Object? pushUrgent = null,Object? quietHoursEnabled = null,Object? quietHoursStart = null,Object? quietHoursEnd = null,Object? timezoneOffsetMinutes = freezed,}) {
  return _then(_NotificationPreferences(
pushEnabled: null == pushEnabled ? _self.pushEnabled : pushEnabled // ignore: cast_nullable_to_non_nullable
as bool,pushAnnouncements: null == pushAnnouncements ? _self.pushAnnouncements : pushAnnouncements // ignore: cast_nullable_to_non_nullable
as bool,pushContent: null == pushContent ? _self.pushContent : pushContent // ignore: cast_nullable_to_non_nullable
as bool,pushCompetitions: null == pushCompetitions ? _self.pushCompetitions : pushCompetitions // ignore: cast_nullable_to_non_nullable
as bool,pushUrgent: null == pushUrgent ? _self.pushUrgent : pushUrgent // ignore: cast_nullable_to_non_nullable
as bool,quietHoursEnabled: null == quietHoursEnabled ? _self.quietHoursEnabled : quietHoursEnabled // ignore: cast_nullable_to_non_nullable
as bool,quietHoursStart: null == quietHoursStart ? _self.quietHoursStart : quietHoursStart // ignore: cast_nullable_to_non_nullable
as TimeOfDay,quietHoursEnd: null == quietHoursEnd ? _self.quietHoursEnd : quietHoursEnd // ignore: cast_nullable_to_non_nullable
as TimeOfDay,timezoneOffsetMinutes: freezed == timezoneOffsetMinutes ? _self.timezoneOffsetMinutes : timezoneOffsetMinutes // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
