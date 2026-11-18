import 'package:equatable/equatable.dart';
import '../app_theme.dart';

class ThemeState extends Equatable {
  final AppThemeMode themeMode;
  final double fontScale;
  final bool showTransliteration;
  final bool showCommentary;
  final bool autoHighlightAudio;

  const ThemeState({
    required this.themeMode,
    this.fontScale = 1.0,
    this.showTransliteration = true,
    this.showCommentary = true,
    this.autoHighlightAudio = true,
  });

  ThemeState copyWith({
    AppThemeMode? themeMode,
    double? fontScale,
    bool? showTransliteration,
    bool? showCommentary,
    bool? autoHighlightAudio,
  }) {
    return ThemeState(
      themeMode: themeMode ?? this.themeMode,
      fontScale: fontScale ?? this.fontScale,
      showTransliteration: showTransliteration ?? this.showTransliteration,
      showCommentary: showCommentary ?? this.showCommentary,
      autoHighlightAudio: autoHighlightAudio ?? this.autoHighlightAudio,
    );
  }

  @override
  List<Object?> get props => <Object?>[
        themeMode,
        fontScale,
        showTransliteration,
        showCommentary,
        autoHighlightAudio,
      ];
}
