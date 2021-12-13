part of 'poles_bloc.dart';

abstract class PolesEvent {}

class AddPole extends PolesEvent {
  final Pole pole;

  AddPole(this.pole);
}

class GetPole extends PolesEvent {
  final String poleId;

  GetPole(this.poleId);
}

class GetPoles extends PolesEvent {
  final List<String> polesId;

  GetPoles(this.polesId);
}

class GetPolesCompany extends PolesEvent {
  final String companyId;

  GetPolesCompany(this.companyId);
}

class UpdatePole extends PolesEvent {
  final Pole pole;

  UpdatePole(this.pole);
}

class DeletePole extends PolesEvent {
  final String poleId;
  final String companyId;

  DeletePole(this.poleId, this.companyId);
}
