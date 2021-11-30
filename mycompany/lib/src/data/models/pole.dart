import 'package:mycompany/src/domain/entities/pole.dart';

class PoleModel extends Pole {
  const PoleModel({
    required String id,
    required String name,
    required List<String> projects,
    required List<String> users,
    required String color,
  }) : super(
          id: id,
          name: name,
          projects: projects,
          users: users,
          color: color,
        );

  factory PoleModel.fromJson(Map<String, dynamic> map) {
    return PoleModel(
      id: map["id"],
      name: map["name"],
      projects: map["projects"],
      users: map["users"],
      color: map["color"],
    );
  }
}
