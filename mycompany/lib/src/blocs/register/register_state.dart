part of "register_bloc.dart";

@immutable
abstract class RegisterState {
  const RegisterState();
}

class RegisterInitial extends RegisterState {
  const RegisterInitial();
}

class RegisterLoading extends RegisterState {
  const RegisterLoading();
}

class RegisterLoaded extends RegisterState {
  final UserFront user;

  const RegisterLoaded(this.user);
}

class RegisterError extends RegisterState {
  final String error;

  const RegisterError(this.error);
}