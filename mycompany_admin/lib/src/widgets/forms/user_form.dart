import 'package:flutter/material.dart';
import 'package:mycompany_admin/src/widgets/form_basic_input.dart';
import 'package:mycompany_admin/src/widgets/form_layout.dart';
import 'package:mycompany_admin/src/widgets/inputs/multiselect_input.dart';
import 'package:mycompany_admin/src/widgets/inputs/role_input.dart';

class UserForm extends StatefulWidget {
  const UserForm({Key? key}) : super(key: key);

  // final User? user;     -> if the user is given, it can be edited, else it's a new document

  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final TextEditingController _firstNameTextController = TextEditingController();
  final TextEditingController _lastNameTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _addressTextController = TextEditingController();
  final TextEditingController _zipCodeTextController = TextEditingController();
  final TextEditingController _cityTextController = TextEditingController();
  final TextEditingController _countryTextController = TextEditingController();
  final TextEditingController _phoneNumberTextController = TextEditingController();
  String role = "User";
  List<String> projects = [];
  List<String> poles = [];

  @override
  void initState() {
    super.initState();
    role = "User";
    projects = [];
    poles = [];
  }

  void changeRole(String value) {
    setState(() {
      role = value;
    });
  }

  void changeProjects(List<String> newProjects) {
    setState(() {
      projects = newProjects;
    });
  }

  void changePoles(List<String> newPoles) {
    setState(() {
      poles = newPoles;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FormLayout(children: [
      FormBasicInput(
        readOnly: false,
        fieldTitle: "FirstName",
        textEditingController: _firstNameTextController,
        hintText: "FirstName",
      ),
      FormBasicInput(
        readOnly: false,
        fieldTitle: "LastName",
        textEditingController: _lastNameTextController,
        hintText: "LastName",
      ),
      FormBasicInput(
        readOnly: true,
        fieldTitle: "Email",
        textEditingController: _emailTextController,
        hintText: "Email",
      ),
      FormBasicInput(
        readOnly: false,
        fieldTitle: "Address",
        textEditingController: _addressTextController,
        hintText: "Address",
      ),
      FormBasicInput(
        readOnly: false,
        fieldTitle: "ZipCode",
        textEditingController: _zipCodeTextController,
        hintText: "ZipCode",
      ),
      FormBasicInput(
        readOnly: false,
        fieldTitle: "City",
        textEditingController: _cityTextController,
        hintText: "Fill with a city",
      ),
      FormBasicInput(
        readOnly: false,
        fieldTitle: "Country",
        textEditingController: _countryTextController,
        hintText: "Country",
      ),
      FormBasicInput(
        readOnly: false,
        fieldTitle: "Phone number",
        textEditingController: _phoneNumberTextController,
        hintText: "Phone number",
      ),
      RoleInput(changeItem: changeRole),
      MultiSelectInput(
          items: const ['Project 1', 'Project 2', 'Project 3', 'Project 4'],
          selectedItems: projects,
          onChange: changeProjects,
          fieldTitle: "Projects",
          onEmpty: "Select projects"),
      MultiSelectInput(
          items: const ['Dev', 'Design', 'Comm', 'Test'],
          selectedItems: poles,
          onChange: changePoles,
          fieldTitle: "Poles",
          onEmpty: "Select poles")
    ]);
  }
}
