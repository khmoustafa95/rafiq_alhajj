/// A single group the operator may access, with read/write scope.
class OperatorGroupGrant {
  const OperatorGroupGrant({required this.groupId, this.canWrite = false});

  final String groupId;
  final bool canWrite;

  OperatorGroupGrant copyWith({bool? canWrite}) =>
      OperatorGroupGrant(groupId: groupId, canWrite: canWrite ?? this.canWrite);
}

/// A selectable group (id + display name) for the operator editor.
class OperatorGroupOption {
  const OperatorGroupOption({required this.id, required this.name});

  final String id;
  final String name;
}
