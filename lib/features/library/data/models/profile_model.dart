import '../../domain/entities/profile_entity.dart';

class ProfileModel extends ProfileEntity {
  const ProfileModel({
    required super.id,
    required super.fullName,
    super.avatarUrl,
    super.role = UserRole.user,
    super.contributionCount = 0,
    super.createdAt,
    super.updatedAt,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    UserRole role = UserRole.user;
    final String? roleStr = json['role'] as String?;
    if (roleStr == 'admin') {
      role = UserRole.admin;
    } else if (roleStr == 'moderator') {
      role = UserRole.moderator;
    }

    return ProfileModel(
      id: json['id'] as String,
      fullName: json['full_name'] as String? ?? '',
      avatarUrl: json['avatar_url'] as String?,
      role: role,
      contributionCount: (json['contribution_count'] as num?)?.toInt() ?? 0,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'] as String)
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'full_name': fullName,
      'avatar_url': avatarUrl,
      'role': role.name,
      'contribution_count': contributionCount,
      if (createdAt != null) 'created_at': createdAt!.toIso8601String(),
      if (updatedAt != null) 'updated_at': updatedAt!.toIso8601String(),
    };
  }

  factory ProfileModel.fromEntity(ProfileEntity entity) {
    return ProfileModel(
      id: entity.id,
      fullName: entity.fullName,
      avatarUrl: entity.avatarUrl,
      role: entity.role,
      contributionCount: entity.contributionCount,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }
}
