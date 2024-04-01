import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/core/error/failures.dart';

import 'package:fpdart/src/either.dart';

import '../../../../core/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../data_sources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository{
  final AuthRemoteDataSource remoteDataSource;
  const AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, User>> loginWithEmailPassword({required String email, required String password})async {
    
    return _getUser(() async=> await remoteDataSource.loginWithEmailPassword(email: email, password: password) );
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailPassword({required String name, required String email, required String
  password}) async{

      return _getUser(() async => await remoteDataSource.signUpWithEmailPassword(email: email, password: password, name: name)) ;

  }

  @override
  Future<Either<Failure, User>> currentUser() async{
    try{
      final user = await remoteDataSource.getCurrentUserData();
      if (user==null){
        return left(Failure('User not Logged in!'));
      }
      return right(user);
    }on ServerException catch(e){
      return left(Failure(e.message));
    }

  }


  Future<Either<Failure, User>> _getUser(
      Future<User>Function() fn,
      )async{
    try{
      final user = await fn();
      return right(user);
    }on ServerException catch(e){
      return left(Failure(e.message));
    }


  }





}