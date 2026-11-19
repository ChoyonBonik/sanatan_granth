import '../../domain/entities/verse_entity.dart';

class VerseModel extends VerseEntity {
  const VerseModel({
    required super.id,
    required super.chapterId,
    super.bookId,
    super.chapterNumber = 1,
    required super.verseNumber,
    required super.originalScript,
    super.transliteration,
    required super.translation,
    super.commentary,
    super.audioStartMs,
    super.audioEndMs,
    super.createdAt,
  });

  factory VerseModel.fromJson(Map<String, dynamic> json) {
    final dynamic audioStart = json['audio_start_ms'] ?? json['audio_timestamp_start_ms'];
    final dynamic audioEnd = json['audio_end_ms'] ?? json['audio_timestamp_end_ms'];

    return VerseModel(
      id: json['id'] as String,
      chapterId: json['chapter_id'] as String? ?? '',
      bookId: json['book_id'] as String?,
      chapterNumber: (json['chapter_number'] as num?)?.toInt() ?? 1,
      verseNumber: (json['verse_number'] as num?)?.toInt() ?? 1,
      originalScript: (json['original_script'] ?? json['original_script_text'] ?? '').toString(),
      transliteration: json['transliteration'] as String?,
      translation: json['translation'] as String? ?? '',
      commentary: (json['commentary'] ?? json['word_meanings']) as String?,
      audioStartMs: audioStart is num ? audioStart.toInt() : null,
      audioEndMs: audioEnd is num ? audioEnd.toInt() : null,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'chapter_id': chapterId,
      if (bookId != null) 'book_id': bookId,
      'chapter_number': chapterNumber,
      'verse_number': verseNumber,
      'original_script': originalScript,
      'transliteration': transliteration,
      'translation': translation,
      'commentary': commentary,
      'audio_start_ms': audioStartMs,
      'audio_end_ms': audioEndMs,
      if (createdAt != null) 'created_at': createdAt!.toIso8601String(),
    };
  }

  factory VerseModel.fromEntity(VerseEntity entity) {
    return VerseModel(
      id: entity.id,
      chapterId: entity.chapterId,
      bookId: entity.bookId,
      chapterNumber: entity.chapterNumber,
      verseNumber: entity.verseNumber,
      originalScript: entity.originalScript,
      transliteration: entity.transliteration,
      translation: entity.translation,
      commentary: entity.commentary,
      audioStartMs: entity.audioStartMs,
      audioEndMs: entity.audioEndMs,
      createdAt: entity.createdAt,
    );
  }
}
