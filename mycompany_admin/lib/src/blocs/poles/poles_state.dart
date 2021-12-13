part of "poles_bloc.dart";

@immutable
abstract class PolesState {
  const PolesState();
}

class PoleInitial extends PolesState {
  const PoleInitial();
}

class PoleCreating extends PolesState {
  const PoleCreating();
}

class PoleCreated extends PolesState {
  const PoleCreated();
}

class PoleLoading extends PolesState {
  const PoleLoading();
}

class PoleLoaded extends PolesState {
  final Pole pole;

  const PoleLoaded(this.pole);
}

class PolesLoaded extends PolesState {
  final List<Pole> poles;

  const PolesLoaded(this.poles);
}

class PoleUpdating extends PolesState {
  const PoleUpdating();
}

class PoleUpdated extends PolesState {
  const PoleUpdated();
}

class PoleDeleting extends PolesState {
  const PoleDeleting();
}

class PoleDeleted extends PolesState {
  const PoleDeleted();
}

class PoleError extends PolesState {
  final String error;

  const PoleError(this.error);
}
