import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:fpdart/fpdart.dart';

import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class UserLogin implements UseCase<User,UserLoginParms>{
  final AuthRepository authRepository;

  const UserLogin(this.authRepository);

  @override
  Future<Either<Failure, User>> call(UserLoginParms params) async{
   return await authRepository.loginWithEmailPassword(email: params.email, password: params.password);
  }


}
class UserLoginParms{
  final String email;
  final String password;

  UserLoginParms({required this.email, required this.password});

}