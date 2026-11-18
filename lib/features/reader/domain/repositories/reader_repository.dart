import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/verse_entity.dart';

abstract class ReaderRepository {
  Future<Either<Failure, List<VerseEntity>>> getVerses(String bookId, int chapter);
  Future<Either<Failure, String?>> getChapterAudioUrl(String bookId, int chapter);
}
