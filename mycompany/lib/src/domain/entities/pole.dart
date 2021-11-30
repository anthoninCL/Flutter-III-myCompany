import 'package:equatable/equatable.dart';

class Pole extends Equatable {

  const Pole({
    required this.id,
    required this.name,
    required this.projects,
    required this.users,
    required this.color,
  });

  final String id;
  final String name;
  final List<String> projects;
  final List<String> users;
  final String color; // Hexadecimal

  @override
  List<Object?> get props {
    return [id, name, projects, users, color];
  }

  @override
  bool get stringify => true;
}
