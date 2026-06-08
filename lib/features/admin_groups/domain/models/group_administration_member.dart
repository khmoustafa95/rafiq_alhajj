class GroupAdministrationMember {
  const GroupAdministrationMember({
    required this.id,
    required this.name,
    this.position,
    this.contact,
    this.photoUrl,
    this.sortOrder = 0,
  });

  final String id;
  final String name;
  final String? position;
  final String? contact;
  final String? photoUrl;
  final int sortOrder;

  GroupAdministrationMember copyWith({
    String? id,
    String? name,
    String? position,
    String? contact,
    String? photoUrl,
    int? sortOrder,
  }) {
    return GroupAdministrationMember(
      id: id ?? this.id,
      name: name ?? this.name,
      position: position ?? this.position,
      contact: contact ?? this.contact,
      photoUrl: photoUrl ?? this.photoUrl,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }
}
