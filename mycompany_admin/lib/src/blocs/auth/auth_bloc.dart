import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mycompany_admin/src/services/user_service.dart';
import 'package:mycompany_admin/src/models/user.dart';

part "auth_state.dart";

part "auth_events.dart";

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginInitial()) {
    on<LoginSubmitEvent>((event, emit) async {
      try {
        emit(const LoginLoading());
        var uuid = await UserService().signInUser(event.email, event.password);
        var user = await UserService().readUser(uuid);
        emit(LoginLoaded(user));
      } on Exception catch (error) {
        emit(LoginError(error.toString()));
      }
    });
  }
}
