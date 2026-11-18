import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_books_usecase.dart';
import '../../domain/usecases/get_categories_usecase.dart';
import '../../domain/usecases/get_book_details_usecase.dart';
import '../../domain/usecases/search_books_usecase.dart';
import 'library_event.dart';
import 'library_state.dart';

class LibraryBloc extends Bloc<LibraryEvent, LibraryState> {
  final GetCategoriesUseCase getCategoriesUseCase;
  final GetBooksUseCase getBooksUseCase;
  final SearchBooksUseCase searchBooksUseCase;
  final GetBookDetailsUseCase getBookDetailsUseCase;

  LibraryBloc({
    required this.getCategoriesUseCase,
    required this.getBooksUseCase,
    required this.searchBooksUseCase,
    required this.getBookDetailsUseCase,
  }) : super(const LibraryState()) {
    on<LoadLibraryCatalogEvent>(_onLoadCatalog);
    on<SelectCategoryFilterEvent>(_onSelectCategory);
    on<SearchQueryChangedEvent>(_onSearchQueryChanged);
    on<ClearSearchEvent>(_onClearSearch);
    on<LoadBookDetailsEvent>(_onLoadBookDetails);
  }

  Future<void> _onLoadCatalog(
    LoadLibraryCatalogEvent event,
    Emitter<LibraryState> emit,
  ) async {
    emit(state.copyWith(status: LibraryStatus.loading));

    final categoriesResult = await getCategoriesUseCase();
    final booksResult = await getBooksUseCase(category: event.category ?? state.selectedCategory);

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
            emit(state.copyWith(
              status: LibraryStatus.loaded,
              categories: categories,
              books: books,
              featuredBooks: featured.isNotEmpty ? featured : books.take(3).toList(),
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
    if (event.query.trim().isEmpty) {
      emit(state.copyWith(
        searchQuery: '',
        searchResults: const [],
        status: LibraryStatus.loaded,
      ));
      return;
    }

    emit(state.copyWith(
      searchQuery: event.query,
      status: LibraryStatus.searching,
    ));

    final searchResult = await searchBooksUseCase(event.query);
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
      searchResults: const [],
      status: LibraryStatus.loaded,
    ));
  }

  Future<void> _onLoadBookDetails(
    LoadBookDetailsEvent event,
    Emitter<LibraryState> emit,
  ) async {
    emit(state.copyWith(status: LibraryStatus.loading));
    final result = await getBookDetailsUseCase(event.bookId);
    result.fold(
      (failure) => emit(state.copyWith(
        status: LibraryStatus.error,
        errorMessage: failure.message,
      )),
      (book) => emit(state.copyWith(
        status: LibraryStatus.loaded,
        selectedBook: book,
      )),
    );
  }
}
