import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/book_entity.dart';
import '../repositories/library_repository.dart';

class GetBookDetailsUseCase {
  final LibraryRepository repository;

  GetBookDetailsUseCase(this.repository);

  Future<Either<Failure, BookEntity>> call(String id) {
    return repository.getBookDetails(id);
  }
}
