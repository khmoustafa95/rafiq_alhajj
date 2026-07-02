// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'competition.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Competition {

 String get id; String get title; String? get description; DateTime get startsAt; DateTime get endsAt; bool get isActive;
/// Create a copy of Competition
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompetitionCopyWith<Competition> get copyWith => _$CompetitionCopyWithImpl<Competition>(this as Competition, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Competition&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,description,startsAt,endsAt,isActive);

@override
String toString() {
  return 'Competition(id: $id, title: $title, description: $description, startsAt: $startsAt, endsAt: $endsAt, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class $CompetitionCopyWith<$Res>  {
  factory $CompetitionCopyWith(Competition value, $Res Function(Competition) _then) = _$CompetitionCopyWithImpl;
@useResult
$Res call({
 String id, String title, String? description, DateTime startsAt, DateTime endsAt, bool isActive
});




}
/// @nodoc
class _$CompetitionCopyWithImpl<$Res>
    implements $CompetitionCopyWith<$Res> {
  _$CompetitionCopyWithImpl(this._self, this._then);

  final Competition _self;
  final $Res Function(Competition) _then;

/// Create a copy of Competition
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = freezed,Object? startsAt = null,Object? endsAt = null,Object? isActive = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime,endsAt: null == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as DateTime,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [Competition].
extension CompetitionPatterns on Competition {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Competition value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Competition() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Competition value)  $default,){
final _that = this;
switch (_that) {
case _Competition():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Competition value)?  $default,){
final _that = this;
switch (_that) {
case _Competition() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String? description,  DateTime startsAt,  DateTime endsAt,  bool isActive)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Competition() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.startsAt,_that.endsAt,_that.isActive);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String? description,  DateTime startsAt,  DateTime endsAt,  bool isActive)  $default,) {final _that = this;
switch (_that) {
case _Competition():
return $default(_that.id,_that.title,_that.description,_that.startsAt,_that.endsAt,_that.isActive);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String? description,  DateTime startsAt,  DateTime endsAt,  bool isActive)?  $default,) {final _that = this;
switch (_that) {
case _Competition() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.startsAt,_that.endsAt,_that.isActive);case _:
  return null;

}
}

}

/// @nodoc


class _Competition extends Competition {
  const _Competition({required this.id, required this.title, this.description, required this.startsAt, required this.endsAt, required this.isActive}): super._();
  

@override final  String id;
@override final  String title;
@override final  String? description;
@override final  DateTime startsAt;
@override final  DateTime endsAt;
@override final  bool isActive;

/// Create a copy of Competition
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CompetitionCopyWith<_Competition> get copyWith => __$CompetitionCopyWithImpl<_Competition>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Competition&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,description,startsAt,endsAt,isActive);

@override
String toString() {
  return 'Competition(id: $id, title: $title, description: $description, startsAt: $startsAt, endsAt: $endsAt, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class _$CompetitionCopyWith<$Res> implements $CompetitionCopyWith<$Res> {
  factory _$CompetitionCopyWith(_Competition value, $Res Function(_Competition) _then) = __$CompetitionCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String? description, DateTime startsAt, DateTime endsAt, bool isActive
});




}
/// @nodoc
class __$CompetitionCopyWithImpl<$Res>
    implements _$CompetitionCopyWith<$Res> {
  __$CompetitionCopyWithImpl(this._self, this._then);

  final _Competition _self;
  final $Res Function(_Competition) _then;

/// Create a copy of Competition
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = freezed,Object? startsAt = null,Object? endsAt = null,Object? isActive = null,}) {
  return _then(_Competition(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime,endsAt: null == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as DateTime,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$CompetitionEntry {

 String get id; String get competitionId; String get profileId; String get participantName; int get score; DateTime get joinedAt;
/// Create a copy of CompetitionEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompetitionEntryCopyWith<CompetitionEntry> get copyWith => _$CompetitionEntryCopyWithImpl<CompetitionEntry>(this as CompetitionEntry, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompetitionEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.competitionId, competitionId) || other.competitionId == competitionId)&&(identical(other.profileId, profileId) || other.profileId == profileId)&&(identical(other.participantName, participantName) || other.participantName == participantName)&&(identical(other.score, score) || other.score == score)&&(identical(other.joinedAt, joinedAt) || other.joinedAt == joinedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,competitionId,profileId,participantName,score,joinedAt);

@override
String toString() {
  return 'CompetitionEntry(id: $id, competitionId: $competitionId, profileId: $profileId, participantName: $participantName, score: $score, joinedAt: $joinedAt)';
}


}

/// @nodoc
abstract mixin class $CompetitionEntryCopyWith<$Res>  {
  factory $CompetitionEntryCopyWith(CompetitionEntry value, $Res Function(CompetitionEntry) _then) = _$CompetitionEntryCopyWithImpl;
@useResult
$Res call({
 String id, String competitionId, String profileId, String participantName, int score, DateTime joinedAt
});




}
/// @nodoc
class _$CompetitionEntryCopyWithImpl<$Res>
    implements $CompetitionEntryCopyWith<$Res> {
  _$CompetitionEntryCopyWithImpl(this._self, this._then);

  final CompetitionEntry _self;
  final $Res Function(CompetitionEntry) _then;

/// Create a copy of CompetitionEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? competitionId = null,Object? profileId = null,Object? participantName = null,Object? score = null,Object? joinedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,competitionId: null == competitionId ? _self.competitionId : competitionId // ignore: cast_nullable_to_non_nullable
as String,profileId: null == profileId ? _self.profileId : profileId // ignore: cast_nullable_to_non_nullable
as String,participantName: null == participantName ? _self.participantName : participantName // ignore: cast_nullable_to_non_nullable
as String,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as int,joinedAt: null == joinedAt ? _self.joinedAt : joinedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [CompetitionEntry].
extension CompetitionEntryPatterns on CompetitionEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CompetitionEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CompetitionEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CompetitionEntry value)  $default,){
final _that = this;
switch (_that) {
case _CompetitionEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CompetitionEntry value)?  $default,){
final _that = this;
switch (_that) {
case _CompetitionEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String competitionId,  String profileId,  String participantName,  int score,  DateTime joinedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CompetitionEntry() when $default != null:
return $default(_that.id,_that.competitionId,_that.profileId,_that.participantName,_that.score,_that.joinedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String competitionId,  String profileId,  String participantName,  int score,  DateTime joinedAt)  $default,) {final _that = this;
switch (_that) {
case _CompetitionEntry():
return $default(_that.id,_that.competitionId,_that.profileId,_that.participantName,_that.score,_that.joinedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String competitionId,  String profileId,  String participantName,  int score,  DateTime joinedAt)?  $default,) {final _that = this;
switch (_that) {
case _CompetitionEntry() when $default != null:
return $default(_that.id,_that.competitionId,_that.profileId,_that.participantName,_that.score,_that.joinedAt);case _:
  return null;

}
}

}

/// @nodoc


class _CompetitionEntry implements CompetitionEntry {
  const _CompetitionEntry({required this.id, required this.competitionId, required this.profileId, required this.participantName, required this.score, required this.joinedAt});
  

@override final  String id;
@override final  String competitionId;
@override final  String profileId;
@override final  String participantName;
@override final  int score;
@override final  DateTime joinedAt;

/// Create a copy of CompetitionEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CompetitionEntryCopyWith<_CompetitionEntry> get copyWith => __$CompetitionEntryCopyWithImpl<_CompetitionEntry>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CompetitionEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.competitionId, competitionId) || other.competitionId == competitionId)&&(identical(other.profileId, profileId) || other.profileId == profileId)&&(identical(other.participantName, participantName) || other.participantName == participantName)&&(identical(other.score, score) || other.score == score)&&(identical(other.joinedAt, joinedAt) || other.joinedAt == joinedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,competitionId,profileId,participantName,score,joinedAt);

@override
String toString() {
  return 'CompetitionEntry(id: $id, competitionId: $competitionId, profileId: $profileId, participantName: $participantName, score: $score, joinedAt: $joinedAt)';
}


}

/// @nodoc
abstract mixin class _$CompetitionEntryCopyWith<$Res> implements $CompetitionEntryCopyWith<$Res> {
  factory _$CompetitionEntryCopyWith(_CompetitionEntry value, $Res Function(_CompetitionEntry) _then) = __$CompetitionEntryCopyWithImpl;
@override @useResult
$Res call({
 String id, String competitionId, String profileId, String participantName, int score, DateTime joinedAt
});




}
/// @nodoc
class __$CompetitionEntryCopyWithImpl<$Res>
    implements _$CompetitionEntryCopyWith<$Res> {
  __$CompetitionEntryCopyWithImpl(this._self, this._then);

  final _CompetitionEntry _self;
  final $Res Function(_CompetitionEntry) _then;

/// Create a copy of CompetitionEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? competitionId = null,Object? profileId = null,Object? participantName = null,Object? score = null,Object? joinedAt = null,}) {
  return _then(_CompetitionEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,competitionId: null == competitionId ? _self.competitionId : competitionId // ignore: cast_nullable_to_non_nullable
as String,profileId: null == profileId ? _self.profileId : profileId // ignore: cast_nullable_to_non_nullable
as String,participantName: null == participantName ? _self.participantName : participantName // ignore: cast_nullable_to_non_nullable
as String,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as int,joinedAt: null == joinedAt ? _self.joinedAt : joinedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

/// @nodoc
mixin _$CompetitionWithEntries {

 Competition get competition; List<CompetitionEntry> get entries; CompetitionEntry? get myEntry;
/// Create a copy of CompetitionWithEntries
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompetitionWithEntriesCopyWith<CompetitionWithEntries> get copyWith => _$CompetitionWithEntriesCopyWithImpl<CompetitionWithEntries>(this as CompetitionWithEntries, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompetitionWithEntries&&(identical(other.competition, competition) || other.competition == competition)&&const DeepCollectionEquality().equals(other.entries, entries)&&(identical(other.myEntry, myEntry) || other.myEntry == myEntry));
}


@override
int get hashCode => Object.hash(runtimeType,competition,const DeepCollectionEquality().hash(entries),myEntry);

@override
String toString() {
  return 'CompetitionWithEntries(competition: $competition, entries: $entries, myEntry: $myEntry)';
}


}

/// @nodoc
abstract mixin class $CompetitionWithEntriesCopyWith<$Res>  {
  factory $CompetitionWithEntriesCopyWith(CompetitionWithEntries value, $Res Function(CompetitionWithEntries) _then) = _$CompetitionWithEntriesCopyWithImpl;
@useResult
$Res call({
 Competition competition, List<CompetitionEntry> entries, CompetitionEntry? myEntry
});


$CompetitionCopyWith<$Res> get competition;$CompetitionEntryCopyWith<$Res>? get myEntry;

}
/// @nodoc
class _$CompetitionWithEntriesCopyWithImpl<$Res>
    implements $CompetitionWithEntriesCopyWith<$Res> {
  _$CompetitionWithEntriesCopyWithImpl(this._self, this._then);

  final CompetitionWithEntries _self;
  final $Res Function(CompetitionWithEntries) _then;

/// Create a copy of CompetitionWithEntries
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? competition = null,Object? entries = null,Object? myEntry = freezed,}) {
  return _then(_self.copyWith(
competition: null == competition ? _self.competition : competition // ignore: cast_nullable_to_non_nullable
as Competition,entries: null == entries ? _self.entries : entries // ignore: cast_nullable_to_non_nullable
as List<CompetitionEntry>,myEntry: freezed == myEntry ? _self.myEntry : myEntry // ignore: cast_nullable_to_non_nullable
as CompetitionEntry?,
  ));
}
/// Create a copy of CompetitionWithEntries
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CompetitionCopyWith<$Res> get competition {
  
  return $CompetitionCopyWith<$Res>(_self.competition, (value) {
    return _then(_self.copyWith(competition: value));
  });
}/// Create a copy of CompetitionWithEntries
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CompetitionEntryCopyWith<$Res>? get myEntry {
    if (_self.myEntry == null) {
    return null;
  }

  return $CompetitionEntryCopyWith<$Res>(_self.myEntry!, (value) {
    return _then(_self.copyWith(myEntry: value));
  });
}
}


/// Adds pattern-matching-related methods to [CompetitionWithEntries].
extension CompetitionWithEntriesPatterns on CompetitionWithEntries {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CompetitionWithEntries value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CompetitionWithEntries() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CompetitionWithEntries value)  $default,){
final _that = this;
switch (_that) {
case _CompetitionWithEntries():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CompetitionWithEntries value)?  $default,){
final _that = this;
switch (_that) {
case _CompetitionWithEntries() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Competition competition,  List<CompetitionEntry> entries,  CompetitionEntry? myEntry)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CompetitionWithEntries() when $default != null:
return $default(_that.competition,_that.entries,_that.myEntry);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Competition competition,  List<CompetitionEntry> entries,  CompetitionEntry? myEntry)  $default,) {final _that = this;
switch (_that) {
case _CompetitionWithEntries():
return $default(_that.competition,_that.entries,_that.myEntry);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Competition competition,  List<CompetitionEntry> entries,  CompetitionEntry? myEntry)?  $default,) {final _that = this;
switch (_that) {
case _CompetitionWithEntries() when $default != null:
return $default(_that.competition,_that.entries,_that.myEntry);case _:
  return null;

}
}

}

/// @nodoc


class _CompetitionWithEntries implements CompetitionWithEntries {
  const _CompetitionWithEntries({required this.competition, required final  List<CompetitionEntry> entries, this.myEntry}): _entries = entries;
  

@override final  Competition competition;
 final  List<CompetitionEntry> _entries;
@override List<CompetitionEntry> get entries {
  if (_entries is EqualUnmodifiableListView) return _entries;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_entries);
}

@override final  CompetitionEntry? myEntry;

/// Create a copy of CompetitionWithEntries
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CompetitionWithEntriesCopyWith<_CompetitionWithEntries> get copyWith => __$CompetitionWithEntriesCopyWithImpl<_CompetitionWithEntries>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CompetitionWithEntries&&(identical(other.competition, competition) || other.competition == competition)&&const DeepCollectionEquality().equals(other._entries, _entries)&&(identical(other.myEntry, myEntry) || other.myEntry == myEntry));
}


@override
int get hashCode => Object.hash(runtimeType,competition,const DeepCollectionEquality().hash(_entries),myEntry);

@override
String toString() {
  return 'CompetitionWithEntries(competition: $competition, entries: $entries, myEntry: $myEntry)';
}


}

/// @nodoc
abstract mixin class _$CompetitionWithEntriesCopyWith<$Res> implements $CompetitionWithEntriesCopyWith<$Res> {
  factory _$CompetitionWithEntriesCopyWith(_CompetitionWithEntries value, $Res Function(_CompetitionWithEntries) _then) = __$CompetitionWithEntriesCopyWithImpl;
@override @useResult
$Res call({
 Competition competition, List<CompetitionEntry> entries, CompetitionEntry? myEntry
});


@override $CompetitionCopyWith<$Res> get competition;@override $CompetitionEntryCopyWith<$Res>? get myEntry;

}
/// @nodoc
class __$CompetitionWithEntriesCopyWithImpl<$Res>
    implements _$CompetitionWithEntriesCopyWith<$Res> {
  __$CompetitionWithEntriesCopyWithImpl(this._self, this._then);

  final _CompetitionWithEntries _self;
  final $Res Function(_CompetitionWithEntries) _then;

/// Create a copy of CompetitionWithEntries
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? competition = null,Object? entries = null,Object? myEntry = freezed,}) {
  return _then(_CompetitionWithEntries(
competition: null == competition ? _self.competition : competition // ignore: cast_nullable_to_non_nullable
as Competition,entries: null == entries ? _self._entries : entries // ignore: cast_nullable_to_non_nullable
as List<CompetitionEntry>,myEntry: freezed == myEntry ? _self.myEntry : myEntry // ignore: cast_nullable_to_non_nullable
as CompetitionEntry?,
  ));
}

/// Create a copy of CompetitionWithEntries
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CompetitionCopyWith<$Res> get competition {
  
  return $CompetitionCopyWith<$Res>(_self.competition, (value) {
    return _then(_self.copyWith(competition: value));
  });
}/// Create a copy of CompetitionWithEntries
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CompetitionEntryCopyWith<$Res>? get myEntry {
    if (_self.myEntry == null) {
    return null;
  }

  return $CompetitionEntryCopyWith<$Res>(_self.myEntry!, (value) {
    return _then(_self.copyWith(myEntry: value));
  });
}
}

// dart format on
