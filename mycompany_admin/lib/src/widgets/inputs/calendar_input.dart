import 'package:flutter/material.dart';
import 'package:mycompany_admin/theme/app_colors.dart';

class CalendarInput extends StatefulWidget {
  const CalendarInput({Key? key, required this.onDeadlineChanged, required this.initialValue}) : super(key: key);

  final Function(DateTime?) onDeadlineChanged;
  final DateTime initialValue;

  @override
  _CalendarInputState createState() => _CalendarInputState();
}

class _CalendarInputState extends State<CalendarInput> {
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.initialValue;
  }

  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2050),
    );
    if (selected != null && selected != selectedDate) {
      setState(() {
        selectedDate = selected;
      });
    }
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
              "Deadline",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
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
                      "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
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
