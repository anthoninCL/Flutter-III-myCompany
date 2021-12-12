import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mycompany/src/models/task.dart';
import 'package:mycompany/src/services/task_service.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(const TaskInitial()) {
    on<GetTasks>((event, emit) async {
      try {
        emit(const TaskLoading());
        var tasks = await TaskService().readTasksFromUser(event.userId);
        emit(TasksLoaded(tasks));
      } on Exception catch (error) {
        emit(TaskError(error.toString()));
      }
    });
    on<GetTask>((event, emit) async {
      try {
        emit(const TaskLoading());
        var task = await TaskService().readTask(event.taskId);
        emit(TaskLoaded(task));
      } on Exception catch (error) {
        emit(TaskError(error.toString()));
      }
    });
  }
}
