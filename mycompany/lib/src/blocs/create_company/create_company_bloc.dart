import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mycompany/src/models/company.dart';
import 'package:flutter/material.dart';
import 'package:mycompany/src/services/company_service.dart';

part 'create_company_state.dart';
part 'create_company_event.dart';

class CreateCompanyBloc extends Bloc<CreateCompanyEvent, CreateCompanyState> {
  CreateCompanyBloc() : super(const CreateCompanyInitial()) {
    on<CreateCompanySubmitEvent>((event, emit) async {
      try {
        emit(const CreateCompanyLoading());
        await CompanyService().setCompany(event.company);
        emit(const CreateCompanyLoaded());
      } on Exception catch (error) {
        emit(CreateCompanyError(error.toString()));
      }
    });
  }
}