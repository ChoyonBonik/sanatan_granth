import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/reading_progress_entity.dart';
import '../repositories/library_repository.dart';

class GetReadingProgressUseCase {
  final LibraryRepository repository;

  GetReadingProgressUseCase(this.repository);

  Future<Either<Failure, ReadingProgressEntity?>> call(String userId) {
    return repository.getReadingProgress(userId);
  }
}
