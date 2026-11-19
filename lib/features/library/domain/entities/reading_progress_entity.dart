import 'package:equatable/equatable.dart';

class ReadingProgressEntity extends Equatable {
  final String id;
  final String userId;
  final String bookId;
  final String? chapterId;
  final int lastVerseOrPage;
  final int audioPositionMs;
  final DateTime updatedAt;

  const ReadingProgressEntity({
    required this.id,
    required this.userId,
    required this.bookId,
    this.chapterId,
    this.lastVerseOrPage = 1,
    this.audioPositionMs = 0,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => <Object?>[
        id,
        userId,
        bookId,
        chapterId,
        lastVerseOrPage,
        audioPositionMs,
        updatedAt,
      ];
}
