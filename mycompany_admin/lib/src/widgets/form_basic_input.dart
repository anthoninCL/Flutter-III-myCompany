import 'package:flutter/material.dart';
import 'package:mycompany_admin/theme/app_colors.dart';

class FormBasicInput extends StatefulWidget {
  const FormBasicInput(
      {Key? key,
      required this.readOnly,
      required this.fieldTitle,
      required this.textEditingController,
      this.defaultValue,
      this.hintText})
      : super(key: key);

  final bool readOnly;
  final String fieldTitle;
  final TextEditingController textEditingController;
  final String? defaultValue;
  final String? hintText;

  @override
  _FormBasicInputState createState() => _FormBasicInputState();
}

class _FormBasicInputState extends State<FormBasicInput> {

  @override
  void initState() {
    super.initState();
    if (widget.defaultValue != null) {
      widget.textEditingController.text = widget.defaultValue!;
      // TODO if previous lane doesn't work, try widget.textEditingController.value = widget.defaultValue as TextEditingValue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 300,
            child: Text(
              widget.fieldTitle,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
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
            child: TextField(
              controller: widget.textEditingController,
              cursorColor: Colors.black,
              style: const TextStyle(color: AppColors.black, fontSize: 20),
              readOnly: widget.readOnly,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: widget.hintText,
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                  )),
            ),
          )
        ],
      ),
    );
  }
}
