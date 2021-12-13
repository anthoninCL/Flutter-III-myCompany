part of 'project_bloc.dart';

abstract class ProjectEvent {}

class GetProjectsFromCompany extends ProjectEvent {
  final String companyId;

  GetProjectsFromCompany(this.companyId);
}