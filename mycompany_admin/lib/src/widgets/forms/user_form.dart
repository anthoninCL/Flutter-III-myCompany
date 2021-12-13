import 'package:flutter/material.dart';
import 'package:mycompany_admin/src/models/pole.dart';
import 'package:mycompany_admin/src/models/project.dart';
import 'package:mycompany_admin/src/widgets/form_basic_input.dart';
import 'package:mycompany_admin/src/widgets/form_layout.dart';
import 'package:mycompany_admin/src/widgets/inputs/multiselect_input.dart';
import 'package:mycompany_admin/src/widgets/inputs/poles_input.dart';
import 'package:mycompany_admin/src/widgets/inputs/projects_input.dart';
import 'package:mycompany_admin/src/widgets/inputs/role_input.dart';
import 'package:mycompany_admin/src/widgets/warning_alert_dialog.dart';

class UserForm extends StatefulWidget {
  const UserForm({Key? key}) : super(key: key);

  // final User? user;     -> if the user is given, it can be edited, else it's a new document

  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final TextEditingController _firstNameTextController =
      TextEditingController();
  final TextEditingController _lastNameTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _addressTextController = TextEditingController();
  final TextEditingController _zipCodeTextController = TextEditingController();
  final TextEditingController _cityTextController = TextEditingController();
  final TextEditingController _countryTextController = TextEditingController();
  final TextEditingController _phoneNumberTextController =
      TextEditingController();
  String role = "User";
  List<Project> projects = [];
  List<Pole> poles = [];

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

  void changeProjects(List<Project> newProjects) {
    setState(() {
      projects = newProjects;
    });
  }

  void changePoles(List<Pole> newPoles) {
    setState(() {
      poles = newPoles;
    });
  }

  void onEdit(BuildContext context) {
    if (_firstNameTextController.value.text.isNotEmpty &&
        _lastNameTextController.value.text.isNotEmpty &&
        _emailTextController.value.text.isNotEmpty &&
        _addressTextController.value.text.isNotEmpty &&
        _zipCodeTextController.value.text.isNotEmpty &&
        _cityTextController.value.text.isNotEmpty &&
        _countryTextController.value.text.isNotEmpty &&
        _phoneNumberTextController.value.text.isNotEmpty) {
      print("Edit");
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return const WarningAlertDialog();
          });
    }
  }

  void onCreate(BuildContext context) {
    if (_firstNameTextController.value.text.isNotEmpty &&
        _lastNameTextController.value.text.isNotEmpty &&
        _emailTextController.value.text.isNotEmpty &&
        _addressTextController.value.text.isNotEmpty &&
        _zipCodeTextController.value.text.isNotEmpty &&
        _cityTextController.value.text.isNotEmpty &&
        _countryTextController.value.text.isNotEmpty &&
        _phoneNumberTextController.value.text.isNotEmpty) {
      print("Create");
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return const WarningAlertDialog();
          });
    }
  }


  @override
  Widget build(BuildContext context) {
    return FormLayout(
        creation: false, // replace with widget.user ? true : false
        onEdit: () {
          onEdit(context);
        },
        onCreate: () {
          onCreate(context);
        },
        children: [
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
          ProjectInput(multi: true, fieldTitle: 'Projects', onEmpty: 'Select projects', selectedItems: projects, onMultiChange: changeProjects,),
          PoleInput(multi: true, fieldTitle: 'Poles', onEmpty: 'Select poles', selectedItems: poles, onMultiChange: changePoles,)
        ]);
  }
}
