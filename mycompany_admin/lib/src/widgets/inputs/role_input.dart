import 'package:flutter/material.dart';
import 'package:mycompany_admin/src/widgets/dropdown_menu_widget.dart';

class RoleInput extends StatefulWidget {
  const RoleInput({Key? key, required this.changeItem}) : super(key: key);

  final Function(String) changeItem;

  @override
  _RoleInputState createState() => _RoleInputState();
}

class _RoleInputState extends State<RoleInput> {
  final items = ['User', 'Manager', 'Admin'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            width: 300,
            child: Text(
              'Permissions',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
          ),
          const SizedBox(
            width: 30,
          ),
          Container(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.3,
              alignment: Alignment.center,
              padding: const EdgeInsets.only(left: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black)),
              child: DropDownMenuWidget(
                  items: items,
                  changeItem: widget.changeItem,
                  initialItem: items[0]))
        ],
      ),
    );
  }
}
