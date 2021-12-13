import 'package:mycompany/src/models/user.dart';

class Meeting {
  String id;
  List<UserFront> users;
  String name;
  int dateStart;
  double duration;
  String companyId;

  Meeting(this.id, this.users, this.name, this.dateStart, this.duration, this.companyId);

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "users": users,
      "name": name,
      "dateStart": dateStart,
      "duration": duration,
      "companyId": companyId,
    };
  }

  Meeting.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        users = map["users"],
        name = map["name"],
        dateStart = map["dateStart"],
        duration = map["duration"].toDouble(),
        companyId = map["companyId"];

  @override
  String toString() {
    return 'Meeting: {name: $name, Users: ${users.toString()} }';
  }
}
