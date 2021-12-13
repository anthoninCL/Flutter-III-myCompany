part of "register_bloc.dart";

abstract class RegisterEvent {}

class RegisterSubmitEvent extends RegisterEvent {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String companyName;
  final String companyAddress;
  final String companyZip;
  final String companyCity;
  final String companyCountry;
  final String companyContact;
  final String companyPhone;

  RegisterSubmitEvent(
      this.firstName,
      this.lastName,
      this.email,
      this.password,
      this.companyName,
      this.companyAddress,
      this.companyZip,
      this.companyCity,
      this.companyCountry,
      this.companyContact,
      this.companyPhone);
}
