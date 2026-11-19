import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sanatan_granth/core/theme/app_theme.dart';
import 'package:sanatan_granth/core/theme/bloc/theme_cubit.dart';
import 'package:sanatan_granth/features/library/domain/entities/book_entity.dart';
import 'package:sanatan_granth/features/library/presentation/widgets/book_card.dart';
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

    testWidgets('BookCard renders without overflow in grid', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(960, 1920); // 320 x 640 logical dp (extra small phone)
      tester.view.devicePixelRatio = 3.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      const BookEntity testBook = BookEntity(
        id: 'gita-as-it-is',
        title: 'শ্রীমদ্ভগবদ্গীতা যথার্থরূপ পরম তত্ত্ববাণী',
        sanskritTitle: 'শ্রীমদ্ভগবদ্গীতা উপনিষদ',
        author: 'শ্রীল কৃষ্ণদ্বৈপায়ন বেদব্যাস গোস্বামী',
        category: 'Chaitanya Charitamrita',
        description: 'কুরুক্ষেত্রের পুণ্য ধর্মক্ষেত্রে...',
        language: 'সংস্কৃত ও বঙ্গানুবাদ',
        totalVerses: 18000,
        format: BookFormat.structured,
        isFeatured: true,
        rating: 5.0,
        viewsCount: 18500,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 0.58,
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
              padding: const EdgeInsets.all(16),
              children: <Widget>[
                BookCard(book: testBook, onTap: () {}),
              ],
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
    });
  });
}
