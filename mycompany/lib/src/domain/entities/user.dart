import 'package:equatable/equatable.dart';

class User extends Equatable {

  const User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.address,
    required this.zipCode,
    required this.city,
    required this.country,
    required this.role,
    required this.tasks,
    required this.poles,
  });

  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String phoneNumber;
  final String address;
  final String zipCode;
  final String city;
  final String country;
  final String role;
  final List<String> tasks;
  final List<String> poles;

  @override
  List<Object?> get props {
    return [
      id,
      firstName,
      lastName,
      email,
      password,
      phoneNumber,
      address,
      zipCode,
      city,
      country,
      role,
      tasks,
      poles
    ];
  }

  @override
  bool get stringify => true;
}
