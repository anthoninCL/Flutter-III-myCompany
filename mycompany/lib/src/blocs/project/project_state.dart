part of 'project_bloc.dart';

@immutable
abstract class ProjectState {
  const ProjectState();
}

class ProjectInitial extends ProjectState {
  const ProjectInitial();
}

class ProjectLoading extends ProjectState {
  const ProjectLoading();
}

class ProjectLoaded extends ProjectState {
  final Project project;

  const ProjectLoaded(this.project);
}

class ProjectsLoaded extends ProjectState {
  final List<Project> projects;

  const ProjectsLoaded(this.projects);
}

class ProjectError extends ProjectState {
  final String error;

  const ProjectError(this.error);
}