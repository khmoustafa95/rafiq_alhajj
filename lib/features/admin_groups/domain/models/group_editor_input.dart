import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'group_editor_input.freezed.dart';

@freezed
abstract class GroupMemberEditorInput with _$GroupMemberEditorInput {
  const factory GroupMemberEditorInput({
    String? id,
    required String name,
    String? position,
    String? contact,
    String? photoUrl,
    Uint8List? photoBytes,
    String? photoFileName,
    @Default(0) int sortOrder,
  }) = _GroupMemberEditorInput;
}

@freezed
abstract class GroupEditorInput with _$GroupEditorInput {
  const factory GroupEditorInput({
    String? id,
    required String name,
    String? logoUrl,
    Uint8List? logoBytes,
    String? logoFileName,
    String? presidentName,
    String? presidentPhone,
    @Default([]) List<GroupMemberEditorInput> members,
  }) = _GroupEditorInput;

  const GroupEditorInput._();

  bool get isEditing => id != null;
}
