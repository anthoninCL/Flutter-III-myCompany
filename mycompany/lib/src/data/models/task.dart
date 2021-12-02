import 'package:mycompany/src/domain/entities/task.dart';

class TaskModel extends Task {
  const TaskModel({
    required String id,
    required String name,
    required String description,
    required double estimatedTime,
    required int deadline,
    required String state,
    required String priority,
  }) : super(
          id: id,
          name: name,
          description: description,
          estimatedTime: estimatedTime,
          deadline: deadline,
          state: state,
          priority: priority,
        );

  factory TaskModel.fromJson(Map<String, dynamic> map) {
    return TaskModel(
        id: map["id"],
        name: map["name"],
        description: map["description"],
        estimatedTime: map["estimatedTime"],
        deadline: map["deadline"],
        state: map["state"],
        priority: map["priority"]);
  }
}
