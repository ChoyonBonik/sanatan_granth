import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/book_entity.dart';
import '../../domain/usecases/get_books_usecase.dart';
import '../../domain/usecases/get_categories_usecase.dart';
import '../../domain/usecases/get_book_details_usecase.dart';
import '../../domain/usecases/get_chapters_usecase.dart';
import '../../domain/usecases/get_reading_progress_usecase.dart';
import '../../domain/usecases/search_books_usecase.dart';
import 'library_event.dart';
import 'library_state.dart';

class LibraryBloc extends Bloc<LibraryEvent, LibraryState> {
  final GetCategoriesUseCase getCategoriesUseCase;
  final GetBooksUseCase getBooksUseCase;
  final SearchBooksUseCase searchBooksUseCase;
  final GetBookDetailsUseCase getBookDetailsUseCase;
  final GetChaptersUseCase getChaptersUseCase;
  final GetReadingProgressUseCase getReadingProgressUseCase;

  LibraryBloc({
    required this.getCategoriesUseCase,
    required this.getBooksUseCase,
    required this.searchBooksUseCase,
    required this.getBookDetailsUseCase,
    required this.getChaptersUseCase,
    required this.getReadingProgressUseCase,
  }) : super(const LibraryState()) {
    on<LoadLibraryCatalogEvent>(_onLoadCatalog);
    on<SelectCategoryFilterEvent>(_onSelectCategory);
    on<SearchQueryChangedEvent>(_onSearchQueryChanged);
    on<ClearSearchEvent>(_onClearSearch);
    on<LoadBookDetailsEvent>(_onLoadBookDetails);
    on<LoadReadingProgressEvent>(_onLoadReadingProgress);
  }

  Future<void> _onLoadCatalog(
    LoadLibraryCatalogEvent event,
    Emitter<LibraryState> emit,
  ) async {
    emit(state.copyWith(status: LibraryStatus.loading));

    final categoriesResult = await getCategoriesUseCase();
    final booksResult = await getBooksUseCase(category: event.category ?? state.selectedCategory);
    final progressResult = await getReadingProgressUseCase('default_user');

    categoriesResult.fold(
      (failure) => emit(state.copyWith(
        status: LibraryStatus.error,
        errorMessage: failure.message,
      )),
      (categories) {
        booksResult.fold(
          (failure) => emit(state.copyWith(
            status: LibraryStatus.error,
            categories: categories,
            errorMessage: failure.message,
          )),
          (books) {
            final featured = books.where((b) => b.isFeatured).toList();
            BookEntity? progressBook;

            progressResult.fold((_) {}, (prog) {
              if (prog != null) {
                progressBook = books.cast<BookEntity?>().firstWhere(
                      (BookEntity? b) => b?.id == prog.bookId,
                      orElse: () => null,
                    );
              }
            });

            // Default to Gita if no other progress
            progressBook ??= books.cast<BookEntity?>().firstWhere(
                  (BookEntity? b) => b?.id == 'gita-as-it-is',
                  orElse: () => books.isNotEmpty ? books.first : null,
                );

            emit(state.copyWith(
              status: LibraryStatus.loaded,
              categories: categories,
              books: books,
              featuredBooks: featured.isNotEmpty ? featured : books.take(3).toList(),
              readingProgress: progressResult.getOrElse(() => null),
              readingProgressBook: progressBook,
            ));
          },
        );
      },
    );
  }

  Future<void> _onSelectCategory(
    SelectCategoryFilterEvent event,
    Emitter<LibraryState> emit,
  ) async {
    emit(state.copyWith(
      selectedCategory: event.category,
      status: LibraryStatus.loading,
    ));

    final booksResult = await getBooksUseCase(category: event.category);
    booksResult.fold(
      (failure) => emit(state.copyWith(
        status: LibraryStatus.error,
        errorMessage: failure.message,
      )),
      (books) => emit(state.copyWith(
        status: LibraryStatus.loaded,
        books: books,
      )),
    );
  }

  Future<void> _onSearchQueryChanged(
    SearchQueryChangedEvent event,
    Emitter<LibraryState> emit,
  ) async {
    final String query = event.query;
    final String language = event.language ?? state.selectedLanguage;
    final BookFormatType? format = event.format ?? state.selectedFormat;

    if (query.trim().isEmpty && language == 'All' && format == null) {
      emit(state.copyWith(
        searchQuery: '',
        selectedLanguage: language,
        selectedFormat: format,
        searchResults: const <BookEntity>[],
        status: LibraryStatus.loaded,
      ));
      return;
    }

    emit(state.copyWith(
      searchQuery: query,
      selectedLanguage: language,
      selectedFormat: format,
      status: LibraryStatus.searching,
    ));

    final searchResult = await searchBooksUseCase(
      query,
      language: language,
      format: format,
    );

    searchResult.fold(
      (failure) => emit(state.copyWith(
        status: LibraryStatus.error,
        errorMessage: failure.message,
      )),
      (results) => emit(state.copyWith(
        status: LibraryStatus.searchLoaded,
        searchResults: results,
      )),
    );
  }

  void _onClearSearch(
    ClearSearchEvent event,
    Emitter<LibraryState> emit,
  ) {
    emit(state.copyWith(
      searchQuery: '',
      selectedLanguage: 'All',
      clearFormat: true,
      searchResults: const <BookEntity>[],
      status: LibraryStatus.loaded,
    ));
  }

  Future<void> _onLoadBookDetails(
    LoadBookDetailsEvent event,
    Emitter<LibraryState> emit,
  ) async {
    emit(state.copyWith(status: LibraryStatus.loading));
    final bookResult = await getBookDetailsUseCase(event.bookId);
    final chaptersResult = await getChaptersUseCase(event.bookId);

    bookResult.fold(
      (failure) => emit(state.copyWith(
        status: LibraryStatus.error,
        errorMessage: failure.message,
      )),
      (book) {
        chaptersResult.fold(
          (_) => emit(state.copyWith(
            status: LibraryStatus.loaded,
            selectedBook: book,
            bookChapters: const [],
          )),
          (chapters) => emit(state.copyWith(
            status: LibraryStatus.loaded,
            selectedBook: book,
            bookChapters: chapters,
          )),
        );
      },
    );
  }

  Future<void> _onLoadReadingProgress(
    LoadReadingProgressEvent event,
    Emitter<LibraryState> emit,
  ) async {
    final result = await getReadingProgressUseCase(event.userId);
    result.fold(
      (_) {},
      (progress) {
        if (progress != null) {
          final BookEntity? book = state.books.cast<BookEntity?>().firstWhere(
                (BookEntity? b) => b?.id == progress.bookId,
                orElse: () => state.readingProgressBook,
              );
          emit(state.copyWith(
            readingProgress: progress,
            readingProgressBook: book,
          ));
        }
      },
    );
  }
}
