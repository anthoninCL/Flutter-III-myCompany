part of "task_bloc.dart";

@immutable
abstract class TaskState {
  const TaskState();
}

class TaskInitial extends TaskState {
  const TaskInitial();
}

class TaskLoading extends TaskState {
  const TaskLoading();
}

class TaskLoaded extends TaskState {
  final Task user;

  const TaskLoaded(this.user);
}

class TasksLoaded extends TaskState {
  final List<Task> tasks;

  const TasksLoaded(this.tasks);
}

class TaskError extends TaskState {
  final String error;

  const TaskError(this.error);
}