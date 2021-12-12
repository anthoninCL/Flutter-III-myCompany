part of "register_bloc.dart";

abstract class RegisterEvent {}

class RegisterSubmitEvent extends RegisterEvent {
  final String firstName;
  final String lastName;
  final String email;
  final String password;

  RegisterSubmitEvent(this.firstName, this.lastName, this.email, this.password);
}