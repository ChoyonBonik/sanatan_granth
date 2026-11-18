import 'package:flutter_test/flutter_test.dart';
import 'package:sanatan_granth/core/theme/app_theme.dart';
import 'package:sanatan_granth/core/theme/bloc/theme_cubit.dart';
import 'package:sanatan_granth/features/reader/domain/entities/verse_entity.dart';

void main() {
  group('Sanatan Granth Core & Architecture Tests', () {
    test('ThemeCubit initial state should default to sepia mode', () {
      final ThemeCubit themeCubit = ThemeCubit();
      expect(themeCubit.state.themeMode, AppThemeMode.sepia);
      expect(themeCubit.state.fontScale, 1.0);
    });

    test('ThemeCubit changes theme mode to AMOLED Dark', () async {
      final ThemeCubit themeCubit = ThemeCubit();
      await themeCubit.setThemeMode(AppThemeMode.amoledDark);
      expect(themeCubit.state.themeMode, AppThemeMode.amoledDark);
    });

    test('VerseEntity value equality check', () {
      const VerseEntity verse1 = VerseEntity(
        id: 'gita-2-47',
        bookId: 'gita',
        chapterNumber: 2,
        verseNumber: 47,
        originalScriptText: 'कर्मण्येवाधिकारस्ते...',
        translation: 'You have a right to perform your prescribed duty...',
      );

      const VerseEntity verse2 = VerseEntity(
        id: 'gita-2-47',
        bookId: 'gita',
        chapterNumber: 2,
        verseNumber: 47,
        originalScriptText: 'कर्मण्येवाधिकारस्ते...',
        translation: 'You have a right to perform your prescribed duty...',
      );

      expect(verse1, equals(verse2));
    });
  });
}
