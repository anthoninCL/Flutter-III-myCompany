part of 'projects_bloc.dart';

abstract class ProjectsEvent {}

class AddProject extends ProjectsEvent {
  final Project project;

  AddProject(this.project);
}

class GetProject extends ProjectsEvent {
  final String projectId;

  GetProject(this.projectId);
}

class GetProjects extends ProjectsEvent {
  final List<String> projectsId;

  GetProjects(this.projectsId);
}

class GetProjectsCompany extends ProjectsEvent {
  final String companyId;

  GetProjectsCompany(this.companyId);
}

class UpdateProject extends ProjectsEvent {
  final Project project;

  UpdateProject(this.project);
}

class DeleteProject extends ProjectsEvent {
  final String projectId;

  DeleteProject(this.projectId);
}
