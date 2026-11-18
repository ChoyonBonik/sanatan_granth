import 'package:equatable/equatable.dart';

class VerseEntity extends Equatable {
  final String id;
  final String bookId;
  final int chapterNumber;
  final int verseNumber;
  final String originalScriptText;
  final String scriptType; // 'devanagari', 'bengali', 'iast'
  final String? transliteration;
  final String? wordMeanings;
  final String translation;
  final String? commentary;
  final int? audioTimestampStartMs;
  final int? audioTimestampEndMs;

  const VerseEntity({
    required this.id,
    required this.bookId,
    required this.chapterNumber,
    required this.verseNumber,
    required this.originalScriptText,
    this.scriptType = 'devanagari',
    this.transliteration,
    this.wordMeanings,
    required this.translation,
    this.commentary,
    this.audioTimestampStartMs,
    this.audioTimestampEndMs,
  });

  @override
  List<Object?> get props => <Object?>[
        id,
        bookId,
        chapterNumber,
        verseNumber,
        originalScriptText,
        scriptType,
        transliteration,
        wordMeanings,
        translation,
        commentary,
        audioTimestampStartMs,
        audioTimestampEndMs,
      ];
}
