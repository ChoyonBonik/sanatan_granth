import 'package:csv/csv.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/contribution_entity.dart';
import '../../domain/repositories/contribute_repository.dart';
import '../datasources/contribute_remote_data_source.dart';

class ContributeRepositoryImpl implements ContributeRepository {
  final ContributeRemoteDataSource remoteDataSource;

  ContributeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, ContributionEntity>> submitDocumentUpload({
    required String title,
    required String author,
    required String category,
    required String filePath,
    required ContributionType type,
  }) async {
    try {
      final ContributionEntity result = await remoteDataSource.submitContribution(
        title: title,
        category: category,
        type: type,
        fileUrl: filePath,
        totalItems: 1,
      );
      return Right<Failure, ContributionEntity>(result);
    } catch (e) {
      return Left<Failure, ContributionEntity>(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ContributionEntity>> submitVerseCsvUpload({
    required String scriptureTitle,
    required String csvContent,
  }) async {
    try {
      final List<List<dynamic>> rows =
          const CsvToListConverter().convert(csvContent);
      final int totalVerses = rows.length > 1 ? rows.length - 1 : 0;

      final ContributionEntity result = await remoteDataSource.submitContribution(
        title: scriptureTitle,
        category: 'Structured Verses',
        type: ContributionType.verseCsv,
        totalItems: totalVerses,
      );
      return Right<Failure, ContributionEntity>(result);
    } catch (e) {
      return Left<Failure, ContributionEntity>(
        ValidationFailure(message: 'Invalid CSV format: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, List<ContributionEntity>>> getMyContributions() async {
    try {
      final List<ContributionEntity> list = await remoteDataSource.getMyContributions();
      return Right<Failure, List<ContributionEntity>>(list);
    } catch (e) {
      return Left<Failure, List<ContributionEntity>>(ServerFailure(message: e.toString()));
    }
  }
}
