import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:mycompany_admin/theme/app_colors.dart';

class DateTimeInput extends StatefulWidget {
  const DateTimeInput(
      {Key? key,
      required this.onValueChanged,
      required this.initialValue,
      required this.fieldTitle})
      : super(key: key);

  final Function(DateTime) onValueChanged;
  final DateTime initialValue;
  final String fieldTitle;

  @override
  _DateTimeInputState createState() => _DateTimeInputState();
}

class _DateTimeInputState extends State<DateTimeInput> {
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.initialValue;
  }

  _selectDate(BuildContext context) async {
    DatePicker.showDateTimePicker(context,
        showTitleActions: true,
        minTime: DateTime.now().add(const Duration(hours: 1)),
        maxTime: DateTime(2050, 6, 7),
        onChanged: (date) {}, onConfirm: (date) {
      if (date != selectedDate) {
        setState(() {
          selectedDate = date;
        });
      }
    }, currentTime: selectedDate, locale: LocaleType.en);
  }

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
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
          ),
          const SizedBox(
            width: 30,
          ),
          GestureDetector(
            onTap: () => _selectDate(context),
            child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.15,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${selectedDate.day}/${selectedDate.month}/${selectedDate.year} at ${selectedDate.hour}:${selectedDate.minute}",
                      style:
                      const TextStyle(color: AppColors.black, fontSize: 20),
                    ),
                    const Icon(
                      Icons.calendar_today,
                      color: AppColors.black,
                    )
                  ],
                )),
          )
        ],
      ),
    );
  }
}
