import 'package:equatable/equatable.dart';

class BookmarkEntity extends Equatable {
  final String id;
  final String userId;
  final String bookId;
  final String? chapterId;
  final int verseOrPage;
  final String? note;
  final DateTime createdAt;

  const BookmarkEntity({
    required this.id,
    required this.userId,
    required this.bookId,
    this.chapterId,
    required this.verseOrPage,
    this.note,
    required this.createdAt,
  });

  @override
  List<Object?> get props => <Object?>[
        id,
        userId,
        bookId,
        chapterId,
        verseOrPage,
        note,
        createdAt,
      ];
}
