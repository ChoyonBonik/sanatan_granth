import 'package:equatable/equatable.dart';

enum BookFormat { structured, pdf, epub }

class BookEntity extends Equatable {
  final String id;
  final String title;
  final String? sanskritTitle;
  final String author;
  final String category;
  final String description;
  final String language;
  final String? coverImageUrl;
  final String? pdfUrl;
  final String? audioUrl;
  final int totalVerses;
  final BookFormat format;
  final bool isFeatured;
  final double rating;
  final int viewsCount;

  const BookEntity({
    required this.id,
    required this.title,
    this.sanskritTitle,
    required this.author,
    required this.category,
    required this.description,
    required this.language,
    this.coverImageUrl,
    this.pdfUrl,
    this.audioUrl,
    this.totalVerses = 0,
    this.format = BookFormat.structured,
    this.isFeatured = false,
    this.rating = 5.0,
    this.viewsCount = 0,
  });

  @override
  List<Object?> get props => <Object?>[
        id,
        title,
        sanskritTitle,
        author,
        category,
        description,
        language,
        coverImageUrl,
        pdfUrl,
        audioUrl,
        totalVerses,
        format,
        isFeatured,
        rating,
        viewsCount,
      ];
}
