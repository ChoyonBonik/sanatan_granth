import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.email,
    required super.displayName,
    super.photoUrl,
    super.isScholar = false,
    super.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String? ?? '',
      displayName: json['display_name'] as String? ?? 'Devotee',
      photoUrl: json['photo_url'] as String?,
      isScholar: json['is_scholar'] as bool? ?? false,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
    );
  }

  factory UserModel.fromSupabaseUser(User user) {
    return UserModel(
      id: user.id,
      email: user.email ?? '',
      displayName: user.userMetadata?['display_name'] as String? ??
          user.email?.split('@').first ??
          'Devotee',
      photoUrl: user.userMetadata?['avatar_url'] as String?,
      isScholar: user.userMetadata?['is_scholar'] as bool? ?? false,
      createdAt: DateTime.tryParse(user.createdAt),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'display_name': displayName,
      'photo_url': photoUrl,
      'is_scholar': isScholar,
      'created_at': createdAt?.toIso8601String(),
    };
  }
}
