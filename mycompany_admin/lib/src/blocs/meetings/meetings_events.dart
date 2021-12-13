part of 'meetings_bloc.dart';

abstract class MeetingsEvent {}

class AddMeeting extends MeetingsEvent {
  final Meeting meeting;

  AddMeeting(this.meeting);
}

class GetMeeting extends MeetingsEvent {
  final String meetingId;

  GetMeeting(this.meetingId);
}

class GetMeetings extends MeetingsEvent {
  final List<String> meetingsId;

  GetMeetings(this.meetingsId);
}

class GetMeetingsUser extends MeetingsEvent {
  final String userId;

  GetMeetingsUser(this.userId);
}

class GetMeetingsCompany extends MeetingsEvent {
  final String companyId;

  GetMeetingsCompany(this.companyId);
}

class UpdateMeeting extends MeetingsEvent {
  final Meeting meeting;

  UpdateMeeting(this.meeting);
}

class DeleteMeeting extends MeetingsEvent {
  final String meetingId;

  DeleteMeeting(this.meetingId);
}
