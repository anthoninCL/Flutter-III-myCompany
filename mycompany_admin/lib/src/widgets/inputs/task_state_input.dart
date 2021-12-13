import 'package:flutter/material.dart';
import 'package:mycompany_admin/src/widgets/dropdown_menu_widget.dart';

class TaskStateInput extends StatefulWidget {
  const TaskStateInput({Key? key, required this.changeItem, this.initialItem}) : super(key: key);

  final Function(String) changeItem;
  final String? initialItem;

  @override
  _TaskStateInputState createState() => _TaskStateInputState();
}

class _TaskStateInputState extends State<TaskStateInput> {
  final items = ['None', 'Low', 'Medium', 'High'];

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
              'Task priority',
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
                  initialItem: widget.initialItem ?? items[0]))
        ],
      ),
    );
  }
}
