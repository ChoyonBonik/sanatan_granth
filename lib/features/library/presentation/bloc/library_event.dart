import 'package:equatable/equatable.dart';
import '../../domain/entities/book_entity.dart';

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
  final String? language;
  final BookFormatType? format;

  const SearchQueryChangedEvent(
    this.query, {
    this.language,
    this.format,
  });

  @override
  List<Object?> get props => <Object?>[query, language, format];
}

class ClearSearchEvent extends LibraryEvent {}

class LoadBookDetailsEvent extends LibraryEvent {
  final String bookId;

  const LoadBookDetailsEvent(this.bookId);

  @override
  List<Object?> get props => <Object?>[bookId];
}

class LoadReadingProgressEvent extends LibraryEvent {
  final String userId;

  const LoadReadingProgressEvent({this.userId = 'default_user'});

  @override
  List<Object?> get props => <Object?>[userId];
}
