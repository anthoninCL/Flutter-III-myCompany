import 'package:equatable/equatable.dart';

class Company extends Equatable {

  const Company({
    required this.id,
    required this.name,
    required this.address,
    required this.zipCode,
    required this.city,
    required this.country,
    required this.contact,
    required this.phoneNumber,
    required this.users,
    required this.poles,
  });

  final String id;
  final String name;
  final String address;
  final String zipCode;
  final String city;
  final String country;
  final String contact;
  final String phoneNumber;
  final List<String> users;
  final List<String> poles;

  @override
  List<Object?> get props {
    return [
      id,
      name,
      address,
      zipCode,
      city,
      country,
      contact,
      phoneNumber,
      users,
      poles
    ];
  }

  @override
  bool get stringify => true;
}
