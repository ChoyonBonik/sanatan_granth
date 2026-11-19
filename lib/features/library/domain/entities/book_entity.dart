import 'package:equatable/equatable.dart';

enum BookCategory {
  veda('Veda'),
  upanishad('Upanishad'),
  itihasa('Itihasa'),
  purana('Purana'),
  stotra('Stotra'),
  gita('Gita');

  final String value;
  const BookCategory(this.value);

  static BookCategory fromString(String val) {
    return BookCategory.values.firstWhere(
      (BookCategory c) => c.value.toLowerCase() == val.trim().toLowerCase(),
      orElse: () => BookCategory.gita,
    );
  }
}

enum BookFormatType {
  structured('structured'),
  pdf('pdf'),
  epub('epub');

  final String value;
  const BookFormatType(this.value);

  static BookFormatType fromString(String val) {
    return BookFormatType.values.firstWhere(
      (BookFormatType f) => f.value.toLowerCase() == val.trim().toLowerCase(),
      orElse: () => BookFormatType.structured,
    );
  }
}

// Backward-compatible alias
typedef BookFormat = BookFormatType;

enum BookSubmissionStatus {
  pending('pending'),
  approved('approved'),
  rejected('rejected');

  final String value;
  const BookSubmissionStatus(this.value);

  static BookSubmissionStatus fromString(String val) {
    return BookSubmissionStatus.values.firstWhere(
      (BookSubmissionStatus s) => s.value.toLowerCase() == val.trim().toLowerCase(),
      orElse: () => BookSubmissionStatus.pending,
    );
  }
}

class BookEntity extends Equatable {
  final String id;
  final String title;
  final String? subtitle;
  final String authorRishi;
  final BookCategory categoryType;
  final String categoryName;
  final String language;
  final BookFormatType formatType;
  final String? fileUrl;
  final String? coverUrl;
  final BookSubmissionStatus status;
  final String? contributorId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  // Compatibility fields for existing UI components
  final String? sanskritTitle;
  final String description;
  final int totalVerses;
  final bool isFeatured;
  final double rating;
  final int viewsCount;

  const BookEntity({
    required this.id,
    required this.title,
    this.subtitle,
    String? authorRishi,
    String? author,
    this.categoryType = BookCategory.gita,
    String? category,
    this.language = 'Bengali',
    BookFormatType? formatType,
    BookFormatType? format,
    String? fileUrl,
    String? pdfUrl,
    String? coverUrl,
    String? coverImageUrl,
    this.status = BookSubmissionStatus.pending,
    this.contributorId,
    this.createdAt,
    this.updatedAt,
    this.sanskritTitle,
    this.description = '',
    this.totalVerses = 0,
    this.isFeatured = false,
    this.rating = 5.0,
    this.viewsCount = 0,
  })  : authorRishi = authorRishi ?? author ?? '',
        categoryName = category ?? 'Gita',
        formatType = formatType ?? format ?? BookFormatType.structured,
        fileUrl = fileUrl ?? pdfUrl,
        coverUrl = coverUrl ?? coverImageUrl;

  // Backward compatibility getters
  String get author => authorRishi;
  String get category => categoryName;
  BookFormatType get format => formatType;
  String? get coverImageUrl => coverUrl;
  String? get pdfUrl => fileUrl;
  String? get audioUrl => null;

  @override
  List<Object?> get props => <Object?>[
        id,
        title,
        subtitle,
        authorRishi,
        categoryType,
        categoryName,
        language,
        formatType,
        fileUrl,
        coverUrl,
        status,
        contributorId,
        createdAt,
        updatedAt,
        sanskritTitle,
        description,
        totalVerses,
        isFeatured,
        rating,
        viewsCount,
      ];
}
