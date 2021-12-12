part of "create_company_bloc.dart";

abstract class CreateCompanyEvent {}

class CreateCompanySubmitEvent extends CreateCompanyEvent {
  final Company company;

  CreateCompanySubmitEvent(this.company);
}