import 'package:flutter/material.dart';
import 'package:mycompany_admin/src/models/pole.dart';
import 'package:mycompany_admin/src/models/project.dart';
import 'package:mycompany_admin/src/models/user.dart';
import 'package:mycompany_admin/src/widgets/form_basic_input.dart';
import 'package:mycompany_admin/src/widgets/form_layout.dart';
import 'package:mycompany_admin/src/widgets/inputs/multiselect_input.dart';
import 'package:mycompany_admin/src/widgets/inputs/poles_input.dart';
import 'package:mycompany_admin/src/widgets/inputs/projects_input.dart';
import 'package:mycompany_admin/src/widgets/inputs/role_input.dart';
import 'package:mycompany_admin/src/widgets/warning_alert_dialog.dart';

class UserForm extends StatefulWidget {
  const UserForm({Key? key, this.user}) : super(key: key);

  final UserFront? user;

  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  late final TextEditingController _firstNameTextController;
  late final TextEditingController _lastNameTextController;
  late final TextEditingController _emailTextController;
  late final TextEditingController _addressTextController;
  late final TextEditingController _zipCodeTextController;
  late final TextEditingController _cityTextController;
  late final TextEditingController _countryTextController;
  late final TextEditingController _phoneNumberTextController;
  late String role;
  late List<Project> projects;
  late List<Pole> poles;

  @override
  void initState() {
    super.initState();
    if (widget.user != null) {
      _firstNameTextController = TextEditingController(text: widget.user!.firstName);
      _lastNameTextController = TextEditingController(text: widget.user!.lastName);
      _emailTextController = TextEditingController(text: widget.user!.email);
      _addressTextController = TextEditingController(text: widget.user!.address);
      _zipCodeTextController = TextEditingController(text: widget.user!.zipCode);
      _cityTextController = TextEditingController(text: widget.user!.city);
      _countryTextController = TextEditingController(text: widget.user!.country);
      _phoneNumberTextController = TextEditingController(text: widget.user!.phoneNumber);
      role = widget.user!.role;
      projects = widget.user!.projects;
      poles = widget.user!.poles;
    } else {
      _firstNameTextController = TextEditingController(text: '');
      _lastNameTextController = TextEditingController(text: '');
      _emailTextController = TextEditingController(text: '');
      _addressTextController = TextEditingController(text: '');
      _zipCodeTextController = TextEditingController(text: '');
      _cityTextController = TextEditingController(text: '');
      _countryTextController = TextEditingController(text: '');
      _phoneNumberTextController = TextEditingController(text: '');
      role = "User";
      projects = [];
      poles = [];
    }
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
        creation: widget.user != null ? false : true,
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
