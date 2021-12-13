part of 'tasks_bloc.dart';

abstract class TasksEvent {}

class AddTask extends TasksEvent {
  final Task task;
  final String projectId;

  AddTask(this.task, this.projectId);
}

class GetTask extends TasksEvent {
  final String taskId;

  GetTask(this.taskId);
}

class GetTasks extends TasksEvent {
  final String userId;

  GetTasks(this.userId);
}

class UpdateTask extends TasksEvent {
  final Task task;
  final String projectId;

  UpdateTask(this.task, this.projectId);
}

class DeleteTask extends TasksEvent {
  final String taskId;
  final String companyId;

  DeleteTask(this.taskId, this.companyId);
}
