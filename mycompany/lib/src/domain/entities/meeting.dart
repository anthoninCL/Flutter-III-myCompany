import 'package:equatable/equatable.dart';

class Meeting extends Equatable {
  const Meeting({
    required this.id,
    required this.name,
    required this.users,
    required this.start,
    required this.duration,
});

  final String id;
  final String name;
  final List<String> users;
  final int start; // timestamp
  final double duration;

  @override
  List<Object?> get props {
    return [
      id,
      name,
      users,
      start,
      duration
    ];
  }

  @override
  bool get stringify => true;
}