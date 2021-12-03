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
  List<dynamic> tasks;
  List<dynamic> poles;

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
      this.poles,
      this.tasks,
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
      "tasks": tasks,
      "poles": poles
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
        tasks = map["tasks"],
        poles = map["poles"];
}