import 'package:equatable/equatable.dart';

class Task extends Equatable {
  const Task({
    required this.id,
    required this.name,
    required this.description,
    required this.estimatedTime,
    required this.deadline,
    required this.state,
    required this.priority,
  });

  final String id;
  final String name;
  final String description;
  final double estimatedTime;
  final int deadline;
  final String state;
  final String priority;

  @override
  List<Object?> get props {
    return [
      id,
      name,
      description,
      estimatedTime,
      deadline,
      state,
      priority,
    ];
  }

  @override
  bool get stringify => true;
}
