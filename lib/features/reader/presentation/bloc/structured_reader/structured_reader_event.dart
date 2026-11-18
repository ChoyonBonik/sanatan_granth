import 'package:equatable/equatable.dart';

abstract class StructuredReaderEvent extends Equatable {
  const StructuredReaderEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class LoadChapterVersesEvent extends StructuredReaderEvent {
  final String bookId;
  final int chapterNumber;

  const LoadChapterVersesEvent({
    required this.bookId,
    required this.chapterNumber,
  });

  @override
  List<Object?> get props => <Object?>[bookId, chapterNumber];
}

class SelectVerseEvent extends StructuredReaderEvent {
  final int verseIndex;

  const SelectVerseEvent(this.verseIndex);

  @override
  List<Object?> get props => <Object?>[verseIndex];
}

class PlayVerseTtsEvent extends StructuredReaderEvent {
  final int verseIndex;
  final bool speakTranslation;

  const PlayVerseTtsEvent({
    required this.verseIndex,
    this.speakTranslation = false,
  });

  @override
  List<Object?> get props => <Object?>[verseIndex, speakTranslation];
}

class StopTtsEvent extends StructuredReaderEvent {}

class UpdateActiveAudioTimestampEvent extends StructuredReaderEvent {
  final int positionMs;

  const UpdateActiveAudioTimestampEvent(this.positionMs);

  @override
  List<Object?> get props => <Object?>[positionMs];
}
