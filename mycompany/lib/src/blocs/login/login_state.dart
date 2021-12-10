part of "login_bloc.dart";

@immutable
abstract class LoginState {
  const LoginState();
}

class LoginInitial extends LoginState {
  const LoginInitial();
}

class LoginLoading extends LoginState {
  const LoginLoading();
}

class LoginLoaded extends LoginState {
  final UserFront user;

  const LoginLoaded(this.user);
}

class LoginError extends LoginState {
  final String error;

  const LoginError(this.error);
}