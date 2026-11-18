import '../../domain/entities/verse_entity.dart';

class VerseModel extends VerseEntity {
  const VerseModel({
    required super.id,
    required super.bookId,
    required super.chapterNumber,
    required super.verseNumber,
    required super.originalScriptText,
    super.scriptType = 'devanagari',
    super.transliteration,
    super.wordMeanings,
    required super.translation,
    super.commentary,
    super.audioTimestampStartMs,
    super.audioTimestampEndMs,
  });

  factory VerseModel.fromJson(Map<String, dynamic> json) {
    return VerseModel(
      id: json['id'] as String,
      bookId: json['book_id'] as String,
      chapterNumber: (json['chapter_number'] as num).toInt(),
      verseNumber: (json['verse_number'] as num).toInt(),
      originalScriptText: json['original_script_text'] as String,
      scriptType: json['script_type'] as String? ?? 'devanagari',
      transliteration: json['transliteration'] as String?,
      wordMeanings: json['word_meanings'] as String?,
      translation: json['translation'] as String,
      commentary: json['commentary'] as String?,
      audioTimestampStartMs: (json['audio_timestamp_start_ms'] as num?)?.toInt(),
      audioTimestampEndMs: (json['audio_timestamp_end_ms'] as num?)?.toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'book_id': bookId,
      'chapter_number': chapterNumber,
      'verse_number': verseNumber,
      'original_script_text': originalScriptText,
      'script_type': scriptType,
      'transliteration': transliteration,
      'word_meanings': wordMeanings,
      'translation': translation,
      'commentary': commentary,
      'audio_timestamp_start_ms': audioTimestampStartMs,
      'audio_timestamp_end_ms': audioTimestampEndMs,
    };
  }
}
