import '../../domain/entities/reading_progress_entity.dart';

class ReadingProgressModel extends ReadingProgressEntity {
  const ReadingProgressModel({
    required super.id,
    required super.userId,
    required super.bookId,
    super.chapterId,
    super.lastVerseOrPage = 1,
    super.audioPositionMs = 0,
    required super.updatedAt,
  });

  factory ReadingProgressModel.fromJson(Map<String, dynamic> json) {
    return ReadingProgressModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      bookId: json['book_id'] as String,
      chapterId: json['chapter_id'] as String?,
      lastVerseOrPage: (json['last_verse_or_page'] as num?)?.toInt() ?? 1,
      audioPositionMs: (json['audio_position_ms'] as num?)?.toInt() ?? 0,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'] as String) ?? DateTime.now()
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'user_id': userId,
      'book_id': bookId,
      'chapter_id': chapterId,
      'last_verse_or_page': lastVerseOrPage,
      'audio_position_ms': audioPositionMs,
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory ReadingProgressModel.fromEntity(ReadingProgressEntity entity) {
    return ReadingProgressModel(
      id: entity.id,
      userId: entity.userId,
      bookId: entity.bookId,
      chapterId: entity.chapterId,
      lastVerseOrPage: entity.lastVerseOrPage,
      audioPositionMs: entity.audioPositionMs,
      updatedAt: entity.updatedAt,
    );
  }
}
