import 'package:mycompany_admin/src/models/user.dart';

class Meeting {
  String id;
  List<UserFront> users;
  String name;
  int dateStart;
  double duration;

  Meeting(this.id, this.users, this.name, this.dateStart, this.duration);

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "users": users,
      "name": name,
      "dateStart": dateStart,
      "duration": duration
    };
  }

  Meeting.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        users = map["users"],
        name = map["name"],
        dateStart = map["dateStart"],
        duration = map["duration"];

  @override
  String toString() {
    return 'Meeting: {name: $name, Users: ${users.toString()} }';
  }
}