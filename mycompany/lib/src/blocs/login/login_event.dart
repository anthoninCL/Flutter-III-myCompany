part of "login_bloc.dart";

abstract class LoginEvent {}

class LoginSubmitEvent extends LoginEvent {
  final String email;
  final String password;

  LoginSubmitEvent(this.email, this.password);
}

class Logout extends LoginEvent {}
