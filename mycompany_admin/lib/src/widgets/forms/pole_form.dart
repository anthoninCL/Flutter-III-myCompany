import 'package:flutter/material.dart';
import 'package:mycompany_admin/src/shared/utils/color_convertion.dart';
import 'package:mycompany_admin/src/widgets/form_basic_input.dart';
import 'package:mycompany_admin/src/widgets/form_layout.dart';
import 'package:mycompany_admin/src/widgets/inputs/color_input.dart';

class PoleForm extends StatefulWidget {
  const PoleForm({Key? key}) : super(key: key);

  @override
  _PoleFormState createState() => _PoleFormState();
}

class _PoleFormState extends State<PoleForm> {
  final TextEditingController _nameTextController = TextEditingController();
  Color pickerColor = const Color(0xFF0652DD);

  void changeColor(Color color) {
    setState(() => pickerColor = color);
    print(getStringFromColor(pickerColor));
  }

  @override
  Widget build(BuildContext context) {
    return FormLayout(children: [
      FormBasicInput(
        readOnly: false,
        fieldTitle: "Pole name",
        textEditingController: _nameTextController,
        hintText: "Pole name",
      ),
      ColorInput(pickerColor: pickerColor, onColorChange: changeColor)
    ]);
  }
}
