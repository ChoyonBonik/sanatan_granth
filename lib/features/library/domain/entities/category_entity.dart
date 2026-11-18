import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  final String id;
  final String name;
  final String? sanskritName;
  final String description;
  final String? icon;
  final int bookCount;

  const CategoryEntity({
    required this.id,
    required this.name,
    this.sanskritName,
    required this.description,
    this.icon,
    this.bookCount = 0,
  });

  @override
  List<Object?> get props => <Object?>[
        id,
        name,
        sanskritName,
        description,
        icon,
        bookCount,
      ];
}
