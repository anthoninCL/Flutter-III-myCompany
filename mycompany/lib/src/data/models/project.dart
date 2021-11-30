import 'package:mycompany/src/domain/entities/project.dart';

class ProjectModel extends Project {
  const ProjectModel({
    required String id,
    required String name,
    required String description,
    required List<String> tasks,
    required String color,
  }) : super(
          id: id,
          name: name,
          description: description,
          tasks: tasks,
          color: color,
        );

  factory ProjectModel.fromJson(Map<String, dynamic> map) {
    return ProjectModel(
      id: map["id"],
      name: map["name"],
      description: map["description"],
      tasks: map["tasks"],
      color: map["color"],
    );
  }
}
