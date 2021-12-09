import 'package:flutter/material.dart';

class FormBasicInput extends StatefulWidget {
  const FormBasicInput(
      {Key? key,
      required this.enable,
      required this.fieldTitle,
      required this.textEditingController,
      this.defaultValue,
      this.hintText})
      : super(key: key);

  final bool enable;
  final String fieldTitle;
  final TextEditingController textEditingController;
  final String? defaultValue;
  final String? hintText;

  @override
  _FormBasicInputState createState() => _FormBasicInputState();
}

class _FormBasicInputState extends State<FormBasicInput> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.fieldTitle,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          const SizedBox(
            width: 30,
          ),
          Container(
            height: 50,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(left: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black)),
            child: TextField(
              controller: widget.textEditingController,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: widget.hintText,
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 30,
                  )),
            ),
          )
        ],
      ),
    );
  }
}
