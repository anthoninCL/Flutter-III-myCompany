import 'package:mycompany_admin/src/models/task.dart';

class Project {
  String id;
  String name;
  String description;
  String color;
  String companyId;
  List<Task> tasks;

  Project(this.id, this.name, this.description, this.color, this.tasks,
      this.companyId);

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "description": description,
      "color": color,
      "tasks": tasks,
      "companyId": companyId,
    };
  }

  Project.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        name = map["name"],
        description = map["description"],
        color = map["color"],
        tasks = map["tasks"],
        companyId = map["companyId"];

  @override
  String toString() {
    return 'Project: {name: $name, Task: ${tasks.toString()} }';
  }
}
