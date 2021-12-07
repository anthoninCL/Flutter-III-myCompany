import 'package:mycompany/src/models/pole.dart';
import 'package:mycompany/src/models/project.dart';

class UserFront {
  String id;
  String firstName;
  String lastName;
  String email;
  String address;
  String zipCode;
  String city;
  String country;
  String phoneNumber;
  String role;
  List<Project> projects;
  List<Pole> poles;
  String companyId;

  UserFront(
      this.firstName,
      this.lastName,
      this.email,
      this.address,
      this.zipCode,
      this.city,
      this.country,
      this.phoneNumber,
      this.role,
      this.projects,
      this.poles,
      this.companyId,
      [this.id = ""]);

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "address": address,
      "zipCode": zipCode,
      "city": city,
      "country": country,
      "phoneNumber": phoneNumber,
      "role": role,
      "projects": projects,
      "poles": poles,
      "companyId": companyId
    };
  }

  UserFront.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        firstName = map["firstName"],
        lastName = map["lastName"],
        email = map["email"],
        address = map["address"],
        zipCode = map["zipCode"],
        city = map["city"],
        country = map["country"],
        phoneNumber = map["phoneNumber"],
        role = map["role"],
        projects = map["projects"],
        poles = map["poles"],
        companyId = map["companyId"];

  @override
  String toString() {
    return 'User: $firstName $lastName ${poles.toString()}';
  }
}
