part of "projects_bloc.dart";

@immutable
abstract class ProjectsState {
  const ProjectsState();
}

class ProjectInitial extends ProjectsState {
  const ProjectInitial();
}

class ProjectCreating extends ProjectsState {
  const ProjectCreating();
}

class ProjectCreated extends ProjectsState {
  const ProjectCreated();
}

class ProjectLoading extends ProjectsState {
  const ProjectLoading();
}

class ProjectLoaded extends ProjectsState {
  final Project project;

  const ProjectLoaded(this.project);
}

class ProjectsLoaded extends ProjectsState {
  final List<Project> projects;

  const ProjectsLoaded(this.projects);
}

class ProjectUpdating extends ProjectsState {
  const ProjectUpdating();
}

class ProjectUpdated extends ProjectsState {
  const ProjectUpdated();
}

class ProjectDeleting extends ProjectsState {
  const ProjectDeleting();
}

class ProjectDeleted extends ProjectsState {
  const ProjectDeleted();
}

class ProjectError extends ProjectsState {
  final String error;

  const ProjectError(this.error);
}
