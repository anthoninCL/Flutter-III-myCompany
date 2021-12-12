import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mycompany/src/config/themes/app_colors.dart';
import 'package:mycompany/src/models/task.dart';
import 'package:mycompany/src/presentation/widgets/tile.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({Key? key, required this.task}) : super(key: key);

  final Task task;

  @override
  Widget build(BuildContext context) {

    var endDate = task.deadLine != null ? DateTime.fromMillisecondsSinceEpoch(task.deadLine!) : null;

    Color _getStateColor(String state) {
      if (state == "Todo") {
        return AppColors.primaryLight;
      } else {
        return AppColors.yellow;
      }
    }

    Color _getPriorityColor(String priority) {
      switch (priority) {
        case "Low":
          return AppColors.green;
        case "Medium":
          return AppColors.orange;
        case "High":
          return AppColors.red;
        default:
          return AppColors.black;
      }
    }

    return Container(
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 6,
            offset: const Offset(0, 0),
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
                  task.name,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
              Tile(
                  color: _getPriorityColor(task.priority), label: task.priority)
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            task.description,
            style: const TextStyle(color: AppColors.grey),
          ),
          const SizedBox(
            height: 5,
          ),
          Wrap(
            spacing: 5,
            runSpacing: 5,
            children: [
              const Tile(color: Colors.red, label: "Development"),
              Tile(color: _getStateColor(task.state), label: task.state),
              if (task.estimatedTime > 0)
                Tile(
                  color: Colors.black,
                  label: "${task.estimatedTime.toInt()} days"),
              const Tile(color: Colors.purple, label: "Communication"),
            ],
          ),
          const SizedBox(height: 10,),
          if (endDate != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Deadline: ", style: TextStyle(color: AppColors.grey),),
                Text(DateFormat('EE dd MMM. yyyy').format(endDate), style: TextStyle(color: AppColors.primary),)
              ],
            )
        ],
      ),
    );
  }
}
