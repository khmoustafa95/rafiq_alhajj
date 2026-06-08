class OperatorPermissions {
  const OperatorPermissions({
    this.canRegisterPilgrims = true,
    this.canManagePilgrimRegistry = true,
    this.canUseFieldTools = true,
    this.canUploadDocuments = true,
  });

  factory OperatorPermissions.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return const OperatorPermissions();
    }
    return OperatorPermissions(
      canRegisterPilgrims: json['can_register_pilgrims'] as bool? ?? true,
      canManagePilgrimRegistry:
          json['can_manage_pilgrim_registry'] as bool? ?? true,
      canUseFieldTools: json['can_use_field_tools'] as bool? ?? true,
      canUploadDocuments: json['can_upload_documents'] as bool? ?? true,
    );
  }

  final bool canRegisterPilgrims;
  final bool canManagePilgrimRegistry;
  final bool canUseFieldTools;
  final bool canUploadDocuments;

  Map<String, dynamic> toJson() => {
        'can_register_pilgrims': canRegisterPilgrims,
        'can_manage_pilgrim_registry': canManagePilgrimRegistry,
        'can_use_field_tools': canUseFieldTools,
        'can_upload_documents': canUploadDocuments,
      };

  OperatorPermissions copyWith({
    bool? canRegisterPilgrims,
    bool? canManagePilgrimRegistry,
    bool? canUseFieldTools,
    bool? canUploadDocuments,
  }) {
    return OperatorPermissions(
      canRegisterPilgrims: canRegisterPilgrims ?? this.canRegisterPilgrims,
      canManagePilgrimRegistry:
          canManagePilgrimRegistry ?? this.canManagePilgrimRegistry,
      canUseFieldTools: canUseFieldTools ?? this.canUseFieldTools,
      canUploadDocuments: canUploadDocuments ?? this.canUploadDocuments,
    );
  }
}
