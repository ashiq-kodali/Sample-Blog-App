import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/network/connection_checker.dart';
import 'package:blog_app/features/auth/data/models/user_model.dart';
import 'package:fpdart/fpdart.dart';


import '../../../../core/constants/constants.dart';
import '../../../../core/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../data_sources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final ConnectionChecker connectionChecker;
  const AuthRepositoryImpl(this.remoteDataSource, this.connectionChecker);

  @override
  Future<Either<Failure, User>> loginWithEmailPassword(
      {required String email, required String password}) async {
    return _getUser(() async => await remoteDataSource.loginWithEmailPassword(
        email: email, password: password));
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailPassword(
      {required String name,
      required String email,
      required String password}) async {
    return _getUser(() async => await remoteDataSource.signUpWithEmailPassword(
        email: email, password: password, name: name));
  }

  @override
  Future<Either<Failure, User>> currentUser() async {
    try {
      if (!await(connectionChecker.isConnected)){
        final session = remoteDataSource.currentUserSession;
        if (session == null){
          return left(Failure('User Not Logged in'));
        }

        return right(UserModel(email:session.user.email??"", name: '', id:  session.user.id));
      }
      final user = await remoteDataSource.getCurrentUserData();
      if (user == null) {
        return left(Failure('User not Logged in!'));
      }
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  Future<Either<Failure, User>> _getUser(
    Future<User> Function() fn,
  ) async {
    try {
      if (!await(connectionChecker.isConnected)){
        return left(Failure(Constants.noConnectionErrorMessage));
      }
      final user = await fn();
      return right(user);
    }
    on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
