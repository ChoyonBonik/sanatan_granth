import '../../domain/entities/book_entity.dart';

class BookModel extends BookEntity {
  const BookModel({
    required super.id,
    required super.title,
    super.sanskritTitle,
    required super.author,
    required super.category,
    required super.description,
    required super.language,
    super.coverImageUrl,
    super.pdfUrl,
    super.audioUrl,
    super.totalVerses = 0,
    super.format = BookFormat.structured,
    super.isFeatured = false,
    super.rating = 5.0,
    super.viewsCount = 0,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    BookFormat format = BookFormat.structured;
    if (json['format'] == 'pdf') {
      format = BookFormat.pdf;
    } else if (json['format'] == 'epub') {
      format = BookFormat.epub;
    }

    return BookModel(
      id: json['id'] as String,
      title: json['title'] as String,
      sanskritTitle: json['sanskrit_title'] as String?,
      author: json['author'] as String? ?? 'Sage Vyasa',
      category: json['category'] as String? ?? 'General',
      description: json['description'] as String? ?? '',
      language: json['language'] as String? ?? 'Sanskrit / English',
      coverImageUrl: json['cover_image_url'] as String?,
      pdfUrl: json['pdf_url'] as String?,
      audioUrl: json['audio_url'] as String?,
      totalVerses: (json['total_verses'] as num?)?.toInt() ?? 0,
      format: format,
      isFeatured: json['is_featured'] as bool? ?? false,
      rating: (json['rating'] as num?)?.toDouble() ?? 5.0,
      viewsCount: (json['views_count'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'sanskrit_title': sanskritTitle,
      'author': author,
      'category': category,
      'description': description,
      'language': language,
      'cover_image_url': coverImageUrl,
      'pdf_url': pdfUrl,
      'audio_url': audioUrl,
      'total_verses': totalVerses,
      'format': format.name,
      'is_featured': isFeatured,
      'rating': rating,
      'views_count': viewsCount,
    };
  }

  factory BookModel.fromEntity(BookEntity entity) {
    return BookModel(
      id: entity.id,
      title: entity.title,
      sanskritTitle: entity.sanskritTitle,
      author: entity.author,
      category: entity.category,
      description: entity.description,
      language: entity.language,
      coverImageUrl: entity.coverImageUrl,
      pdfUrl: entity.pdfUrl,
      audioUrl: entity.audioUrl,
      totalVerses: entity.totalVerses,
      format: entity.format,
      isFeatured: entity.isFeatured,
      rating: entity.rating,
      viewsCount: entity.viewsCount,
    );
  }
}
