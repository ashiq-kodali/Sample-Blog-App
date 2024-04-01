import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/entities/user.dart';

class UserSignUp implements UseCase<User,UserSignUpParms>{
  final AuthRepository authRepository;
  UserSignUp(this.authRepository);
  @override
  Future<Either<Failure, User>> call(UserSignUpParms params)async {
    return await authRepository.signUpWithEmailPassword(name: params.name, email: params.email, password: params.password);
  }


}
class UserSignUpParms{
  final String email;
  final String password;
  final String name;

  UserSignUpParms({required this.email, required this.password, required this.name});

}