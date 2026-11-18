import '../../domain/entities/category_entity.dart';

class CategoryModel extends CategoryEntity {
  const CategoryModel({
    required super.id,
    required super.name,
    super.sanskritName,
    required super.description,
    super.icon,
    super.bookCount = 0,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as String,
      name: json['name'] as String,
      sanskritName: json['sanskrit_name'] as String?,
      description: json['description'] as String? ?? '',
      icon: json['icon'] as String?,
      bookCount: (json['book_count'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'sanskrit_name': sanskritName,
      'description': description,
      'icon': icon,
      'book_count': bookCount,
    };
  }
}
