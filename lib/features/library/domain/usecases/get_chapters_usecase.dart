import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/chapter_entity.dart';
import '../repositories/library_repository.dart';

class GetChaptersUseCase {
  final LibraryRepository repository;

  GetChaptersUseCase(this.repository);

  Future<Either<Failure, List<ChapterEntity>>> call(String bookId) {
    return repository.getChapters(bookId);
  }
}
