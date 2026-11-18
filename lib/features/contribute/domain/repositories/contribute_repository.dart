import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/contribution_entity.dart';

abstract class ContributeRepository {
  Future<Either<Failure, ContributionEntity>> submitDocumentUpload({
    required String title,
    required String author,
    required String category,
    required String filePath,
    required ContributionType type,
  });

  Future<Either<Failure, ContributionEntity>> submitVerseCsvUpload({
    required String scriptureTitle,
    required String csvContent,
  });

  Future<Either<Failure, List<ContributionEntity>>> getMyContributions();
}
