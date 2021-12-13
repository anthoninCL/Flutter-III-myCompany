import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mycompany_admin/src/models/user.dart';
import 'package:mycompany_admin/src/services/user_service.dart';

part "user_state.dart";
part "user_events.dart";

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(const UserInitial()) {

    on<CreateUser>((event, emit) async {
      try {
        emit(const UserCreating());
        var userId = await UserService()
            .registerUser(event.email, event.pwd, event.user, event.companyId);
        emit(UserCreated(userId));
      } on Exception catch (error) {
        emit(UserError(error.toString()));
      }
    });

    on<GetUser>((event, emit) async {
      try {
        emit(const UserLoading());
        var user = await UserService().readUser(event.userId);
        emit(UserLoaded(user));
      } on Exception catch (error) {
        emit(UserError(error.toString()));
      }
    });

    on<GetUsers>((event, emit) async {
      try {
        emit(const UsersLoading());
        var users = await UserService().readUsers(event.userIds);
        emit(UsersLoaded(users));
      } on Exception catch (error) {
        emit(UserError(error.toString()));
      }
    });

    on<UpdateUser>((event, emit) async {
      try {
        await UserService().updateUser(event.user);
      } on Exception catch (error) {
        emit(UserError(error.toString()));
      }
    });

    on<DeleteUser>((event, emit) async {
      try {
        await UserService().deleteUser(event.userId);
      } on Exception catch (error) {
        emit(UserError(error.toString()));
      }
    });

  }
}
