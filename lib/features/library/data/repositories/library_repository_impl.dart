import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/book_entity.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/entities/chapter_entity.dart';
import '../../domain/entities/reading_progress_entity.dart';
import '../../domain/repositories/library_repository.dart';
import '../datasources/library_remote_data_source.dart';

class LibraryRepositoryImpl implements LibraryRepository {
  final LibraryRemoteDataSource remoteDataSource;

  LibraryRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategories() async {
    try {
      final List<CategoryEntity> categories = await remoteDataSource.getCategories();
      return Right<Failure, List<CategoryEntity>>(categories);
    } on ServerException catch (e) {
      return Left<Failure, List<CategoryEntity>>(ServerFailure(message: e.message));
    } catch (e) {
      return Left<Failure, List<CategoryEntity>>(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<BookEntity>>> getBooks({
    String? category,
    int limit = 20,
    int offset = 0,
  }) async {
    try {
      final List<BookEntity> books = await remoteDataSource.getBooks(
        category: category,
        limit: limit,
        offset: offset,
      );
      return Right<Failure, List<BookEntity>>(books);
    } on ServerException catch (e) {
      return Left<Failure, List<BookEntity>>(ServerFailure(message: e.message));
    } catch (e) {
      return Left<Failure, List<BookEntity>>(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<BookEntity>>> getFeaturedBooks() async {
    try {
      final List<BookEntity> books = await remoteDataSource.getFeaturedBooks();
      return Right<Failure, List<BookEntity>>(books);
    } on ServerException catch (e) {
      return Left<Failure, List<BookEntity>>(ServerFailure(message: e.message));
    } catch (e) {
      return Left<Failure, List<BookEntity>>(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<BookEntity>>> searchBooks(
    String query, {
    String? language,
    BookFormatType? format,
  }) async {
    try {
      final List<BookEntity> results = await remoteDataSource.searchBooks(
        query,
        language: language,
        format: format,
      );
      return Right<Failure, List<BookEntity>>(results);
    } on ServerException catch (e) {
      return Left<Failure, List<BookEntity>>(ServerFailure(message: e.message));
    } catch (e) {
      return Left<Failure, List<BookEntity>>(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, BookEntity>> getBookDetails(String id) async {
    try {
      final BookEntity book = await remoteDataSource.getBookDetails(id);
      return Right<Failure, BookEntity>(book);
    } on ServerException catch (e) {
      return Left<Failure, BookEntity>(ServerFailure(message: e.message));
    } catch (e) {
      return Left<Failure, BookEntity>(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ChapterEntity>>> getChapters(String bookId) async {
    try {
      final List<ChapterEntity> chapters = await remoteDataSource.getChapters(bookId);
      return Right<Failure, List<ChapterEntity>>(chapters);
    } on ServerException catch (e) {
      return Left<Failure, List<ChapterEntity>>(ServerFailure(message: e.message));
    } catch (e) {
      return Left<Failure, List<ChapterEntity>>(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ReadingProgressEntity?>> getReadingProgress(String userId) async {
    try {
      final ReadingProgressEntity? progress =
          await remoteDataSource.getReadingProgress(userId);
      return Right<Failure, ReadingProgressEntity?>(progress);
    } on ServerException catch (e) {
      return Left<Failure, ReadingProgressEntity?>(ServerFailure(message: e.message));
    } catch (e) {
      return Left<Failure, ReadingProgressEntity?>(ServerFailure(message: e.toString()));
    }
  }
}
