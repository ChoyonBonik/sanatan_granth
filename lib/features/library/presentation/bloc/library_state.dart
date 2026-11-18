import 'package:equatable/equatable.dart';
import '../../domain/entities/book_entity.dart';
import '../../domain/entities/category_entity.dart';

enum LibraryStatus { initial, loading, loaded, searching, searchLoaded, error }

class LibraryState extends Equatable {
  final LibraryStatus status;
  final List<CategoryEntity> categories;
  final List<BookEntity> books;
  final List<BookEntity> featuredBooks;
  final List<BookEntity> searchResults;
  final String selectedCategory;
  final String searchQuery;
  final BookEntity? selectedBook;
  final String? errorMessage;

  const LibraryState({
    this.status = LibraryStatus.initial,
    this.categories = const <CategoryEntity>[],
    this.books = const <BookEntity>[],
    this.featuredBooks = const <BookEntity>[],
    this.searchResults = const <BookEntity>[],
    this.selectedCategory = 'All',
    this.searchQuery = '',
    this.selectedBook,
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
    BookEntity? selectedBook,
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
      selectedBook: selectedBook ?? this.selectedBook,
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
        selectedBook,
        errorMessage,
      ];
}
