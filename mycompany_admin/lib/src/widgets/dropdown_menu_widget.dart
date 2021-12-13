import 'package:flutter/material.dart';
import 'package:mycompany_admin/theme/app_colors.dart';

class DropDownMenuWidget extends StatefulWidget {
  const DropDownMenuWidget(
      {Key? key, required this.items, required this.changeItem, this.initialItem})
      : super(key: key);

  final List<String> items;
  final String? initialItem;
  final Function(String) changeItem;

  @override
  _DropDownMenuWidgetState createState() => _DropDownMenuWidgetState();
}

class _DropDownMenuWidgetState extends State<DropDownMenuWidget> {
  String? value;

  @override
  void initState() {
    super.initState();
    value = widget.initialItem;
  }

  void changeValue(String value) {
    widget.changeItem(value);
    setState(() {
      this.value = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          items: widget.items.map(buildMenuItem).toList(),
          isExpanded: true,
          icon: const Icon(Icons.arrow_drop_down, color: AppColors.black),
          iconSize: 32,
          onChanged: (value) => changeValue(value!),
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: const TextStyle(color: AppColors.black, fontSize: 20),
      ));
}
