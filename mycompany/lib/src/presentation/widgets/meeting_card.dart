import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mycompany/src/models/meeting.dart';

class MeetingCard extends StatelessWidget {
  const MeetingCard({Key? key, required this.meeting, this.showDate = true}) : super(key: key);

  final Meeting meeting;
  final bool showDate;

  @override
  Widget build(BuildContext context) {

    var date = DateTime.fromMillisecondsSinceEpoch(meeting.dateStart);
    var endDate = date.add(Duration(minutes: meeting.duration.toInt()));

    return Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 6,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  meeting.name,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
              if (showDate)
                Text(
                  DateFormat('EE dd MMM. yyyy').format(date),
                ),
            ],
          ),
          SizedBox(height: 5),
          Text(
              "${DateFormat('HH:mm').format(date)} - ${DateFormat('HH:mm').format(endDate)}")
        ],
      ),
    );

  }
}
