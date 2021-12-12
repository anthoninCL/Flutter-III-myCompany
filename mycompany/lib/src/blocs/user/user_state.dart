part of 'user_bloc.dart';

@immutable
abstract class UserState {
  const UserState();
}

class UserInitial extends UserState {
  const UserInitial();
}

class UserLoading extends UserState {
  const UserLoading();
}

class UserLoaded extends UserState {
  final UserFront user;

  const UserLoaded(this.user);
}

class UsersLoaded extends UserState {
  final List<UserFront> users;

  const UsersLoaded(this.users);
}

class UserError extends UserState {
  final String error;

  const UserError(this.error);
}