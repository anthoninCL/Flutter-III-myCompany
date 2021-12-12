import 'package:flutter/material.dart';
import 'package:multiselect/multiselect.dart';
import 'package:mycompany_admin/theme/app_colors.dart';

class MultiSelectInput extends StatefulWidget {
  const MultiSelectInput(
      {Key? key,
      required this.items,
      required this.selectedItems,
      required this.onChange,
      required this.fieldTitle,
      required this.onEmpty})
      : super(key: key);

  final List<String> items;
  final List<String> selectedItems;
  final Function(List<String>) onChange;
  final String fieldTitle;
  final String onEmpty;

  @override
  _MultiSelectInputState createState() => _MultiSelectInputState();
}

class _MultiSelectInputState extends State<MultiSelectInput> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 300,
            child: Text(
              widget.fieldTitle,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: AppColors.black),
            ),
          ),
          const SizedBox(
            width: 30,
          ),
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width * 0.3,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.black)),
            child: DropDownMultiSelect(
              onChanged: widget.onChange,
              options: widget.items,
              selectedValues: widget.selectedItems,
              childBuilder: buildChildItem,
              whenEmpty: widget.onEmpty,
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                  )),
            ),
          )
        ],
      ),
    );
  }

  Widget buildChildItem(List<String> selectedItems) {
    return Align(
        child: Text(
          selectedItems.isNotEmpty
              ? selectedItems.reduce((a, b) => a + ' , ' + b)
              : widget.onEmpty,
          style: const TextStyle(color: AppColors.black, fontSize: 20),
        ),
        alignment: Alignment.centerLeft);
  }
}
