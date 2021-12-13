part of "company_bloc.dart";

@immutable
abstract class CompanyState {
  const CompanyState();
}

class CompanyInitial extends CompanyState {
  const CompanyInitial();
}

class CompanyCreating extends CompanyState {
  const CompanyCreating();
}

class CompanyCreated extends CompanyState {
  const CompanyCreated();
}

class CompanyLoading extends CompanyState {
  const CompanyLoading();
}

class CompanyLoaded extends CompanyState {
  final Company company;

  const CompanyLoaded(this.company);
}

class CompanyUpdating extends CompanyState {
  const CompanyUpdating();
}

class CompanyUpdated extends CompanyState {
  const CompanyUpdated();
}

class CompanyDeleting extends CompanyState {
  const CompanyDeleting();
}

class CompanyDeleted extends CompanyState {
  const CompanyDeleted();
}

class CompanyError extends CompanyState {
  final String error;

  const CompanyError(this.error);
}
