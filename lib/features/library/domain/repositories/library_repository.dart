import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/book_entity.dart';
import '../entities/category_entity.dart';
import '../entities/chapter_entity.dart';
import '../entities/reading_progress_entity.dart';

abstract class LibraryRepository {
  Future<Either<Failure, List<CategoryEntity>>> getCategories();
  Future<Either<Failure, List<BookEntity>>> getBooks({String? category, int limit = 20, int offset = 0});
  Future<Either<Failure, List<BookEntity>>> getFeaturedBooks();
  Future<Either<Failure, List<BookEntity>>> searchBooks(String query, {String? language, BookFormatType? format});
  Future<Either<Failure, BookEntity>> getBookDetails(String id);
  Future<Either<Failure, List<ChapterEntity>>> getChapters(String bookId);
  Future<Either<Failure, ReadingProgressEntity?>> getReadingProgress(String userId);
}
