import 'package:equatable/equatable.dart';

class Project extends Equatable {
  const Project({
    required this.id,
    required this.name,
    required this.description,
    required this.tasks,
    required this.color,
  });

  final String id;
  final String name;
  final String description;
  final List<String> tasks;
  final String color; // Hexadecimal

  @override
  List<Object?> get props {
    return [
      id,
      name,
      description,
      tasks,
      color
    ];
  }

  @override
  bool get stringify => true;
}
