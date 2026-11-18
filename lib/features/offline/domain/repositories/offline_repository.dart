import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/download_task_entity.dart';
import '../../../library/domain/entities/book_entity.dart';
import '../../../reader/domain/entities/verse_entity.dart';

abstract class OfflineRepository {
  Future<Either<Failure, List<BookEntity>>> getCachedBooks();
  Future<Either<Failure, BookEntity?>> getCachedBookById(String id);
  Future<Either<Failure, void>> cacheBook(BookEntity book);
  Future<Either<Failure, void>> removeCachedBook(String id);
  Future<Either<Failure, List<VerseEntity>>> getCachedVerses(String bookId, int chapter);
  Future<Either<Failure, void>> cacheVerses(List<VerseEntity> verses);
  Stream<List<DownloadTaskEntity>> watchDownloads();
  Future<Either<Failure, void>> enqueueDownload(String bookId, String title, String fileUrl);
  Future<Either<Failure, void>> cancelDownload(String taskId);
}
