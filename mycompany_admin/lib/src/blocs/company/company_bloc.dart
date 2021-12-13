import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mycompany_admin/src/models/company.dart';
import 'package:mycompany_admin/src/services/company_service.dart';

part 'company_events.dart';
part 'company_state.dart';

class CompanyBloc extends Bloc<CompanyEvent, CompanyState> {
  CompanyBloc() : super(const CompanyInitial()) {
    on<AddCompany>((event, emit) async {
      try {
        emit(const CompanyCreating());
        await CompanyService().setCompany(event.company);
        emit(const CompanyCreated());
      } on Exception catch (error) {
        emit(CompanyError(error.toString()));
      }
    });

    on<GetCompany>((event, emit) async {
      try {
        emit(const CompanyLoading());
        var company = await CompanyService().readCompany(event.companyId);
        emit(CompanyLoaded(company));
      } on Exception catch (error) {
        emit(CompanyError(error.toString()));
      }
    });

    on<UpdateCompany>((event, emit) async {
      try {
        emit(const CompanyUpdating());
        await CompanyService().setCompany(event.company);
        emit(const CompanyUpdated());
      } on Exception catch (error) {
        emit(CompanyError(error.toString()));
      }
    });

    on<DeleteCompany>((event, emit) async {
      try {
        emit(const CompanyDeleting());
        await CompanyService().deleteCompany(event.companyId);
        emit(const CompanyDeleted());
      } on Exception catch (error) {
        emit(CompanyError(error.toString()));
      }
    });
  }
}
