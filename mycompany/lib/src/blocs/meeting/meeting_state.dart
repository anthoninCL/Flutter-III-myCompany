part of 'meeting_bloc.dart';

@immutable
abstract class MeetingState {
  const MeetingState();
}

class MeetingInitial extends MeetingState {
  const MeetingInitial();
}

class MeetingLoading extends MeetingState {
  const MeetingLoading();
}

class MeetingLoaded extends MeetingState {
  final Meeting meeting;

  const MeetingLoaded(this.meeting);
}

class MeetingsLoaded extends MeetingState {
  final List<Meeting> meetings;

  const MeetingsLoaded(this.meetings);
}

class MeetingError extends MeetingState {
  final String error;

  const MeetingError(this.error);
}