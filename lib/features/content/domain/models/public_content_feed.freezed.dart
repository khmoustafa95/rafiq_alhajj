// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'public_content_feed.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PublicContentFeed {

 List<ContentItem> get announcements; List<ContentItem> get news; List<ContentTopic> get topics;
/// Create a copy of PublicContentFeed
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PublicContentFeedCopyWith<PublicContentFeed> get copyWith => _$PublicContentFeedCopyWithImpl<PublicContentFeed>(this as PublicContentFeed, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PublicContentFeed&&const DeepCollectionEquality().equals(other.announcements, announcements)&&const DeepCollectionEquality().equals(other.news, news)&&const DeepCollectionEquality().equals(other.topics, topics));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(announcements),const DeepCollectionEquality().hash(news),const DeepCollectionEquality().hash(topics));

@override
String toString() {
  return 'PublicContentFeed(announcements: $announcements, news: $news, topics: $topics)';
}


}

/// @nodoc
abstract mixin class $PublicContentFeedCopyWith<$Res>  {
  factory $PublicContentFeedCopyWith(PublicContentFeed value, $Res Function(PublicContentFeed) _then) = _$PublicContentFeedCopyWithImpl;
@useResult
$Res call({
 List<ContentItem> announcements, List<ContentItem> news, List<ContentTopic> topics
});




}
/// @nodoc
class _$PublicContentFeedCopyWithImpl<$Res>
    implements $PublicContentFeedCopyWith<$Res> {
  _$PublicContentFeedCopyWithImpl(this._self, this._then);

  final PublicContentFeed _self;
  final $Res Function(PublicContentFeed) _then;

/// Create a copy of PublicContentFeed
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? announcements = null,Object? news = null,Object? topics = null,}) {
  return _then(_self.copyWith(
announcements: null == announcements ? _self.announcements : announcements // ignore: cast_nullable_to_non_nullable
as List<ContentItem>,news: null == news ? _self.news : news // ignore: cast_nullable_to_non_nullable
as List<ContentItem>,topics: null == topics ? _self.topics : topics // ignore: cast_nullable_to_non_nullable
as List<ContentTopic>,
  ));
}

}


/// Adds pattern-matching-related methods to [PublicContentFeed].
extension PublicContentFeedPatterns on PublicContentFeed {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PublicContentFeed value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PublicContentFeed() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PublicContentFeed value)  $default,){
final _that = this;
switch (_that) {
case _PublicContentFeed():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PublicContentFeed value)?  $default,){
final _that = this;
switch (_that) {
case _PublicContentFeed() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<ContentItem> announcements,  List<ContentItem> news,  List<ContentTopic> topics)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PublicContentFeed() when $default != null:
return $default(_that.announcements,_that.news,_that.topics);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<ContentItem> announcements,  List<ContentItem> news,  List<ContentTopic> topics)  $default,) {final _that = this;
switch (_that) {
case _PublicContentFeed():
return $default(_that.announcements,_that.news,_that.topics);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<ContentItem> announcements,  List<ContentItem> news,  List<ContentTopic> topics)?  $default,) {final _that = this;
switch (_that) {
case _PublicContentFeed() when $default != null:
return $default(_that.announcements,_that.news,_that.topics);case _:
  return null;

}
}

}

/// @nodoc


class _PublicContentFeed extends PublicContentFeed {
  const _PublicContentFeed({required final  List<ContentItem> announcements, required final  List<ContentItem> news, required final  List<ContentTopic> topics}): _announcements = announcements,_news = news,_topics = topics,super._();
  

 final  List<ContentItem> _announcements;
@override List<ContentItem> get announcements {
  if (_announcements is EqualUnmodifiableListView) return _announcements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_announcements);
}

 final  List<ContentItem> _news;
@override List<ContentItem> get news {
  if (_news is EqualUnmodifiableListView) return _news;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_news);
}

 final  List<ContentTopic> _topics;
@override List<ContentTopic> get topics {
  if (_topics is EqualUnmodifiableListView) return _topics;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_topics);
}


/// Create a copy of PublicContentFeed
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PublicContentFeedCopyWith<_PublicContentFeed> get copyWith => __$PublicContentFeedCopyWithImpl<_PublicContentFeed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PublicContentFeed&&const DeepCollectionEquality().equals(other._announcements, _announcements)&&const DeepCollectionEquality().equals(other._news, _news)&&const DeepCollectionEquality().equals(other._topics, _topics));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_announcements),const DeepCollectionEquality().hash(_news),const DeepCollectionEquality().hash(_topics));

@override
String toString() {
  return 'PublicContentFeed(announcements: $announcements, news: $news, topics: $topics)';
}


}

/// @nodoc
abstract mixin class _$PublicContentFeedCopyWith<$Res> implements $PublicContentFeedCopyWith<$Res> {
  factory _$PublicContentFeedCopyWith(_PublicContentFeed value, $Res Function(_PublicContentFeed) _then) = __$PublicContentFeedCopyWithImpl;
@override @useResult
$Res call({
 List<ContentItem> announcements, List<ContentItem> news, List<ContentTopic> topics
});




}
/// @nodoc
class __$PublicContentFeedCopyWithImpl<$Res>
    implements _$PublicContentFeedCopyWith<$Res> {
  __$PublicContentFeedCopyWithImpl(this._self, this._then);

  final _PublicContentFeed _self;
  final $Res Function(_PublicContentFeed) _then;

/// Create a copy of PublicContentFeed
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? announcements = null,Object? news = null,Object? topics = null,}) {
  return _then(_PublicContentFeed(
announcements: null == announcements ? _self._announcements : announcements // ignore: cast_nullable_to_non_nullable
as List<ContentItem>,news: null == news ? _self._news : news // ignore: cast_nullable_to_non_nullable
as List<ContentItem>,topics: null == topics ? _self._topics : topics // ignore: cast_nullable_to_non_nullable
as List<ContentTopic>,
  ));
}


}

// dart format on
