import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mycompany/src/models/user.dart';
import 'package:mycompany/src/services/company_service.dart';
import 'package:mycompany/src/services/user_service.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(const UserInitial()) {
    on<GetUser>((event, emit) async {
      try {
        emit(const UserLoading());
        var user = await UserService().readUser(event.userId);
        emit(UserLoaded(user));
      } on Exception catch (error) {
        emit(UserError(error.toString()));
      }
    });
    on<GetUsersFromCompany>((event, emit) async {
      try {
        emit(const UserLoading());
        var company = await CompanyService().readCompany(event.companyId);
        emit(UsersLoaded(company.users));
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
  }
}