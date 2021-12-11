/*import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mycompany_admin/src/models/user.dart';
import 'package:mycompany_admin/src/services/user_service.dart';

enum UserEvents { getUser, createUser, updateUser, deleteUser }

class UserBloc extends Bloc<UserEvents, UserState> {
  final UserService _userService = UserService();

  UserBloc() : super(UserState(user: defaultUser)) {
    _userEventStream.listen(_mapEventToState);
  }

  String _id = "";
  UserFront _user = defaultUser;
  late StreamSubscription _blocSubscription;

  final _userEventController = StreamController<UserEvents>();

  final _userStateController = StreamController<UserState>();

  StreamSink<UserState> get _userSink => _userStateController.sink;

  StreamSink<UserEvents> get userEventSink => _userEventController.sink;

  Stream<UserEvents> get _userEventStream => _userEventController.stream;

  void getUser(String id) {
    _id = id;
    userEventSink.add(UserEvents.getUser);
  }

  /*
  void createUser(UserFront user) {
    _user = user;
    add(UserEvents.createUser);
  }

  void updateUser(UserFront user) {
    _user = user;
    add(UserEvents.updateUser);
  }

  void deleteUser(String id) {
    _id = id;
    add(UserEvents.deleteUser);
  }

   */

  void _mapEventToState(UserEvents event) async {
    switch (event) {
      case UserEvents.getUser:
        _userSink.add(UserState(isLoading: true, isLoaded: false, user: _user));
        UserFront user = await _userService.readUser(_id);
        _userSink.add(UserState(isLoading: false, isLoaded: true, user: user));
        break;

        /*
      case UserEvents.createUser:
        _userSink.add(UserState(isSaving: true, isSaved: false, user: _user));
        String token = await _userService.registerUser(_user.email, _password,);
        UserFront user = await _userService.readUser(_id);
        _userSink.add(UserState(
            isSaving: false,
            isSaved: ,
            hasFailure: token != '',
            user: user));
        break;

      case UserEvents.updateUser:
        yield UserState(
          isSaving: true,
          isSaved: false,
        );

        bool isSuccessful = await _userService.updateUser(_user);

        yield UserState(
          isSaving: false,
          isSaved: isSuccessful,
          hasFailure: !isSuccessful,
        );
        break;

      case UserEvents.deleteUser:
        yield UserState(
          isDeleting: true,
          isDeleted: false,
        );

        bool isSuccessful = await _userService.deleteUser(_id);

        yield UserState(
          isDeleting: false,
          isDeleted: isSuccessful,
          hasFailure: !isSuccessful,
        );
        break;

         */
    }
  }
}


 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mycompany_admin/src/models/user.dart';
import 'package:mycompany_admin/src/services/user_service.dart';

part "user_state.dart";

part "user_events.dart";

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
  }
}
