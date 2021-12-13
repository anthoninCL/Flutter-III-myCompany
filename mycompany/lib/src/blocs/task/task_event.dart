part of 'task_bloc.dart';

abstract class TaskEvent {}

class GetTask extends TaskEvent {
  final String taskId;

  GetTask(this.taskId);
}

class GetTasks extends TaskEvent {
  final String userId;

  GetTasks(this.userId);
}

class EditTask extends TaskEvent {}

class AddTask extends TaskEvent {
  final Task task;
  final String projectId;

  AddTask(this.task, this.projectId);
}