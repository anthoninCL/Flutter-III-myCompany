import 'package:mycompany/src/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required String id,
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String phoneNumber,
    required String address,
    required String zipCode,
    required String city,
    required String country,
    required String role,
    required List<String> tasks,
    required List<String> poles,
  }) : super(
          id: id,
          firstName: firstName,
          lastName: lastName,
          email: email,
          password: password,
          phoneNumber: phoneNumber,
          address: address,
          zipCode: zipCode,
          city: city,
          country: country,
          role: role,
          tasks: tasks,
          poles: poles,
        );

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      id: map["id"],
      firstName: map["firstName"],
      lastName: map["lastName"],
      email: map["email"],
      password: map["password"],
      phoneNumber: map["phoneNumber"],
      address: map["address"],
      zipCode: map["zipCode"],
      city: map["city"],
      country: map["country"],
      role: map["role"],
      tasks: map["tasks"],
      poles: map["poles"],
    );
  }
}
