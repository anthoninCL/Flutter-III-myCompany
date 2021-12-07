import 'package:mycompany_admin/src/widgets/list_item.dart';

const roles = [
  {
    "id": "1",
    "firstName": "Firstname 1",
    "lastName": "Lastname 1",
    "email": "user1@gmail.com",
    "address": "1 user address",
    "zipCode": "11111",
    "city": "Paris",
    "country": "France",
    "phoneNumber": "1111111111",
    "role": "User",
    "projects": ["Project 1", "Project 2"],
    "poles": ["Pole 1", "Pole 2"],
    "companyId": "1"
  },
];

const listRoles = [
  ListItem(name: "Roles 1", id: "1"),
  ListItem(name: "Roles 2", id: "2"),
  ListItem(name: "Roles 3", id: "3"),
];
