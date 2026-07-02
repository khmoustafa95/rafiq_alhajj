// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group_editor_input.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GroupMemberEditorInput {

 String? get id; String get name; String? get position; String? get contact; String? get photoUrl; Uint8List? get photoBytes; String? get photoFileName; int get sortOrder;
/// Create a copy of GroupMemberEditorInput
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GroupMemberEditorInputCopyWith<GroupMemberEditorInput> get copyWith => _$GroupMemberEditorInputCopyWithImpl<GroupMemberEditorInput>(this as GroupMemberEditorInput, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GroupMemberEditorInput&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.position, position) || other.position == position)&&(identical(other.contact, contact) || other.contact == contact)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&const DeepCollectionEquality().equals(other.photoBytes, photoBytes)&&(identical(other.photoFileName, photoFileName) || other.photoFileName == photoFileName)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,position,contact,photoUrl,const DeepCollectionEquality().hash(photoBytes),photoFileName,sortOrder);

@override
String toString() {
  return 'GroupMemberEditorInput(id: $id, name: $name, position: $position, contact: $contact, photoUrl: $photoUrl, photoBytes: $photoBytes, photoFileName: $photoFileName, sortOrder: $sortOrder)';
}


}

/// @nodoc
abstract mixin class $GroupMemberEditorInputCopyWith<$Res>  {
  factory $GroupMemberEditorInputCopyWith(GroupMemberEditorInput value, $Res Function(GroupMemberEditorInput) _then) = _$GroupMemberEditorInputCopyWithImpl;
@useResult
$Res call({
 String? id, String name, String? position, String? contact, String? photoUrl, Uint8List? photoBytes, String? photoFileName, int sortOrder
});




}
/// @nodoc
class _$GroupMemberEditorInputCopyWithImpl<$Res>
    implements $GroupMemberEditorInputCopyWith<$Res> {
  _$GroupMemberEditorInputCopyWithImpl(this._self, this._then);

  final GroupMemberEditorInput _self;
  final $Res Function(GroupMemberEditorInput) _then;

/// Create a copy of GroupMemberEditorInput
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? name = null,Object? position = freezed,Object? contact = freezed,Object? photoUrl = freezed,Object? photoBytes = freezed,Object? photoFileName = freezed,Object? sortOrder = null,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,position: freezed == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as String?,contact: freezed == contact ? _self.contact : contact // ignore: cast_nullable_to_non_nullable
as String?,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,photoBytes: freezed == photoBytes ? _self.photoBytes : photoBytes // ignore: cast_nullable_to_non_nullable
as Uint8List?,photoFileName: freezed == photoFileName ? _self.photoFileName : photoFileName // ignore: cast_nullable_to_non_nullable
as String?,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [GroupMemberEditorInput].
extension GroupMemberEditorInputPatterns on GroupMemberEditorInput {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GroupMemberEditorInput value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GroupMemberEditorInput() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GroupMemberEditorInput value)  $default,){
final _that = this;
switch (_that) {
case _GroupMemberEditorInput():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GroupMemberEditorInput value)?  $default,){
final _that = this;
switch (_that) {
case _GroupMemberEditorInput() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String name,  String? position,  String? contact,  String? photoUrl,  Uint8List? photoBytes,  String? photoFileName,  int sortOrder)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GroupMemberEditorInput() when $default != null:
return $default(_that.id,_that.name,_that.position,_that.contact,_that.photoUrl,_that.photoBytes,_that.photoFileName,_that.sortOrder);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String name,  String? position,  String? contact,  String? photoUrl,  Uint8List? photoBytes,  String? photoFileName,  int sortOrder)  $default,) {final _that = this;
switch (_that) {
case _GroupMemberEditorInput():
return $default(_that.id,_that.name,_that.position,_that.contact,_that.photoUrl,_that.photoBytes,_that.photoFileName,_that.sortOrder);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String name,  String? position,  String? contact,  String? photoUrl,  Uint8List? photoBytes,  String? photoFileName,  int sortOrder)?  $default,) {final _that = this;
switch (_that) {
case _GroupMemberEditorInput() when $default != null:
return $default(_that.id,_that.name,_that.position,_that.contact,_that.photoUrl,_that.photoBytes,_that.photoFileName,_that.sortOrder);case _:
  return null;

}
}

}

/// @nodoc


class _GroupMemberEditorInput implements GroupMemberEditorInput {
  const _GroupMemberEditorInput({this.id, required this.name, this.position, this.contact, this.photoUrl, this.photoBytes, this.photoFileName, this.sortOrder = 0});
  

@override final  String? id;
@override final  String name;
@override final  String? position;
@override final  String? contact;
@override final  String? photoUrl;
@override final  Uint8List? photoBytes;
@override final  String? photoFileName;
@override@JsonKey() final  int sortOrder;

/// Create a copy of GroupMemberEditorInput
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GroupMemberEditorInputCopyWith<_GroupMemberEditorInput> get copyWith => __$GroupMemberEditorInputCopyWithImpl<_GroupMemberEditorInput>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GroupMemberEditorInput&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.position, position) || other.position == position)&&(identical(other.contact, contact) || other.contact == contact)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&const DeepCollectionEquality().equals(other.photoBytes, photoBytes)&&(identical(other.photoFileName, photoFileName) || other.photoFileName == photoFileName)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,position,contact,photoUrl,const DeepCollectionEquality().hash(photoBytes),photoFileName,sortOrder);

@override
String toString() {
  return 'GroupMemberEditorInput(id: $id, name: $name, position: $position, contact: $contact, photoUrl: $photoUrl, photoBytes: $photoBytes, photoFileName: $photoFileName, sortOrder: $sortOrder)';
}


}

/// @nodoc
abstract mixin class _$GroupMemberEditorInputCopyWith<$Res> implements $GroupMemberEditorInputCopyWith<$Res> {
  factory _$GroupMemberEditorInputCopyWith(_GroupMemberEditorInput value, $Res Function(_GroupMemberEditorInput) _then) = __$GroupMemberEditorInputCopyWithImpl;
@override @useResult
$Res call({
 String? id, String name, String? position, String? contact, String? photoUrl, Uint8List? photoBytes, String? photoFileName, int sortOrder
});




}
/// @nodoc
class __$GroupMemberEditorInputCopyWithImpl<$Res>
    implements _$GroupMemberEditorInputCopyWith<$Res> {
  __$GroupMemberEditorInputCopyWithImpl(this._self, this._then);

  final _GroupMemberEditorInput _self;
  final $Res Function(_GroupMemberEditorInput) _then;

/// Create a copy of GroupMemberEditorInput
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? name = null,Object? position = freezed,Object? contact = freezed,Object? photoUrl = freezed,Object? photoBytes = freezed,Object? photoFileName = freezed,Object? sortOrder = null,}) {
  return _then(_GroupMemberEditorInput(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,position: freezed == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as String?,contact: freezed == contact ? _self.contact : contact // ignore: cast_nullable_to_non_nullable
as String?,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,photoBytes: freezed == photoBytes ? _self.photoBytes : photoBytes // ignore: cast_nullable_to_non_nullable
as Uint8List?,photoFileName: freezed == photoFileName ? _self.photoFileName : photoFileName // ignore: cast_nullable_to_non_nullable
as String?,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$GroupEditorInput {

 String? get id; String get name; String? get logoUrl; Uint8List? get logoBytes; String? get logoFileName; String? get presidentName; String? get presidentPhone; List<GroupMemberEditorInput> get members;
/// Create a copy of GroupEditorInput
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GroupEditorInputCopyWith<GroupEditorInput> get copyWith => _$GroupEditorInputCopyWithImpl<GroupEditorInput>(this as GroupEditorInput, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GroupEditorInput&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl)&&const DeepCollectionEquality().equals(other.logoBytes, logoBytes)&&(identical(other.logoFileName, logoFileName) || other.logoFileName == logoFileName)&&(identical(other.presidentName, presidentName) || other.presidentName == presidentName)&&(identical(other.presidentPhone, presidentPhone) || other.presidentPhone == presidentPhone)&&const DeepCollectionEquality().equals(other.members, members));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,logoUrl,const DeepCollectionEquality().hash(logoBytes),logoFileName,presidentName,presidentPhone,const DeepCollectionEquality().hash(members));

@override
String toString() {
  return 'GroupEditorInput(id: $id, name: $name, logoUrl: $logoUrl, logoBytes: $logoBytes, logoFileName: $logoFileName, presidentName: $presidentName, presidentPhone: $presidentPhone, members: $members)';
}


}

/// @nodoc
abstract mixin class $GroupEditorInputCopyWith<$Res>  {
  factory $GroupEditorInputCopyWith(GroupEditorInput value, $Res Function(GroupEditorInput) _then) = _$GroupEditorInputCopyWithImpl;
@useResult
$Res call({
 String? id, String name, String? logoUrl, Uint8List? logoBytes, String? logoFileName, String? presidentName, String? presidentPhone, List<GroupMemberEditorInput> members
});




}
/// @nodoc
class _$GroupEditorInputCopyWithImpl<$Res>
    implements $GroupEditorInputCopyWith<$Res> {
  _$GroupEditorInputCopyWithImpl(this._self, this._then);

  final GroupEditorInput _self;
  final $Res Function(GroupEditorInput) _then;

/// Create a copy of GroupEditorInput
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? name = null,Object? logoUrl = freezed,Object? logoBytes = freezed,Object? logoFileName = freezed,Object? presidentName = freezed,Object? presidentPhone = freezed,Object? members = null,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,logoUrl: freezed == logoUrl ? _self.logoUrl : logoUrl // ignore: cast_nullable_to_non_nullable
as String?,logoBytes: freezed == logoBytes ? _self.logoBytes : logoBytes // ignore: cast_nullable_to_non_nullable
as Uint8List?,logoFileName: freezed == logoFileName ? _self.logoFileName : logoFileName // ignore: cast_nullable_to_non_nullable
as String?,presidentName: freezed == presidentName ? _self.presidentName : presidentName // ignore: cast_nullable_to_non_nullable
as String?,presidentPhone: freezed == presidentPhone ? _self.presidentPhone : presidentPhone // ignore: cast_nullable_to_non_nullable
as String?,members: null == members ? _self.members : members // ignore: cast_nullable_to_non_nullable
as List<GroupMemberEditorInput>,
  ));
}

}


/// Adds pattern-matching-related methods to [GroupEditorInput].
extension GroupEditorInputPatterns on GroupEditorInput {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GroupEditorInput value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GroupEditorInput() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GroupEditorInput value)  $default,){
final _that = this;
switch (_that) {
case _GroupEditorInput():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GroupEditorInput value)?  $default,){
final _that = this;
switch (_that) {
case _GroupEditorInput() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String name,  String? logoUrl,  Uint8List? logoBytes,  String? logoFileName,  String? presidentName,  String? presidentPhone,  List<GroupMemberEditorInput> members)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GroupEditorInput() when $default != null:
return $default(_that.id,_that.name,_that.logoUrl,_that.logoBytes,_that.logoFileName,_that.presidentName,_that.presidentPhone,_that.members);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String name,  String? logoUrl,  Uint8List? logoBytes,  String? logoFileName,  String? presidentName,  String? presidentPhone,  List<GroupMemberEditorInput> members)  $default,) {final _that = this;
switch (_that) {
case _GroupEditorInput():
return $default(_that.id,_that.name,_that.logoUrl,_that.logoBytes,_that.logoFileName,_that.presidentName,_that.presidentPhone,_that.members);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String name,  String? logoUrl,  Uint8List? logoBytes,  String? logoFileName,  String? presidentName,  String? presidentPhone,  List<GroupMemberEditorInput> members)?  $default,) {final _that = this;
switch (_that) {
case _GroupEditorInput() when $default != null:
return $default(_that.id,_that.name,_that.logoUrl,_that.logoBytes,_that.logoFileName,_that.presidentName,_that.presidentPhone,_that.members);case _:
  return null;

}
}

}

/// @nodoc


class _GroupEditorInput extends GroupEditorInput {
  const _GroupEditorInput({this.id, required this.name, this.logoUrl, this.logoBytes, this.logoFileName, this.presidentName, this.presidentPhone, final  List<GroupMemberEditorInput> members = const []}): _members = members,super._();
  

@override final  String? id;
@override final  String name;
@override final  String? logoUrl;
@override final  Uint8List? logoBytes;
@override final  String? logoFileName;
@override final  String? presidentName;
@override final  String? presidentPhone;
 final  List<GroupMemberEditorInput> _members;
@override@JsonKey() List<GroupMemberEditorInput> get members {
  if (_members is EqualUnmodifiableListView) return _members;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_members);
}


/// Create a copy of GroupEditorInput
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GroupEditorInputCopyWith<_GroupEditorInput> get copyWith => __$GroupEditorInputCopyWithImpl<_GroupEditorInput>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GroupEditorInput&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl)&&const DeepCollectionEquality().equals(other.logoBytes, logoBytes)&&(identical(other.logoFileName, logoFileName) || other.logoFileName == logoFileName)&&(identical(other.presidentName, presidentName) || other.presidentName == presidentName)&&(identical(other.presidentPhone, presidentPhone) || other.presidentPhone == presidentPhone)&&const DeepCollectionEquality().equals(other._members, _members));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,logoUrl,const DeepCollectionEquality().hash(logoBytes),logoFileName,presidentName,presidentPhone,const DeepCollectionEquality().hash(_members));

@override
String toString() {
  return 'GroupEditorInput(id: $id, name: $name, logoUrl: $logoUrl, logoBytes: $logoBytes, logoFileName: $logoFileName, presidentName: $presidentName, presidentPhone: $presidentPhone, members: $members)';
}


}

/// @nodoc
abstract mixin class _$GroupEditorInputCopyWith<$Res> implements $GroupEditorInputCopyWith<$Res> {
  factory _$GroupEditorInputCopyWith(_GroupEditorInput value, $Res Function(_GroupEditorInput) _then) = __$GroupEditorInputCopyWithImpl;
@override @useResult
$Res call({
 String? id, String name, String? logoUrl, Uint8List? logoBytes, String? logoFileName, String? presidentName, String? presidentPhone, List<GroupMemberEditorInput> members
});




}
/// @nodoc
class __$GroupEditorInputCopyWithImpl<$Res>
    implements _$GroupEditorInputCopyWith<$Res> {
  __$GroupEditorInputCopyWithImpl(this._self, this._then);

  final _GroupEditorInput _self;
  final $Res Function(_GroupEditorInput) _then;

/// Create a copy of GroupEditorInput
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? name = null,Object? logoUrl = freezed,Object? logoBytes = freezed,Object? logoFileName = freezed,Object? presidentName = freezed,Object? presidentPhone = freezed,Object? members = null,}) {
  return _then(_GroupEditorInput(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,logoUrl: freezed == logoUrl ? _self.logoUrl : logoUrl // ignore: cast_nullable_to_non_nullable
as String?,logoBytes: freezed == logoBytes ? _self.logoBytes : logoBytes // ignore: cast_nullable_to_non_nullable
as Uint8List?,logoFileName: freezed == logoFileName ? _self.logoFileName : logoFileName // ignore: cast_nullable_to_non_nullable
as String?,presidentName: freezed == presidentName ? _self.presidentName : presidentName // ignore: cast_nullable_to_non_nullable
as String?,presidentPhone: freezed == presidentPhone ? _self.presidentPhone : presidentPhone // ignore: cast_nullable_to_non_nullable
as String?,members: null == members ? _self._members : members // ignore: cast_nullable_to_non_nullable
as List<GroupMemberEditorInput>,
  ));
}


}

// dart format on
