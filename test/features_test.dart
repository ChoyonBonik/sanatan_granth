import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sanatan_granth/features/auth/data/models/user_model.dart';
import 'package:sanatan_granth/features/auth/domain/entities/user_entity.dart';
import 'package:sanatan_granth/features/library/data/datasources/library_remote_data_source.dart';
import 'package:sanatan_granth/features/library/data/models/book_model.dart';
import 'package:sanatan_granth/features/library/data/models/category_model.dart';
import 'package:sanatan_granth/features/library/data/models/chapter_model.dart';
import 'package:sanatan_granth/features/library/data/models/reading_progress_model.dart';
import 'package:sanatan_granth/features/library/domain/entities/book_entity.dart';
import 'package:sanatan_granth/features/library/presentation/widgets/continue_reading_card.dart';

void main() {
  group('Auth Feature Tests', () {
    test('UserEntity.guest() creates frictionless guest user', () {
      final UserEntity guest = UserEntity.guest();
      expect(guest.isGuest, isTrue);
      expect(guest.displayName, 'Guest Devotee');
    });

    test('UserModel.guest() creates valid guest model with serializability', () {
      final UserModel guest = UserModel.guest();
      expect(guest.isGuest, isTrue);
      final json = guest.toJson();
      expect(json['is_guest'], isTrue);
      final fromJson = UserModel.fromJson(json);
      expect(fromJson.isGuest, isTrue);
    });
  });

  group('Library Feature Tests', () {
    final LibraryRemoteDataSource dataSource = LibraryRemoteDataSourceImpl();

    test('getCategories returns required sacred scripture categories', () async {
      final List<CategoryModel> categories = await dataSource.getCategories();
      expect(categories, isNotEmpty);
      final List<String> names = categories.map((CategoryModel c) => c.name).toList();
      expect(names, contains('All'));
      expect(names, contains('Gita'));
      expect(names, contains('Upanishads'));
      expect(names, contains('Vedas'));
      expect(names, contains('Puranas'));
      expect(names, contains('Itihasa'));
      expect(names, contains('Stotras'));
    });

    test('getBooks filters by Category properly', () async {
      final List<BookModel> gitaBooks = await dataSource.getBooks(category: 'Gita');
      expect(gitaBooks, isNotEmpty);
      expect(gitaBooks.every((BookModel b) => b.category == 'Gita'), isTrue);

      final List<BookModel> upanishads = await dataSource.getBooks(category: 'Upanishads');
      expect(upanishads, isNotEmpty);
      expect(upanishads.any((BookModel b) => b.id == 'isha-upanishad'), isTrue);
    });

    test('getChapters returns structured chapter list for Bhagavad Gita', () async {
      final List<ChapterModel> chapters = await dataSource.getChapters('gita-as-it-is');
      expect(chapters.length, 18);
      expect(chapters.first.chapterNumber, 1);
      expect(chapters.first.title, contains('প্রথম অধ্যায়'));
    });

    test('getReadingProgress returns non-null progress for continue reading card', () async {
      final ReadingProgressModel? progress = await dataSource.getReadingProgress('test_user');
      expect(progress, isNotNull);
      expect(progress!.bookId, 'gita-as-it-is');
      expect(progress.lastVerseOrPage, 5);
    });

    test('searchBooks finds books by Bengali title and verse text', () async {
      final List<BookModel> titleResults = await dataSource.searchBooks('গীতা');
      expect(titleResults, isNotEmpty);

      final List<BookModel> verseResults = await dataSource.searchBooks('ধর্মক্ষেত্রে');
      expect(verseResults, isNotEmpty);
      expect(verseResults.first.id, 'gita-as-it-is');

      // Test format filtering
      final List<BookModel> pdfResults = await dataSource.searchBooks(
        '',
        format: BookFormatType.pdf,
      );
      expect(pdfResults.every((BookModel b) => b.format == BookFormatType.pdf), isTrue);
    });

    testWidgets('ContinueReadingCard renders correctly without overflow', (WidgetTester tester) async {
      const BookEntity testBook = BookEntity(
        id: 'gita-as-it-is',
        title: 'শ্রীমদ্ভগবদ্গীতা যথার্থরূপ',
        author: 'শ্রীকৃষ্ণদ্বৈপায়ন বেদব্যাস',
        category: 'Gita',
        totalVerses: 700,
      );

      final ReadingProgressModel testProgress = ReadingProgressModel(
        id: 'prog-1',
        userId: 'guest',
        bookId: 'gita-as-it-is',
        lastVerseOrPage: 12,
        updatedAt: DateTime.now(),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ContinueReadingCard(
              book: testBook,
              progress: testProgress,
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text('CONTINUE READING / LISTENING'), findsOneWidget);
      expect(find.text('শ্রীমদ্ভগবদ্গীতা যথার্থরূপ'), findsOneWidget);
      expect(find.text('Resume'), findsOneWidget);
    });
  });
}
