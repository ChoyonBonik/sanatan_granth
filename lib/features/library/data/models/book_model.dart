import '../../domain/entities/book_entity.dart';

class BookModel extends BookEntity {
  const BookModel({
    required super.id,
    required super.title,
    super.subtitle,
    super.authorRishi,
    super.author,
    super.categoryType = BookCategory.gita,
    super.category,
    super.language = 'Bengali',
    super.formatType,
    super.format,
    super.fileUrl,
    super.pdfUrl,
    super.coverUrl,
    super.coverImageUrl,
    super.status = BookSubmissionStatus.pending,
    super.contributorId,
    super.createdAt,
    super.updatedAt,
    super.sanskritTitle,
    super.description = '',
    super.totalVerses = 0,
    super.isFeatured = false,
    super.rating = 5.0,
    super.viewsCount = 0,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    final String formatStr =
        (json['format_type'] ?? json['format'] ?? 'structured').toString();
    final BookFormatType format = BookFormatType.fromString(formatStr);

    final String catStr = (json['category'] ?? 'Gita').toString();
    final BookCategory categoryType = BookCategory.fromString(catStr);

    final String statusStr = (json['status'] ?? 'pending').toString();
    final BookSubmissionStatus status = BookSubmissionStatus.fromString(statusStr);

    final String author = (json['author_rishi'] ?? json['author'] ?? '').toString();
    final String? subtitle = (json['subtitle'] ?? json['sanskrit_title']) as String?;
    final String? coverUrl = (json['cover_url'] ?? json['cover_image_url']) as String?;
    final String? fileUrl = (json['file_url'] ?? json['pdf_url']) as String?;

    return BookModel(
      id: json['id'] as String,
      title: json['title'] as String,
      subtitle: subtitle,
      authorRishi: author,
      categoryType: categoryType,
      category: catStr,
      language: json['language'] as String? ?? 'Bengali',
      formatType: format,
      fileUrl: fileUrl,
      coverUrl: coverUrl,
      status: status,
      contributorId: json['contributor_id'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'] as String)
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'] as String)
          : null,
      sanskritTitle: json['sanskrit_title'] as String? ?? subtitle,
      description: json['description'] as String? ?? subtitle ?? '',
      totalVerses: (json['total_verses'] as num?)?.toInt() ?? 0,
      isFeatured: json['is_featured'] as bool? ?? false,
      rating: (json['rating'] as num?)?.toDouble() ?? 5.0,
      viewsCount: (json['views_count'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'author_rishi': authorRishi,
      'category': categoryName,
      'language': language,
      'format_type': formatType.value,
      'file_url': fileUrl,
      'cover_url': coverUrl,
      'status': status.value,
      'contributor_id': contributorId,
      if (createdAt != null) 'created_at': createdAt!.toIso8601String(),
      if (updatedAt != null) 'updated_at': updatedAt!.toIso8601String(),
      'description': description,
      'total_verses': totalVerses,
      'is_featured': isFeatured,
      'rating': rating,
      'views_count': viewsCount,
    };
  }

  factory BookModel.fromEntity(BookEntity entity) {
    return BookModel(
      id: entity.id,
      title: entity.title,
      subtitle: entity.subtitle,
      authorRishi: entity.authorRishi,
      categoryType: entity.categoryType,
      category: entity.categoryName,
      language: entity.language,
      formatType: entity.formatType,
      fileUrl: entity.fileUrl,
      coverUrl: entity.coverUrl,
      status: entity.status,
      contributorId: entity.contributorId,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      sanskritTitle: entity.sanskritTitle,
      description: entity.description,
      totalVerses: entity.totalVerses,
      isFeatured: entity.isFeatured,
      rating: entity.rating,
      viewsCount: entity.viewsCount,
    );
  }
}
