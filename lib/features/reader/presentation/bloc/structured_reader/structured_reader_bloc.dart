import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sanatan_granth/features/reader/domain/entities/verse_entity.dart';
import 'package:sanatan_granth/features/reader/domain/usecases/get_structured_verses_usecase.dart';
import 'package:sanatan_granth/features/reader/services/tts_service.dart';
import 'structured_reader_event.dart';
import 'structured_reader_state.dart';

class StructuredReaderBloc
    extends Bloc<StructuredReaderEvent, StructuredReaderState> {
  final GetStructuredVersesUseCase getStructuredVersesUseCase;
  final TtsService ttsService;

  StructuredReaderBloc({
    required this.getStructuredVersesUseCase,
    required this.ttsService,
  }) : super(const StructuredReaderState()) {
    on<LoadChapterVersesEvent>(_onLoadChapterVerses);
    on<SelectVerseEvent>(_onSelectVerse);
    on<PlayVerseTtsEvent>(_onPlayVerseTts);
    on<StopTtsEvent>(_onStopTts);
    on<UpdateActiveAudioTimestampEvent>(_onUpdateAudioTimestamp);

    ttsService.setCompletionHandler(() {
      add(StopTtsEvent());
    });
  }

  Future<void> _onLoadChapterVerses(
    LoadChapterVersesEvent event,
    Emitter<StructuredReaderState> emit,
  ) async {
    emit(state.copyWith(
      status: ReaderStatus.loading,
      bookId: event.bookId,
      chapterNumber: event.chapterNumber,
    ));

    final result = await getStructuredVersesUseCase(
      bookId: event.bookId,
      chapter: event.chapterNumber,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        status: ReaderStatus.error,
        errorMessage: failure.message,
      )),
      (verses) => emit(state.copyWith(
        status: ReaderStatus.loaded,
        verses: verses,
        activeVerseIndex: verses.isNotEmpty ? 0 : null,
      )),
    );
  }

  void _onSelectVerse(
    SelectVerseEvent event,
    Emitter<StructuredReaderState> emit,
  ) {
    emit(state.copyWith(activeVerseIndex: event.verseIndex));
  }

  Future<void> _onPlayVerseTts(
    PlayVerseTtsEvent event,
    Emitter<StructuredReaderState> emit,
  ) async {
    if (event.verseIndex < 0 || event.verseIndex >= state.verses.length) return;

    final VerseEntity verse = state.verses[event.verseIndex];
    emit(state.copyWith(
      isTtsPlaying: true,
      currentlySpeakingVerseIndex: event.verseIndex,
      activeVerseIndex: event.verseIndex,
    ));

    final String textToSpeak = event.speakTranslation
        ? verse.translation
        : verse.originalScriptText;

    await ttsService.speak(
      text: textToSpeak,
      languageCode: event.speakTranslation ? 'en' : 'sa',
    );
  }

  Future<void> _onStopTts(
    StopTtsEvent event,
    Emitter<StructuredReaderState> emit,
  ) async {
    await ttsService.stop();
    emit(state.copyWith(
      isTtsPlaying: false,
      currentlySpeakingVerseIndex: null,
    ));
  }

  void _onUpdateAudioTimestamp(
    UpdateActiveAudioTimestampEvent event,
    Emitter<StructuredReaderState> emit,
  ) {
    // Find verse matching timestamp
    final int currentMs = event.positionMs;
    for (int i = 0; i < state.verses.length; i++) {
      final start = state.verses[i].audioTimestampStartMs;
      final end = state.verses[i].audioTimestampEndMs;
      if (start != null && end != null && currentMs >= start && currentMs <= end) {
        if (state.activeVerseIndex != i) {
          emit(state.copyWith(activeVerseIndex: i));
        }
        break;
      }
    }
  }

  @override
  Future<void> close() {
    ttsService.stop();
    return super.close();
  }
}
