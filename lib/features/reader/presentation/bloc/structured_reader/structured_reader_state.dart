import 'package:equatable/equatable.dart';
import 'package:sanatan_granth/features/reader/domain/entities/verse_entity.dart';

enum ReaderStatus { initial, loading, loaded, error }

class StructuredReaderState extends Equatable {
  final ReaderStatus status;
  final String bookId;
  final int chapterNumber;
  final List<VerseEntity> verses;
  final int? activeVerseIndex;
  final bool isTtsPlaying;
  final int? currentlySpeakingVerseIndex;
  final String? audioUrl;
  final String? errorMessage;

  const StructuredReaderState({
    this.status = ReaderStatus.initial,
    this.bookId = '',
    this.chapterNumber = 1,
    this.verses = const <VerseEntity>[],
    this.activeVerseIndex,
    this.isTtsPlaying = false,
    this.currentlySpeakingVerseIndex,
    this.audioUrl,
    this.errorMessage,
  });

  StructuredReaderState copyWith({
    ReaderStatus? status,
    String? bookId,
    int? chapterNumber,
    List<VerseEntity>? verses,
    int? activeVerseIndex,
    bool? isTtsPlaying,
    int? currentlySpeakingVerseIndex,
    String? audioUrl,
    String? errorMessage,
  }) {
    return StructuredReaderState(
      status: status ?? this.status,
      bookId: bookId ?? this.bookId,
      chapterNumber: chapterNumber ?? this.chapterNumber,
      verses: verses ?? this.verses,
      activeVerseIndex: activeVerseIndex ?? this.activeVerseIndex,
      isTtsPlaying: isTtsPlaying ?? this.isTtsPlaying,
      currentlySpeakingVerseIndex:
          currentlySpeakingVerseIndex ?? this.currentlySpeakingVerseIndex,
      audioUrl: audioUrl ?? this.audioUrl,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => <Object?>[
        status,
        bookId,
        chapterNumber,
        verses,
        activeVerseIndex,
        isTtsPlaying,
        currentlySpeakingVerseIndex,
        audioUrl,
        errorMessage,
      ];
}
