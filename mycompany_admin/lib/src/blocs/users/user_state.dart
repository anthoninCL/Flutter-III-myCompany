part of "user_bloc.dart";

@immutable
abstract class UserState {
  const UserState();
}

class UserInitial extends UserState {
  const UserInitial();
}

class UserCreating extends UserState {
  const UserCreating();
}

class UserCreated extends UserState {
  final String userId;

  const UserCreated(this.userId);
}

class UserLoading extends UserState {
  const UserLoading();
}

class UserLoaded extends UserState {
  final UserFront user;

  const UserLoaded(this.user);
}

class UsersLoading extends UserState {
  const UsersLoading();
}

class UsersLoaded extends UserState {
  final List<UserFront> users;

  const UsersLoaded(this.users);
}

class UserUpdating extends UserState {
  const UserUpdating();
}

class UserUpdated extends UserState {
  final UserFront user;

  const UserUpdated(this.user);
}

class UserError extends UserState {
  final String error;

  const UserError(this.error);
}
