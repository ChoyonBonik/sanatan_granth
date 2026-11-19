import '../../domain/entities/chapter_entity.dart';

class ChapterModel extends ChapterEntity {
  const ChapterModel({
    required super.id,
    required super.bookId,
    required super.chapterNumber,
    required super.title,
    super.audioUrl,
    super.durationSeconds = 0,
    super.createdAt,
  });

  factory ChapterModel.fromJson(Map<String, dynamic> json) {
    return ChapterModel(
      id: json['id'] as String,
      bookId: json['book_id'] as String,
      chapterNumber: (json['chapter_number'] as num?)?.toInt() ?? 1,
      title: json['title'] as String? ?? '',
      audioUrl: json['audio_url'] as String?,
      durationSeconds: (json['duration_seconds'] as num?)?.toInt() ?? 0,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'book_id': bookId,
      'chapter_number': chapterNumber,
      'title': title,
      'audio_url': audioUrl,
      'duration_seconds': durationSeconds,
      if (createdAt != null) 'created_at': createdAt!.toIso8601String(),
    };
  }

  factory ChapterModel.fromEntity(ChapterEntity entity) {
    return ChapterModel(
      id: entity.id,
      bookId: entity.bookId,
      chapterNumber: entity.chapterNumber,
      title: entity.title,
      audioUrl: entity.audioUrl,
      durationSeconds: entity.durationSeconds,
      createdAt: entity.createdAt,
    );
  }
}
