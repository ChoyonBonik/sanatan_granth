import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/download_task_entity.dart';
import '../../domain/repositories/offline_repository.dart';
import '../../../library/domain/entities/book_entity.dart';
import '../../../reader/domain/entities/verse_entity.dart';
import '../datasources/offline_local_data_source.dart';

class OfflineRepositoryImpl implements OfflineRepository {
  final OfflineLocalDataSource localDataSource;

  OfflineRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<BookEntity>>> getCachedBooks() async {
    try {
      final List<BookEntity> books = await localDataSource.getCachedBooks();
      return Right<Failure, List<BookEntity>>(books);
    } catch (e) {
      return Left<Failure, List<BookEntity>>(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, BookEntity?>> getCachedBookById(String id) async {
    try {
      final BookEntity? book = await localDataSource.getCachedBookById(id);
      return Right<Failure, BookEntity?>(book);
    } catch (e) {
      return Left<Failure, BookEntity?>(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> cacheBook(BookEntity book) async {
    try {
      await localDataSource.cacheBook(book);
      return const Right<Failure, void>(null);
    } catch (e) {
      return Left<Failure, void>(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> removeCachedBook(String id) async {
    try {
      await localDataSource.removeCachedBook(id);
      return const Right<Failure, void>(null);
    } catch (e) {
      return Left<Failure, void>(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<VerseEntity>>> getCachedVerses(String bookId, int chapter) async {
    try {
      final List<VerseEntity> verses = await localDataSource.getCachedVerses(bookId, chapter);
      return Right<Failure, List<VerseEntity>>(verses);
    } catch (e) {
      return Left<Failure, List<VerseEntity>>(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> cacheVerses(List<VerseEntity> verses) async {
    try {
      await localDataSource.cacheVerses(verses);
      return const Right<Failure, void>(null);
    } catch (e) {
      return Left<Failure, void>(CacheFailure(message: e.toString()));
    }
  }

  @override
  Stream<List<DownloadTaskEntity>> watchDownloads() {
    return localDataSource.watchDownloads();
  }

  @override
  Future<Either<Failure, void>> enqueueDownload(String bookId, String title, String fileUrl) async {
    try {
      await localDataSource.enqueueDownload(bookId, title, fileUrl);
      return const Right<Failure, void>(null);
    } catch (e) {
      return Left<Failure, void>(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> cancelDownload(String taskId) async {
    try {
      await localDataSource.cancelDownload(taskId);
      return const Right<Failure, void>(null);
    } catch (e) {
      return Left<Failure, void>(CacheFailure(message: e.toString()));
    }
  }
}
