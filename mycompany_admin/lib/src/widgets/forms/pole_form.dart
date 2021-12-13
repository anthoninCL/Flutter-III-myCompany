import 'package:flutter/material.dart';
import 'package:mycompany_admin/src/models/pole.dart';
import 'package:mycompany_admin/src/shared/utils/color_convertion.dart';
import 'package:mycompany_admin/src/widgets/form_basic_input.dart';
import 'package:mycompany_admin/src/widgets/form_layout.dart';
import 'package:mycompany_admin/src/widgets/inputs/color_input.dart';
import 'package:mycompany_admin/src/widgets/warning_alert_dialog.dart';

class PoleForm extends StatefulWidget {
  const PoleForm({Key? key, this.pole}) : super(key: key);

  final Pole? pole;

  @override
  _PoleFormState createState() => _PoleFormState();
}

class _PoleFormState extends State<PoleForm> {
  late final TextEditingController _nameTextController;
  late Color pickerColor;

  @override
  void initState() {
    super.initState();
    if (widget.pole != null) {
      _nameTextController = TextEditingController(text: widget.pole!.name);
      pickerColor = getColorFromString(widget.pole!.color);
    } else {
      _nameTextController = TextEditingController(text: '');
      pickerColor = const Color(0xFF0652DD);
    }
  }

  void changeColor(Color color) {
    setState(() => pickerColor = color);
    print(getStringFromColor(pickerColor));
  }

  void onEdit(BuildContext context) {
    if (_nameTextController.value.text.isNotEmpty &&
        getStringFromColor(pickerColor).isNotEmpty) {
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
    if (_nameTextController.value.text.isNotEmpty &&
        getStringFromColor(pickerColor).isNotEmpty) {
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
        creation: widget.pole != null ? false : true, // replace with widget.pole ? true : false
        onEdit: () {
          onEdit(context);
        },
        onCreate: () {
          onCreate(context);
        },
        children: [
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
