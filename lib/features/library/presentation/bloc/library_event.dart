import 'package:equatable/equatable.dart';

abstract class LibraryEvent extends Equatable {
  const LibraryEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class LoadLibraryCatalogEvent extends LibraryEvent {
  final String? category;

  const LoadLibraryCatalogEvent({this.category});

  @override
  List<Object?> get props => <Object?>[category];
}

class SelectCategoryFilterEvent extends LibraryEvent {
  final String category;

  const SelectCategoryFilterEvent(this.category);

  @override
  List<Object?> get props => <Object?>[category];
}

class SearchQueryChangedEvent extends LibraryEvent {
  final String query;

  const SearchQueryChangedEvent(this.query);

  @override
  List<Object?> get props => <Object?>[query];
}

class ClearSearchEvent extends LibraryEvent {}

class LoadBookDetailsEvent extends LibraryEvent {
  final String bookId;

  const LoadBookDetailsEvent(this.bookId);

  @override
  List<Object?> get props => <Object?>[bookId];
}
