// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'competition_question_editor_input.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CompetitionQuestionOptionInput {

 String? get id; String get label; bool get isCorrect; int get sortOrder;
/// Create a copy of CompetitionQuestionOptionInput
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompetitionQuestionOptionInputCopyWith<CompetitionQuestionOptionInput> get copyWith => _$CompetitionQuestionOptionInputCopyWithImpl<CompetitionQuestionOptionInput>(this as CompetitionQuestionOptionInput, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompetitionQuestionOptionInput&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&(identical(other.isCorrect, isCorrect) || other.isCorrect == isCorrect)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder));
}


@override
int get hashCode => Object.hash(runtimeType,id,label,isCorrect,sortOrder);

@override
String toString() {
  return 'CompetitionQuestionOptionInput(id: $id, label: $label, isCorrect: $isCorrect, sortOrder: $sortOrder)';
}


}

/// @nodoc
abstract mixin class $CompetitionQuestionOptionInputCopyWith<$Res>  {
  factory $CompetitionQuestionOptionInputCopyWith(CompetitionQuestionOptionInput value, $Res Function(CompetitionQuestionOptionInput) _then) = _$CompetitionQuestionOptionInputCopyWithImpl;
@useResult
$Res call({
 String? id, String label, bool isCorrect, int sortOrder
});




}
/// @nodoc
class _$CompetitionQuestionOptionInputCopyWithImpl<$Res>
    implements $CompetitionQuestionOptionInputCopyWith<$Res> {
  _$CompetitionQuestionOptionInputCopyWithImpl(this._self, this._then);

  final CompetitionQuestionOptionInput _self;
  final $Res Function(CompetitionQuestionOptionInput) _then;

/// Create a copy of CompetitionQuestionOptionInput
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? label = null,Object? isCorrect = null,Object? sortOrder = null,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,isCorrect: null == isCorrect ? _self.isCorrect : isCorrect // ignore: cast_nullable_to_non_nullable
as bool,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CompetitionQuestionOptionInput].
extension CompetitionQuestionOptionInputPatterns on CompetitionQuestionOptionInput {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CompetitionQuestionOptionInput value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CompetitionQuestionOptionInput() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CompetitionQuestionOptionInput value)  $default,){
final _that = this;
switch (_that) {
case _CompetitionQuestionOptionInput():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CompetitionQuestionOptionInput value)?  $default,){
final _that = this;
switch (_that) {
case _CompetitionQuestionOptionInput() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String label,  bool isCorrect,  int sortOrder)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CompetitionQuestionOptionInput() when $default != null:
return $default(_that.id,_that.label,_that.isCorrect,_that.sortOrder);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String label,  bool isCorrect,  int sortOrder)  $default,) {final _that = this;
switch (_that) {
case _CompetitionQuestionOptionInput():
return $default(_that.id,_that.label,_that.isCorrect,_that.sortOrder);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String label,  bool isCorrect,  int sortOrder)?  $default,) {final _that = this;
switch (_that) {
case _CompetitionQuestionOptionInput() when $default != null:
return $default(_that.id,_that.label,_that.isCorrect,_that.sortOrder);case _:
  return null;

}
}

}

/// @nodoc


class _CompetitionQuestionOptionInput implements CompetitionQuestionOptionInput {
  const _CompetitionQuestionOptionInput({this.id, required this.label, required this.isCorrect, this.sortOrder = 0});
  

@override final  String? id;
@override final  String label;
@override final  bool isCorrect;
@override@JsonKey() final  int sortOrder;

/// Create a copy of CompetitionQuestionOptionInput
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CompetitionQuestionOptionInputCopyWith<_CompetitionQuestionOptionInput> get copyWith => __$CompetitionQuestionOptionInputCopyWithImpl<_CompetitionQuestionOptionInput>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CompetitionQuestionOptionInput&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&(identical(other.isCorrect, isCorrect) || other.isCorrect == isCorrect)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder));
}


@override
int get hashCode => Object.hash(runtimeType,id,label,isCorrect,sortOrder);

@override
String toString() {
  return 'CompetitionQuestionOptionInput(id: $id, label: $label, isCorrect: $isCorrect, sortOrder: $sortOrder)';
}


}

/// @nodoc
abstract mixin class _$CompetitionQuestionOptionInputCopyWith<$Res> implements $CompetitionQuestionOptionInputCopyWith<$Res> {
  factory _$CompetitionQuestionOptionInputCopyWith(_CompetitionQuestionOptionInput value, $Res Function(_CompetitionQuestionOptionInput) _then) = __$CompetitionQuestionOptionInputCopyWithImpl;
@override @useResult
$Res call({
 String? id, String label, bool isCorrect, int sortOrder
});




}
/// @nodoc
class __$CompetitionQuestionOptionInputCopyWithImpl<$Res>
    implements _$CompetitionQuestionOptionInputCopyWith<$Res> {
  __$CompetitionQuestionOptionInputCopyWithImpl(this._self, this._then);

  final _CompetitionQuestionOptionInput _self;
  final $Res Function(_CompetitionQuestionOptionInput) _then;

/// Create a copy of CompetitionQuestionOptionInput
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? label = null,Object? isCorrect = null,Object? sortOrder = null,}) {
  return _then(_CompetitionQuestionOptionInput(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,isCorrect: null == isCorrect ? _self.isCorrect : isCorrect // ignore: cast_nullable_to_non_nullable
as bool,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$CompetitionQuestionEditorInput {

 String? get id; String get competitionId; CompetitionQuestionType get questionType; String get prompt; String? get explanation; int get points; List<CompetitionQuestionOptionInput> get options; int get sortOrder;
/// Create a copy of CompetitionQuestionEditorInput
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompetitionQuestionEditorInputCopyWith<CompetitionQuestionEditorInput> get copyWith => _$CompetitionQuestionEditorInputCopyWithImpl<CompetitionQuestionEditorInput>(this as CompetitionQuestionEditorInput, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompetitionQuestionEditorInput&&(identical(other.id, id) || other.id == id)&&(identical(other.competitionId, competitionId) || other.competitionId == competitionId)&&(identical(other.questionType, questionType) || other.questionType == questionType)&&(identical(other.prompt, prompt) || other.prompt == prompt)&&(identical(other.explanation, explanation) || other.explanation == explanation)&&(identical(other.points, points) || other.points == points)&&const DeepCollectionEquality().equals(other.options, options)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder));
}


@override
int get hashCode => Object.hash(runtimeType,id,competitionId,questionType,prompt,explanation,points,const DeepCollectionEquality().hash(options),sortOrder);

@override
String toString() {
  return 'CompetitionQuestionEditorInput(id: $id, competitionId: $competitionId, questionType: $questionType, prompt: $prompt, explanation: $explanation, points: $points, options: $options, sortOrder: $sortOrder)';
}


}

/// @nodoc
abstract mixin class $CompetitionQuestionEditorInputCopyWith<$Res>  {
  factory $CompetitionQuestionEditorInputCopyWith(CompetitionQuestionEditorInput value, $Res Function(CompetitionQuestionEditorInput) _then) = _$CompetitionQuestionEditorInputCopyWithImpl;
@useResult
$Res call({
 String? id, String competitionId, CompetitionQuestionType questionType, String prompt, String? explanation, int points, List<CompetitionQuestionOptionInput> options, int sortOrder
});




}
/// @nodoc
class _$CompetitionQuestionEditorInputCopyWithImpl<$Res>
    implements $CompetitionQuestionEditorInputCopyWith<$Res> {
  _$CompetitionQuestionEditorInputCopyWithImpl(this._self, this._then);

  final CompetitionQuestionEditorInput _self;
  final $Res Function(CompetitionQuestionEditorInput) _then;

/// Create a copy of CompetitionQuestionEditorInput
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? competitionId = null,Object? questionType = null,Object? prompt = null,Object? explanation = freezed,Object? points = null,Object? options = null,Object? sortOrder = null,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,competitionId: null == competitionId ? _self.competitionId : competitionId // ignore: cast_nullable_to_non_nullable
as String,questionType: null == questionType ? _self.questionType : questionType // ignore: cast_nullable_to_non_nullable
as CompetitionQuestionType,prompt: null == prompt ? _self.prompt : prompt // ignore: cast_nullable_to_non_nullable
as String,explanation: freezed == explanation ? _self.explanation : explanation // ignore: cast_nullable_to_non_nullable
as String?,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as int,options: null == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as List<CompetitionQuestionOptionInput>,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CompetitionQuestionEditorInput].
extension CompetitionQuestionEditorInputPatterns on CompetitionQuestionEditorInput {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CompetitionQuestionEditorInput value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CompetitionQuestionEditorInput() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CompetitionQuestionEditorInput value)  $default,){
final _that = this;
switch (_that) {
case _CompetitionQuestionEditorInput():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CompetitionQuestionEditorInput value)?  $default,){
final _that = this;
switch (_that) {
case _CompetitionQuestionEditorInput() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String competitionId,  CompetitionQuestionType questionType,  String prompt,  String? explanation,  int points,  List<CompetitionQuestionOptionInput> options,  int sortOrder)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CompetitionQuestionEditorInput() when $default != null:
return $default(_that.id,_that.competitionId,_that.questionType,_that.prompt,_that.explanation,_that.points,_that.options,_that.sortOrder);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String competitionId,  CompetitionQuestionType questionType,  String prompt,  String? explanation,  int points,  List<CompetitionQuestionOptionInput> options,  int sortOrder)  $default,) {final _that = this;
switch (_that) {
case _CompetitionQuestionEditorInput():
return $default(_that.id,_that.competitionId,_that.questionType,_that.prompt,_that.explanation,_that.points,_that.options,_that.sortOrder);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String competitionId,  CompetitionQuestionType questionType,  String prompt,  String? explanation,  int points,  List<CompetitionQuestionOptionInput> options,  int sortOrder)?  $default,) {final _that = this;
switch (_that) {
case _CompetitionQuestionEditorInput() when $default != null:
return $default(_that.id,_that.competitionId,_that.questionType,_that.prompt,_that.explanation,_that.points,_that.options,_that.sortOrder);case _:
  return null;

}
}

}

/// @nodoc


class _CompetitionQuestionEditorInput extends CompetitionQuestionEditorInput {
  const _CompetitionQuestionEditorInput({this.id, required this.competitionId, required this.questionType, required this.prompt, this.explanation, required this.points, required final  List<CompetitionQuestionOptionInput> options, this.sortOrder = 0}): _options = options,super._();
  

@override final  String? id;
@override final  String competitionId;
@override final  CompetitionQuestionType questionType;
@override final  String prompt;
@override final  String? explanation;
@override final  int points;
 final  List<CompetitionQuestionOptionInput> _options;
@override List<CompetitionQuestionOptionInput> get options {
  if (_options is EqualUnmodifiableListView) return _options;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_options);
}

@override@JsonKey() final  int sortOrder;

/// Create a copy of CompetitionQuestionEditorInput
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CompetitionQuestionEditorInputCopyWith<_CompetitionQuestionEditorInput> get copyWith => __$CompetitionQuestionEditorInputCopyWithImpl<_CompetitionQuestionEditorInput>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CompetitionQuestionEditorInput&&(identical(other.id, id) || other.id == id)&&(identical(other.competitionId, competitionId) || other.competitionId == competitionId)&&(identical(other.questionType, questionType) || other.questionType == questionType)&&(identical(other.prompt, prompt) || other.prompt == prompt)&&(identical(other.explanation, explanation) || other.explanation == explanation)&&(identical(other.points, points) || other.points == points)&&const DeepCollectionEquality().equals(other._options, _options)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder));
}


@override
int get hashCode => Object.hash(runtimeType,id,competitionId,questionType,prompt,explanation,points,const DeepCollectionEquality().hash(_options),sortOrder);

@override
String toString() {
  return 'CompetitionQuestionEditorInput(id: $id, competitionId: $competitionId, questionType: $questionType, prompt: $prompt, explanation: $explanation, points: $points, options: $options, sortOrder: $sortOrder)';
}


}

/// @nodoc
abstract mixin class _$CompetitionQuestionEditorInputCopyWith<$Res> implements $CompetitionQuestionEditorInputCopyWith<$Res> {
  factory _$CompetitionQuestionEditorInputCopyWith(_CompetitionQuestionEditorInput value, $Res Function(_CompetitionQuestionEditorInput) _then) = __$CompetitionQuestionEditorInputCopyWithImpl;
@override @useResult
$Res call({
 String? id, String competitionId, CompetitionQuestionType questionType, String prompt, String? explanation, int points, List<CompetitionQuestionOptionInput> options, int sortOrder
});




}
/// @nodoc
class __$CompetitionQuestionEditorInputCopyWithImpl<$Res>
    implements _$CompetitionQuestionEditorInputCopyWith<$Res> {
  __$CompetitionQuestionEditorInputCopyWithImpl(this._self, this._then);

  final _CompetitionQuestionEditorInput _self;
  final $Res Function(_CompetitionQuestionEditorInput) _then;

/// Create a copy of CompetitionQuestionEditorInput
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? competitionId = null,Object? questionType = null,Object? prompt = null,Object? explanation = freezed,Object? points = null,Object? options = null,Object? sortOrder = null,}) {
  return _then(_CompetitionQuestionEditorInput(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,competitionId: null == competitionId ? _self.competitionId : competitionId // ignore: cast_nullable_to_non_nullable
as String,questionType: null == questionType ? _self.questionType : questionType // ignore: cast_nullable_to_non_nullable
as CompetitionQuestionType,prompt: null == prompt ? _self.prompt : prompt // ignore: cast_nullable_to_non_nullable
as String,explanation: freezed == explanation ? _self.explanation : explanation // ignore: cast_nullable_to_non_nullable
as String?,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as int,options: null == options ? _self._options : options // ignore: cast_nullable_to_non_nullable
as List<CompetitionQuestionOptionInput>,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
