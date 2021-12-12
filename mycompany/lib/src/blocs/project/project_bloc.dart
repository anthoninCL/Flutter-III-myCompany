import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mycompany/src/models/project.dart';
import 'package:mycompany/src/services/project_service.dart';

part 'project_event.dart';
part 'project_state.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  ProjectBloc() : super(const ProjectInitial()) {
    on<GetProjectsFromCompany>((event, emit) async {
      try {
        emit(const ProjectLoading());
        var projects = await ProjectService().readProjectsFromCompany(event.companyId);
        print(projects);
        emit(ProjectsLoaded(projects));
      } on Exception catch (error) {
        emit(ProjectError(error.toString()));
      }
    });
  }

}