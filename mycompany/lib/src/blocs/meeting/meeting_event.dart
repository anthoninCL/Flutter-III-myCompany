part of 'meeting_bloc.dart';

abstract class MeetingEvent {}

class GetMeetings extends MeetingEvent {
  final List<String> meetingsId;

  GetMeetings(this.meetingsId);
}

class GetMeetingsFromUser extends MeetingEvent {
  final String userId;

  GetMeetingsFromUser(this.userId);
}

class GetMeeting extends MeetingEvent {
  final String meetingId;

  GetMeeting(this.meetingId);
}