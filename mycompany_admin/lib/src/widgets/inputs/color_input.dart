import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorInput extends StatefulWidget {
  const ColorInput(
      {Key? key, required this.pickerColor, required this.onColorChange})
      : super(key: key);

  final Color pickerColor;
  final Function(Color) onColorChange;

  @override
  _ColorInputState createState() => _ColorInputState();
}

class _ColorInputState extends State<ColorInput> {

  void showColorPicker(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Pick a color'),
            content: SingleChildScrollView(
              child: BlockPicker(
                pickerColor: widget.pickerColor,
                onColorChanged: widget.onColorChange,
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: const Text('Got it'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        }
    );
  }

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
              'Color',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
          ),
          const SizedBox(
            width: 30,
          ),
          GestureDetector(
            onTap: () => showColorPicker(context),
            child: Container(
              height: 50,
              width: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: widget.pickerColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black)),
            ),
          )
        ],
      ),
    );
  }
}
