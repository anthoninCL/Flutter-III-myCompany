import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mycompany/src/models/user.dart';
import 'package:flutter/material.dart';
import 'package:mycompany/src/services/user_service.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(const RegisterInitial()) {
    on<RegisterSubmitEvent>((event, emit) async {
      try {
        emit(const RegisterLoading());
        var userCreated = UserFront(event.firstName, event.lastName, event.email, "", "", "", "", "", "admin", [], [], "");
        var uuid = await UserService().registerUser(event.email, event.password, userCreated, "");
        var user = await UserService().readUser(uuid);
        emit(RegisterLoaded(user));
      } on Exception catch (error) {
        emit(RegisterError(error.toString()));
      }
    });
  }

}