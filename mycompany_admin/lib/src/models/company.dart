import 'package:firebase_auth/firebase_auth.dart';

import 'package:mycompany_admin/src/models/pole.dart';
import 'package:mycompany_admin/src/models/user.dart';

class Company {
  String id;
  String name;
  String address;
  String zipCode;
  String city;
  String country;
  String contact;
  String phoneNumber;
  List<UserFront> users;
  List<Pole> poles;

  Company(this.id, this.name, this.address, this.zipCode, this.city,
      this.country, this.contact, this.phoneNumber, this.users, this.poles);

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "address": address,
      "zipCode": zipCode,
      "city": city,
      "country": country,
      "contact": contact,
      "phoneNumber": phoneNumber,
      "users": users,
      "poles": poles,
    };
  }

  Company.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        name = map['name'],
        address = map['address'],
        zipCode = map["zipCode"],
        city = map['city'],
        country = map['country'],
        contact = map['contact'],
        phoneNumber = map["phoneNumber"],
        users = map["users"],
        poles = map["poles"];

  @override
  String toString() {
    return 'Company: name: $name users: $users poles: $poles';
  }
}
