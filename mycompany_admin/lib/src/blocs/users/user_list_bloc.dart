import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mycompany_admin/src/models/user.dart';
import 'package:mycompany_admin/src/services/user_service.dart';

enum UserListEvents { readUsers }

class UserListBloc extends Bloc<UserListEvents, List<UserFront>> {
  final UserService _userService = UserService();

  UserListBloc(List<UserFront> initialState) : super(initialState);

  List<UserFront> get initialState => [];

  List<String> _usersId = [];

  void readUsers(List<String> usersId) {
    _usersId = usersId;
    add(UserListEvents.readUsers);
  }

  @override
  Stream<List<UserFront>> mapEventToState(
      List<UserFront> currentState, UserListEvents event) async* {
    switch (event) {
      case UserListEvents.readUsers:
        var users = await _userService.readUsers(_usersId);
        yield users;
    }
  }
}
