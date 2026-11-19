import '../../domain/entities/bookmark_entity.dart';

class BookmarkModel extends BookmarkEntity {
  const BookmarkModel({
    required super.id,
    required super.userId,
    required super.bookId,
    super.chapterId,
    required super.verseOrPage,
    super.note,
    required super.createdAt,
  });

  factory BookmarkModel.fromJson(Map<String, dynamic> json) {
    return BookmarkModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      bookId: json['book_id'] as String,
      chapterId: json['chapter_id'] as String?,
      verseOrPage: (json['verse_or_page'] as num?)?.toInt() ?? 1,
      note: json['note'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'] as String) ?? DateTime.now()
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'user_id': userId,
      'book_id': bookId,
      'chapter_id': chapterId,
      'verse_or_page': verseOrPage,
      'note': note,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory BookmarkModel.fromEntity(BookmarkEntity entity) {
    return BookmarkModel(
      id: entity.id,
      userId: entity.userId,
      bookId: entity.bookId,
      chapterId: entity.chapterId,
      verseOrPage: entity.verseOrPage,
      note: entity.note,
      createdAt: entity.createdAt,
    );
  }
}
