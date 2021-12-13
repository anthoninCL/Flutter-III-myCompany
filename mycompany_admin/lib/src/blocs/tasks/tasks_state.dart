part of "tasks_bloc.dart";

@immutable
abstract class TasksState {
  const TasksState();
}

class TaskInitial extends TasksState {
  const TaskInitial();
}

class TaskCreating extends TasksState {
  const TaskCreating();
}

class TaskCreated extends TasksState {
  const TaskCreated();
}

class TaskLoading extends TasksState {
  const TaskLoading();
}

class TaskLoaded extends TasksState {
  final Task task;

  const TaskLoaded(this.task);
}

class TasksLoaded extends TasksState {
  final List<Task> tasks;

  const TasksLoaded(this.tasks);
}

class TaskUpdating extends TasksState {
  const TaskUpdating();
}

class TaskUpdated extends TasksState {
  const TaskUpdated();
}

class TaskDeleting extends TasksState {
  const TaskDeleting();
}

class TaskDeleted extends TasksState {
  const TaskDeleted();
}

class TaskError extends TasksState {
  final String error;

  const TaskError(this.error);
}
