import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:mycompany/src/config/themes/app_colors.dart';

class CustomDatePicker extends StatefulWidget {
  const CustomDatePicker({Key? key, required this.label, required this.date, required this.onPress, this.format = "EE dd MMM. yyyy", this.datePickerType = "date"})
      : super(key: key);

  final String label;
  final DateTime date;
  final Function onPress;
  final String format;
  final String datePickerType;

  @override
  _CustomDatePickerState createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            switch (widget.datePickerType) {
              case "date":
                DatePicker.showDatePicker(context, showTitleActions: true,
                    onConfirm: (date) {
                      widget.onPress(date);
                    }, currentTime: widget.date);
                break;
              case "dateAndTime":
                DatePicker.showDateTimePicker(context, showTitleActions: true,
                    onConfirm: (date) {
                      widget.onPress(date);
                    }, currentTime: widget.date);
                break;
              default:
                return;
            }
          },
          child: Container(
            padding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            width: (MediaQuery.of(context).size.width - 60) / 2 ,
            height: 30,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  blurRadius: 6,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: Center(
              child: Text(
                widget.label,
                style: const TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
          ),
        ),
        Text(
          DateFormat(widget.format).format(widget.date),
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}
