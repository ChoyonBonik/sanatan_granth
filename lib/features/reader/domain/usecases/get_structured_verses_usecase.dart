import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/verse_entity.dart';
import '../repositories/reader_repository.dart';

class GetStructuredVersesUseCase {
  final ReaderRepository repository;

  GetStructuredVersesUseCase(this.repository);

  Future<Either<Failure, List<VerseEntity>>> call({
    required String bookId,
    required int chapter,
  }) {
    return repository.getVerses(bookId, chapter);
  }
}
