
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mycompany_admin/src/models/task.dart';
import 'package:mycompany_admin/src/services/task_service.dart';

part 'tasks_events.dart';
part 'tasks_state.dart';

class TaskBloc extends Bloc<TasksEvent, TasksState> {
  TaskBloc() : super(const TaskInitial()) {
    on<AddTask>((event, emit) async {
      try {
        emit(const TaskCreating());
        await TaskService().setTask(event.task, event.projectId);
        emit(const TaskCreated());
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

    on<GetTasks>((event, emit) async {
      try {
        emit(const TaskLoading());
        var tasks = await TaskService().readTasksFromUser(event.userId);
        emit(TasksLoaded(tasks));
      } on Exception catch (error) {
        emit(TaskError(error.toString()));
      }
    });

    on<UpdateTask>((event, emit) async {
      try {
        emit(const TaskUpdating());
        await TaskService().setTask(event.task, event.projectId);
        emit(const TaskUpdated());
      } on Exception catch (error) {
        emit(TaskError(error.toString()));
      }
    });

    on<DeleteTask>((event, emit) async {
      try {
        emit(const TaskDeleting());
        await TaskService().deleteTask(event.taskId, event.companyId);
        emit(const TaskDeleted());
      } on Exception catch (error) {
        emit(TaskError(error.toString()));
      }
    });
  }
}
