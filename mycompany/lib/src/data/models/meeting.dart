import 'package:mycompany/src/domain/entities/meeting.dart';

class MeetingModel extends Meeting {
  const MeetingModel({
    required String id,
    required String name,
    required List<String> users,
    required int start, // timestamp
    required double duration,
  }) : super(
          id: id,
          name: name,
          users: users,
          start: start,
          duration: duration,
        );

  factory MeetingModel.fromJson(Map<String, dynamic> map) {
    return MeetingModel(
      id: map["id"],
      name: map["name"],
      users: map["users"],
      start: map["start"],
      duration: map["duration"],
    );
  }
}
