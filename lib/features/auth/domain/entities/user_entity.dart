import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String email;
  final String displayName;
  final String? photoUrl;
  final bool isScholar;
  final DateTime? createdAt;

  const UserEntity({
    required this.id,
    required this.email,
    required this.displayName,
    this.photoUrl,
    this.isScholar = false,
    this.createdAt,
  });

  @override
  List<Object?> get props => <Object?>[
        id,
        email,
        displayName,
        photoUrl,
        isScholar,
        createdAt,
      ];
}
