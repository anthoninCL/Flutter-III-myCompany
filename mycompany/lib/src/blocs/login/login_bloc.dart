import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mycompany/src/models/user.dart';
import 'package:mycompany/src/services/user_service.dart';

part "login_state.dart";

part "login_event.dart";

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
    on<Logout>((event, emit) async {
      emit(const LoginInitial());
    });
  }
}