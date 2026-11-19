import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/bloc/theme_cubit.dart';
import '../../../../core/theme/bloc/theme_state.dart';
import '../../domain/entities/verse_entity.dart';
import '../bloc/structured_reader/structured_reader_bloc.dart';
import '../bloc/structured_reader/structured_reader_event.dart';
import '../bloc/structured_reader/structured_reader_state.dart';
import '../widgets/audio_sync_bottom_sheet.dart';
import '../widgets/reader_settings_dialog.dart';
import '../widgets/verse_view_card.dart';

class StructuredVerseReaderPage extends StatefulWidget {
  final String bookId;
  final int initialChapter;

  const StructuredVerseReaderPage({
    super.key,
    required this.bookId,
    this.initialChapter = 2,
  });

  @override
  State<StructuredVerseReaderPage> createState() =>
      _StructuredVerseReaderPageState();
}

class _StructuredVerseReaderPageState extends State<StructuredVerseReaderPage> {
  final ScrollController _scrollController = ScrollController();
  bool _showAudioPlayer = false;
  bool _isPlayingAudio = false;
  Duration _audioPosition = Duration.zero;
  final Duration _audioDuration = const Duration(minutes: 5, seconds: 30);

  @override
  void initState() {
    super.initState();
    context.read<StructuredReaderBloc>().add(
          LoadChapterVersesEvent(
            bookId: widget.bookId,
            chapterNumber: widget.initialChapter,
          ),
        );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (BuildContext context, ThemeState themeState) {
        return Scaffold(
          appBar: AppBar(
            title: Text('অধ্যায় ${widget.initialChapter}: সাংখ্যযোগ'),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  _showAudioPlayer ? Icons.headphones : Icons.headphones_outlined,
                  color: _showAudioPlayer ? AppColors.saffronPrimary : null,
                ),
                tooltip: 'অডিও সুললিত আবৃত্তি',
                onPressed: () {
                  setState(() {
                    _showAudioPlayer = !_showAudioPlayer;
                  });
                },
              ),
              IconButton(
                icon: const Icon(Icons.tune_rounded),
                tooltip: 'পঠন পছন্দসমূহ',
                onPressed: () => showDialog<void>(
                  context: context,
                  builder: (BuildContext ctx) => const ReaderSettingsDialog(),
                ),
              ),
            ],
          ),
          bottomSheet: _showAudioPlayer
              ? AudioSyncBottomSheet(
                  isPlaying: _isPlayingAudio,
                  position: _audioPosition,
                  duration: _audioDuration,
                  title: 'শ্রীমদ্ভগবদ্গীতা — অধ্যায় ${widget.initialChapter} সুললিত আবৃত্তি',
                  onPlayPause: () {
                    setState(() {
                      _isPlayingAudio = !_isPlayingAudio;
                    });
                  },
                  onSeek: (Duration newPos) {
                    setState(() {
                      _audioPosition = newPos;
                    });
                    context.read<StructuredReaderBloc>().add(
                          UpdateActiveAudioTimestampEvent(
                            newPos.inMilliseconds,
                          ),
                        );
                  },
                )
              : null,
          body: BlocBuilder<StructuredReaderBloc, StructuredReaderState>(
            builder: (BuildContext context, StructuredReaderState state) {
              if (state.status == ReaderStatus.loading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.saffronPrimary,
                  ),
                );
              }

              if (state.status == ReaderStatus.error) {
                return Center(
                  child: Text(state.errorMessage ?? 'শ্লোকসমূহ লোড করা সম্ভব হয়নি।'),
                );
              }

              return ListView.builder(
                controller: _scrollController,
                padding: EdgeInsets.only(
                  top: 10,
                  bottom: _showAudioPlayer ? 100 : 24,
                ),
                itemCount: state.verses.length,
                itemBuilder: (BuildContext context, int index) {
                  final VerseEntity verse = state.verses[index];
                  final bool isActive = state.activeVerseIndex == index;
                  final bool isSpeaking = state.isTtsPlaying &&
                      state.currentlySpeakingVerseIndex == index;

                  return VerseViewCard(
                    verse: verse,
                    isActive: isActive,
                    isSpeaking: isSpeaking,
                    fontScale: themeState.fontScale,
                    showTransliteration: themeState.showTransliteration,
                    showCommentary: themeState.showCommentary,
                    onSelect: () {
                      context
                          .read<StructuredReaderBloc>()
                          .add(SelectVerseEvent(index));
                    },
                    onPlayTts: () {
                      if (isSpeaking) {
                        context
                            .read<StructuredReaderBloc>()
                            .add(StopTtsEvent());
                      } else {
                        context
                            .read<StructuredReaderBloc>()
                            .add(PlayVerseTtsEvent(verseIndex: index));
                      }
                    },
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
