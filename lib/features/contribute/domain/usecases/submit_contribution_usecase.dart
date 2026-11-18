import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/contribution_entity.dart';
import '../repositories/contribute_repository.dart';

class SubmitContributionUseCase {
  final ContributeRepository repository;

  SubmitContributionUseCase(this.repository);

  Future<Either<Failure, ContributionEntity>> submitDocument({
    required String title,
    required String author,
    required String category,
    required String filePath,
    required ContributionType type,
  }) {
    return repository.submitDocumentUpload(
      title: title,
      author: author,
      category: category,
      filePath: filePath,
      type: type,
    );
  }

  Future<Either<Failure, ContributionEntity>> submitCsv({
    required String scriptureTitle,
    required String csvContent,
  }) {
    return repository.submitVerseCsvUpload(
      scriptureTitle: scriptureTitle,
      csvContent: csvContent,
    );
  }
}
