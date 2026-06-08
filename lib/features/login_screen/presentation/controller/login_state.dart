import 'package:meta/meta.dart';

@immutable
abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {
  final String token;
  final String refreshToken;
  final String userName;

  LoginSuccessState(this.token, this.refreshToken, this.userName);
}

class LoginErrorState extends LoginState {
  final String error;
  LoginErrorState(this.error);
}