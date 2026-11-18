import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../app_theme.dart';
import 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  static const String _themeModeKey = 'app_theme_mode';
  static const String _fontScaleKey = 'app_font_scale';
  static const String _showTransliterationKey = 'show_transliteration';
  static const String _showCommentaryKey = 'show_commentary';
  static const String _autoHighlightKey = 'auto_highlight_audio';

  final SharedPreferences? _prefs;

  ThemeCubit({SharedPreferences? prefs})
      : _prefs = prefs,
        super(const ThemeState(themeMode: AppThemeMode.sepia)) {
    _loadFromPreferences();
  }

  void _loadFromPreferences() {
    if (_prefs == null) return;

    final String? savedMode = _prefs.getString(_themeModeKey);
    final double savedScale = _prefs.getDouble(_fontScaleKey) ?? 1.0;
    final bool showTrans = _prefs.getBool(_showTransliterationKey) ?? true;
    final bool showComm = _prefs.getBool(_showCommentaryKey) ?? true;
    final bool autoHighlight = _prefs.getBool(_autoHighlightKey) ?? true;

    AppThemeMode mode = AppThemeMode.sepia;
    if (savedMode != null) {
      mode = AppThemeMode.values.firstWhere(
        (AppThemeMode m) => m.name == savedMode,
        orElse: () => AppThemeMode.sepia,
      );
    }

    emit(state.copyWith(
      themeMode: mode,
      fontScale: savedScale,
      showTransliteration: showTrans,
      showCommentary: showComm,
      autoHighlightAudio: autoHighlight,
    ));
  }

  Future<void> setThemeMode(AppThemeMode mode) async {
    emit(state.copyWith(themeMode: mode));
    await _prefs?.setString(_themeModeKey, mode.name);
  }

  Future<void> setFontScale(double scale) async {
    emit(state.copyWith(fontScale: scale.clamp(0.8, 1.8)));
    await _prefs?.setDouble(_fontScaleKey, scale);
  }

  Future<void> toggleTransliteration() async {
    final bool updated = !state.showTransliteration;
    emit(state.copyWith(showTransliteration: updated));
    await _prefs?.setBool(_showTransliterationKey, updated);
  }

  Future<void> toggleCommentary() async {
    final bool updated = !state.showCommentary;
    emit(state.copyWith(showCommentary: updated));
    await _prefs?.setBool(_showCommentaryKey, updated);
  }

  Future<void> toggleAudioHighlight() async {
    final bool updated = !state.autoHighlightAudio;
    emit(state.copyWith(autoHighlightAudio: updated));
    await _prefs?.setBool(_autoHighlightKey, updated);
  }
}
