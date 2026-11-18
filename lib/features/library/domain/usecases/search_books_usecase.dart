import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/book_entity.dart';
import '../repositories/library_repository.dart';

class SearchBooksUseCase {
  final LibraryRepository repository;

  SearchBooksUseCase(this.repository);

  Future<Either<Failure, List<BookEntity>>> call(String query) {
    return repository.searchBooks(query);
  }
}
