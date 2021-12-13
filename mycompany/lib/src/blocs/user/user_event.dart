part of 'user_bloc.dart';

abstract class UserEvent {}

class GetUser extends UserEvent {
  final String userId;

  GetUser(this.userId);
}

class GetUsersFromCompany extends UserEvent {
  final String companyId;

  GetUsersFromCompany(this.companyId);
}

class UpdateUser extends UserEvent {
  final UserFront user;

  UpdateUser(this.user);
}