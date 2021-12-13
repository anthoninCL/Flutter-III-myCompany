import 'package:flutter/material.dart';
import 'package:mycompany_admin/src/blocs/poles/poles_bloc.dart';
import 'package:mycompany_admin/src/models/pole.dart';
import 'package:mycompany_admin/src/shared/utils/color_convertion.dart';
import 'package:mycompany_admin/src/widgets/form_basic_input.dart';
import 'package:mycompany_admin/src/widgets/form_layout.dart';
import 'package:mycompany_admin/src/widgets/inputs/color_input.dart';
import 'package:mycompany_admin/src/widgets/warning_alert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class PoleForm extends StatefulWidget {
  const PoleForm({Key? key, this.pole}) : super(key: key);

  final Pole? pole;

  @override
  _PoleFormState createState() => _PoleFormState();
}

class _PoleFormState extends State<PoleForm> {
  late final TextEditingController _nameTextController;
  late Color pickerColor;

  final PoleBloc _poleBloc = PoleBloc();

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

  void onEdit(BuildContext context) async {
    if (_nameTextController.value.text.isNotEmpty &&
        getStringFromColor(pickerColor).isNotEmpty) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var companyId = prefs.getString("companyId");
      if (companyId != null) {
        var pole = Pole(widget.pole!.id, _nameTextController.text,
            getStringFromColor(pickerColor), companyId);
        _poleBloc.add(AddPole(pole));
      }
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return const WarningAlertDialog();
          });
    }
  }

  void onCreate(BuildContext context) async {
    if (_nameTextController.value.text.isNotEmpty &&
        getStringFromColor(pickerColor).isNotEmpty) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var companyId = prefs.getString("companyId");
      if (companyId != null) {
        var pole = Pole(Uuid().v4(), _nameTextController.text,
            getStringFromColor(pickerColor), companyId);
        _poleBloc.add(AddPole(pole));
      }
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return const WarningAlertDialog();
          });
    }
  }

  Future<void> onDelete() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var companyId = prefs.getString("companyId");
    if (companyId != null) {
      _poleBloc.add(DeletePole(widget.pole!.id, companyId));
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
        onDelete: () {
          onDelete();
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
