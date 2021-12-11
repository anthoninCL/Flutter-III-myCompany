part of "user_bloc.dart";

abstract class UserEvent {}

class GetUser extends UserEvent {
  final String userId;

  GetUser(this.userId);
}
