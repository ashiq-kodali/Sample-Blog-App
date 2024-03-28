

import 'package:blog_app/features/auth/domain/use_cases/user_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/user.dart';
import '../../domain/use_cases/user_sign_up.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogin _userLogin;
  AuthBloc({required UserSignUp userSignUp,required UserLogin userLogin }) :_userSignUp =userSignUp,_userLogin=userLogin, super(AuthInitial()) {
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthLogin>(_onAuthLogin);

  }






  void _onAuthSignUp(AuthSignUp event, Emitter<AuthState>emit)  async{
    emit(AuthLoading());
    final response = await _userSignUp(UserSignUpParms(email: event.email, password: event.password, name: event.name));
    response.fold((failure) => emit(AuthFailure(failure.message)), (user) => emit(AuthSuccess(user)));
  }
  void _onAuthLogin(AuthLogin event, Emitter<AuthState>emit)  async{
    emit(AuthLoading());
    final response = await _userLogin(UserLoginParms(email: event.email, password: event.password));
    response.fold((failure) => emit(AuthFailure(failure.message)), (user) => emit(AuthSuccess(user)));
  }
}
