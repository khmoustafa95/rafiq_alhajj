import 'dart:typed_data';

class GroupMemberEditorInput {
  const GroupMemberEditorInput({
    this.id,
    required this.name,
    this.position,
    this.contact,
    this.photoUrl,
    this.photoBytes,
    this.photoFileName,
    this.sortOrder = 0,
  });

  final String? id;
  final String name;
  final String? position;
  final String? contact;
  final String? photoUrl;
  final Uint8List? photoBytes;
  final String? photoFileName;
  final int sortOrder;
}

class GroupEditorInput {
  const GroupEditorInput({
    this.id,
    required this.name,
    this.logoUrl,
    this.logoBytes,
    this.logoFileName,
    this.presidentName,
    this.presidentPhone,
    this.members = const [],
  });

  final String? id;
  final String name;
  final String? logoUrl;
  final Uint8List? logoBytes;
  final String? logoFileName;
  final String? presidentName;
  final String? presidentPhone;
  final List<GroupMemberEditorInput> members;

  bool get isEditing => id != null;
}
