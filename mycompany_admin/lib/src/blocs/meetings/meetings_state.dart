part of "meetings_bloc.dart";

@immutable
abstract class MeetingsState {
  const MeetingsState();
}

class MeetingInitial extends MeetingsState {
  const MeetingInitial();
}

class MeetingCreating extends MeetingsState {
  const MeetingCreating();
}

class MeetingCreated extends MeetingsState {
  const MeetingCreated();
}

class MeetingLoading extends MeetingsState {
  const MeetingLoading();
}

class MeetingLoaded extends MeetingsState {
  final Meeting meeting;

  const MeetingLoaded(this.meeting);
}

class MeetingsLoaded extends MeetingsState {
  final List<Meeting> meetings;

  const MeetingsLoaded(this.meetings);
}

class MeetingUpdating extends MeetingsState {
  const MeetingUpdating();
}

class MeetingUpdated extends MeetingsState {
  const MeetingUpdated();
}

class MeetingDeleting extends MeetingsState {
  const MeetingDeleting();
}

class MeetingDeleted extends MeetingsState {
  const MeetingDeleted();
}

class MeetingError extends MeetingsState {
  final String error;

  const MeetingError(this.error);
}
