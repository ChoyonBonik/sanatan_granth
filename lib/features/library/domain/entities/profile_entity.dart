import 'package:equatable/equatable.dart';

enum UserRole { user, moderator, admin }

class ProfileEntity extends Equatable {
  final String id;
  final String fullName;
  final String? avatarUrl;
  final UserRole role;
  final int contributionCount;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const ProfileEntity({
    required this.id,
    required this.fullName,
    this.avatarUrl,
    this.role = UserRole.user,
    this.contributionCount = 0,
    this.createdAt,
    this.updatedAt,
  });

  bool get isAdmin => role == UserRole.admin;
  bool get isModerator => role == UserRole.moderator || role == UserRole.admin;

  @override
  List<Object?> get props => <Object?>[
        id,
        fullName,
        avatarUrl,
        role,
        contributionCount,
        createdAt,
        updatedAt,
      ];
}
