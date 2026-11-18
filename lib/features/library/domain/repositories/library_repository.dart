import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/book_entity.dart';
import '../entities/category_entity.dart';

abstract class LibraryRepository {
  Future<Either<Failure, List<CategoryEntity>>> getCategories();
  Future<Either<Failure, List<BookEntity>>> getBooks({String? category, int limit = 20, int offset = 0});
  Future<Either<Failure, List<BookEntity>>> getFeaturedBooks();
  Future<Either<Failure, List<BookEntity>>> searchBooks(String query);
  Future<Either<Failure, BookEntity>> getBookDetails(String id);
}
