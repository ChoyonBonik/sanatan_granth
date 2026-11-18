import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/book_entity.dart';
import '../repositories/library_repository.dart';

class GetBooksUseCase {
  final LibraryRepository repository;

  GetBooksUseCase(this.repository);

  Future<Either<Failure, List<BookEntity>>> call({String? category, int limit = 20, int offset = 0}) {
    return repository.getBooks(category: category, limit: limit, offset: offset);
  }
}
