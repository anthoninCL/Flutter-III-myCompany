import 'package:flutter/material.dart';
import 'package:mycompany_admin/src/widgets/form_basic_input.dart';
import 'package:mycompany_admin/src/widgets/form_layout.dart';

// TODO This is just an example

class UserForm extends StatefulWidget {
  const UserForm({Key? key}) : super(key: key);

  // final User? user;     -> if the user is given, it can be edited, else it's a new document

  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _cityTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FormLayout(children: [
      FormBasicInput(
        readOnly: true,
        fieldTitle: "Email",
        textEditingController: _emailTextController,
        hintText: "Fill with an email",
      ),
      FormBasicInput(
        readOnly: false,
        fieldTitle: "City",
        textEditingController: _cityTextController,
        hintText: "Fill with a city",
      ),
    ]);
  }
}
