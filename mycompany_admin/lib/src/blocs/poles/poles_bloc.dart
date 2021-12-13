import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mycompany_admin/src/models/pole.dart';
import 'package:mycompany_admin/src/services/pole_service.dart';

part 'poles_events.dart';
part 'poles_state.dart';

class PoleBloc extends Bloc<PolesEvent, PolesState> {
  PoleBloc() : super(const PoleInitial()) {
    on<AddPole>((event, emit) async {
      try {
        emit(const PoleCreating());
        await PoleService().setPole(event.pole);
        emit(const PoleCreated());
      } on Exception catch (error) {
        emit(PoleError(error.toString()));
      }
    });

    on<GetPole>((event, emit) async {
      try {
        emit(const PoleLoading());
        var pole = await PoleService().readPole(event.poleId);
        emit(PoleLoaded(pole));
      } on Exception catch (error) {
        emit(PoleError(error.toString()));
      }
    });

    on<GetPoles>((event, emit) async {
      try {
        emit(const PoleLoading());
        var poles = await PoleService().readPoles(event.polesId);
        emit(PolesLoaded(poles));
      } on Exception catch (error) {
        emit(PoleError(error.toString()));
      }
    });

    on<GetPolesCompany>((event, emit) async {
      try {
        emit(const PoleLoading());
        var poles = await PoleService().readPolesFromCompany(event.companyId);
        emit(PolesLoaded(poles));
      } on Exception catch (error) {
        emit(PoleError(error.toString()));
      }
    });

    on<UpdatePole>((event, emit) async {
      try {
        emit(const PoleUpdating());
        await PoleService().setPole(event.pole);
        emit(const PoleUpdated());
      } on Exception catch (error) {
        emit(PoleError(error.toString()));
      }
    });

    on<DeletePole>((event, emit) async {
      try {
        emit(const PoleDeleting());
        await PoleService().deletePole(event.poleId, event.companyId);
        emit(const PoleDeleted());
      } on Exception catch (error) {
        emit(PoleError(error.toString()));
      }
    });
  }
}
