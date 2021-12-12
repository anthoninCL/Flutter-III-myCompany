part of "create_company_bloc.dart";

@immutable
abstract class CreateCompanyState {
  const CreateCompanyState();
}

class CreateCompanyInitial extends CreateCompanyState {
  const CreateCompanyInitial();
}

class CreateCompanyLoading extends CreateCompanyState {
  const CreateCompanyLoading();
}

class CreateCompanyLoaded extends CreateCompanyState {
  const CreateCompanyLoaded();
}

class CreateCompanyError extends CreateCompanyState {
  final String error;

  const CreateCompanyError(this.error);
}