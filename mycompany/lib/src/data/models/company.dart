import 'dart:convert';

import 'package:mycompany/src/domain/entities/company.dart';

class CompanyModel extends Company {
  const CompanyModel({
    required String id,
    required String name,
    required String address,
    required String zipCode,
    required String city,
    required String country,
    required String contact,
    required String phoneNumber,
    required List<String> users,
    required List<String> poles,
  }) : super(
          id: id,
          name: name,
          address: address,
          zipCode: zipCode,
          city: city,
          country: country,
          contact: contact,
          phoneNumber: phoneNumber,
          users: users,
          poles: poles,
        );

  factory CompanyModel.fromJson(Map<String, dynamic> map) {
    return CompanyModel(
      id: map["id"],
      name: map["name"],
      address: map["address"],
      zipCode: map["zipCode"],
      city: map["city"],
      country: map["country"],
      contact: map["contact"],
      phoneNumber: map["phoneNumber"],
      users: List<String>.from(json.decode(map["users"])),
      poles: List<String>.from(json.decode(map["poles"])),
    );
  }
}
