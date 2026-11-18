import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, UserEntity>> signInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final UserEntity user = await remoteDataSource.signInWithEmailPassword(
        email: email,
        password: password,
      );
      return Right<Failure, UserEntity>(user);
    } on AuthException catch (e) {
      return Left<Failure, UserEntity>(AuthFailure(message: e.message));
    } catch (e) {
      return Left<Failure, UserEntity>(AuthFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signUpWithEmailPassword({
    required String email,
    required String password,
    required String displayName,
  }) async {
    try {
      final UserEntity user = await remoteDataSource.signUpWithEmailPassword(
        email: email,
        password: password,
        displayName: displayName,
      );
      return Right<Failure, UserEntity>(user);
    } on AuthException catch (e) {
      return Left<Failure, UserEntity>(AuthFailure(message: e.message));
    } catch (e) {
      return Left<Failure, UserEntity>(AuthFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await remoteDataSource.signOut();
      return const Right<Failure, void>(null);
    } catch (e) {
      return Left<Failure, void>(AuthFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity?>> getCurrentUser() async {
    try {
      final UserEntity? user = await remoteDataSource.getCurrentUser();
      return Right<Failure, UserEntity?>(user);
    } catch (e) {
      return Left<Failure, UserEntity?>(AuthFailure(message: e.toString()));
    }
  }

  @override
  Stream<UserEntity?> get onAuthStateChanged => remoteDataSource.onAuthStateChanged;
}
