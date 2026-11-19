import 'package:equatable/equatable.dart';
import '../../domain/entities/book_entity.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/entities/chapter_entity.dart';
import '../../domain/entities/reading_progress_entity.dart';

enum LibraryStatus { initial, loading, loaded, searching, searchLoaded, error }

class LibraryState extends Equatable {
  final LibraryStatus status;
  final List<CategoryEntity> categories;
  final List<BookEntity> books;
  final List<BookEntity> featuredBooks;
  final List<BookEntity> searchResults;
  final String selectedCategory;
  final String searchQuery;
  final String selectedLanguage;
  final BookFormatType? selectedFormat;
  final BookEntity? selectedBook;
  final List<ChapterEntity> bookChapters;
  final ReadingProgressEntity? readingProgress;
  final BookEntity? readingProgressBook;
  final String? errorMessage;

  const LibraryState({
    this.status = LibraryStatus.initial,
    this.categories = const <CategoryEntity>[],
    this.books = const <BookEntity>[],
    this.featuredBooks = const <BookEntity>[],
    this.searchResults = const <BookEntity>[],
    this.selectedCategory = 'All',
    this.searchQuery = '',
    this.selectedLanguage = 'All',
    this.selectedFormat,
    this.selectedBook,
    this.bookChapters = const <ChapterEntity>[],
    this.readingProgress,
    this.readingProgressBook,
    this.errorMessage,
  });

  LibraryState copyWith({
    LibraryStatus? status,
    List<CategoryEntity>? categories,
    List<BookEntity>? books,
    List<BookEntity>? featuredBooks,
    List<BookEntity>? searchResults,
    String? selectedCategory,
    String? searchQuery,
    String? selectedLanguage,
    BookFormatType? selectedFormat,
    bool clearFormat = false,
    BookEntity? selectedBook,
    List<ChapterEntity>? bookChapters,
    ReadingProgressEntity? readingProgress,
    BookEntity? readingProgressBook,
    String? errorMessage,
  }) {
    return LibraryState(
      status: status ?? this.status,
      categories: categories ?? this.categories,
      books: books ?? this.books,
      featuredBooks: featuredBooks ?? this.featuredBooks,
      searchResults: searchResults ?? this.searchResults,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
      selectedFormat: clearFormat ? null : (selectedFormat ?? this.selectedFormat),
      selectedBook: selectedBook ?? this.selectedBook,
      bookChapters: bookChapters ?? this.bookChapters,
      readingProgress: readingProgress ?? this.readingProgress,
      readingProgressBook: readingProgressBook ?? this.readingProgressBook,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => <Object?>[
        status,
        categories,
        books,
        featuredBooks,
        searchResults,
        selectedCategory,
        searchQuery,
        selectedLanguage,
        selectedFormat,
        selectedBook,
        bookChapters,
        readingProgress,
        readingProgressBook,
        errorMessage,
      ];
}
