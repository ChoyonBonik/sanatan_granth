import 'package:equatable/equatable.dart';

class ChapterEntity extends Equatable {
  final String id;
  final String bookId;
  final int chapterNumber;
  final String title;
  final String? audioUrl;
  final int durationSeconds;
  final DateTime? createdAt;

  const ChapterEntity({
    required this.id,
    required this.bookId,
    required this.chapterNumber,
    required this.title,
    this.audioUrl,
    this.durationSeconds = 0,
    this.createdAt,
  });

  @override
  List<Object?> get props => <Object?>[
        id,
        bookId,
        chapterNumber,
        title,
        audioUrl,
        durationSeconds,
        createdAt,
      ];
}
