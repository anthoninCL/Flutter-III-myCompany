import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mycompany_admin/src/models/project.dart';
import 'package:mycompany_admin/src/services/project_service.dart';

part 'projects_events.dart';
part 'projects_state.dart';

class ProjectBloc extends Bloc<ProjectsEvent, ProjectsState> {
  ProjectBloc() : super(const ProjectInitial()) {
    on<AddProject>((event, emit) async {
      try {
        emit(const ProjectCreating());
        await ProjectService().setProject(event.project);
        emit(const ProjectCreated());
      } on Exception catch (error) {
        emit(ProjectError(error.toString()));
      }
    });

    on<GetProject>((event, emit) async {
      try {
        emit(const ProjectLoading());
        var project = await ProjectService().readProject(event.projectId);
        emit(ProjectLoaded(project));
      } on Exception catch (error) {
        emit(ProjectError(error.toString()));
      }
    });

    on<GetProjects>((event, emit) async {
      try {
        emit(const ProjectLoading());
        var projects = await ProjectService().readProjects(event.projectsId);
        emit(ProjectsLoaded(projects));
      } on Exception catch (error) {
        emit(ProjectError(error.toString()));
      }
    });

    on<GetProjectsCompany>((event, emit) async {
      try {
        emit(const ProjectLoading());
        var projects = await ProjectService().readProjectsFromCompany(event.companyId);
        emit(ProjectsLoaded(projects));
      } on Exception catch (error) {
        emit(ProjectError(error.toString()));
      }
    });

    on<UpdateProject>((event, emit) async {
      try {
        emit(const ProjectUpdating());
        await ProjectService().setProject(event.project);
        emit(const ProjectUpdated());
      } on Exception catch (error) {
        emit(ProjectError(error.toString()));
      }
    });

    on<DeleteProject>((event, emit) async {
      try {
        emit(const ProjectDeleting());
        await ProjectService().deleteProject(event.projectId);
        emit(const ProjectDeleted());
      } on Exception catch (error) {
        emit(ProjectError(error.toString()));
      }
    });
  }
}
