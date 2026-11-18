import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/verse_entity.dart';
import '../../domain/repositories/reader_repository.dart';
import '../datasources/reader_remote_data_source.dart';

class ReaderRepositoryImpl implements ReaderRepository {
  final ReaderRemoteDataSource remoteDataSource;

  ReaderRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<VerseEntity>>> getVerses(String bookId, int chapter) async {
    try {
      final List<VerseEntity> verses = await remoteDataSource.getVerses(bookId, chapter);
      return Right<Failure, List<VerseEntity>>(verses);
    } on ServerException catch (e) {
      return Left<Failure, List<VerseEntity>>(ServerFailure(message: e.message));
    } catch (e) {
      return Left<Failure, List<VerseEntity>>(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String?>> getChapterAudioUrl(String bookId, int chapter) async {
    try {
      final String? url = await remoteDataSource.getChapterAudioUrl(bookId, chapter);
      return Right<Failure, String?>(url);
    } catch (e) {
      return Left<Failure, String?>(ServerFailure(message: e.toString()));
    }
  }
}
