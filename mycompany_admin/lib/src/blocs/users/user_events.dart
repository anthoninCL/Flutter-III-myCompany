part of "user_bloc.dart";

abstract class UserEvent {}

class CreateUser extends UserEvent {
  final String email;
  final String pwd;
  final UserFront user;
  final String companyId;

  CreateUser(this.email, this.pwd, this.user, this.companyId);
}

class GetUser extends UserEvent {
  final String userId;

  GetUser(this.userId);
}

class GetUsers extends UserEvent {
  final List<String> userIds;

  GetUsers(this.userIds);
}

class UpdateUser extends UserEvent {
  final UserFront user;

  UpdateUser(this.user);
}


class DeleteUser extends UserEvent {
  final String userId;

  DeleteUser(this.userId);
}
