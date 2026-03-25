import 'package:flutter/material.dart';
import 'package:lab1/model/task.dart';

class StatusIcon extends StatelessWidget {
  const StatusIcon(this.task, {super.key});
  final Task task;

  @override
  Widget build(BuildContext context) {
    final bool completed = task.completed;

    return Icon(completed ? Icons.check_circle : Icons.radio_button_unchecked,
        color: completed ? Colors.green : null);
  }
}
