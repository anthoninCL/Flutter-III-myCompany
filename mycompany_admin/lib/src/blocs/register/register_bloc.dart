import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mycompany_admin/src/models/company.dart';
import 'package:mycompany_admin/src/models/user.dart';
import 'package:mycompany_admin/src/services/company_service.dart';
import 'package:mycompany_admin/src/services/user_service.dart';
import 'package:uuid/uuid.dart';

part 'register_events.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(const RegisterInitial()) {
    on<RegisterSubmitEvent>((event, emit) async {
      try {
        emit(const RegisterLoading());
        var companyId = const Uuid().v4();
        var userCreated = UserFront(
            event.firstName,
            event.lastName,
            event.email,
            "",
            "",
            "",
            "",
            "",
            "admin",
            [],
            [],
            companyId);
        var uuid = await UserService().registerUser(
            event.email, event.password, userCreated, "");
        var user = await UserService().readUser(uuid);
        var companyCreated = Company(
            companyId,
            event.companyName,
            event.companyAddress,
            event.companyZip,
            event.companyCity,
            event.companyCountry,
            event.companyContact,
            event.companyPhone,
            [user],
            []);
        await CompanyService().setCompany(companyCreated);
        emit(RegisterLoaded(user));
      } on Exception catch (error) {
        emit(RegisterError(error.toString()));
      }
    });
  }

}
