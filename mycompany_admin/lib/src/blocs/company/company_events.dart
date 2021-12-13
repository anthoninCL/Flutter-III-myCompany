part of 'company_bloc.dart';

abstract class CompanyEvent {}

class AddCompany extends CompanyEvent {
  final Company company;

  AddCompany(this.company);
}

class GetCompany extends CompanyEvent {
  final String companyId;

  GetCompany(this.companyId);
}

class UpdateCompany extends CompanyEvent {
  final Company company;

  UpdateCompany(this.company);
}

class DeleteCompany extends CompanyEvent {
  final String companyId;

  DeleteCompany(this.companyId);
}
