import 'package:equatable/equatable.dart';

class VerseEntity extends Equatable {
  final String id;
  final String chapterId;
  final String? bookId;
  final int chapterNumber;
  final int verseNumber;
  final String originalScript;
  final String? transliteration;
  final String translation;
  final String? commentary;
  final int? audioStartMs;
  final int? audioEndMs;
  final DateTime? createdAt;

  const VerseEntity({
    required this.id,
    required this.chapterId,
    this.bookId,
    this.chapterNumber = 1,
    required this.verseNumber,
    required this.originalScript,
    this.transliteration,
    required this.translation,
    this.commentary,
    this.audioStartMs,
    this.audioEndMs,
    this.createdAt,
  });

  // Backward compatibility getters for reader components
  String get originalScriptText => originalScript;
  String? get wordMeanings => commentary;
  int? get audioTimestampStartMs => audioStartMs;
  int? get audioTimestampEndMs => audioEndMs;

  @override
  List<Object?> get props => <Object?>[
        id,
        chapterId,
        bookId,
        chapterNumber,
        verseNumber,
        originalScript,
        transliteration,
        translation,
        commentary,
        audioStartMs,
        audioEndMs,
        createdAt,
      ];
}
