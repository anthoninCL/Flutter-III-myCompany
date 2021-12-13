import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mycompany_admin/src/models/meeting.dart';
import 'package:mycompany_admin/src/services/meeting_service.dart';

part 'meetings_events.dart';
part 'meetings_state.dart';

class MeetingBloc extends Bloc<MeetingsEvent, MeetingsState> {
  MeetingBloc() : super(const MeetingInitial()) {
    on<AddMeeting>((event, emit) async {
      try {
        emit(const MeetingCreating());
        await MeetingService().setMeeting(event.meeting);
        emit(const MeetingCreated());
      } on Exception catch (error) {
        emit(MeetingError(error.toString()));
      }
    });

    on<GetMeeting>((event, emit) async {
      try {
        emit(const MeetingLoading());
        var meeting = await MeetingService().readMeeting(event.meetingId);
        emit(MeetingLoaded(meeting));
      } on Exception catch (error) {
        emit(MeetingError(error.toString()));
      }
    });

    on<GetMeetings>((event, emit) async {
      try {
        emit(const MeetingLoading());
        var meetings = await MeetingService().readMeetings(event.meetingsId);
        emit(MeetingsLoaded(meetings));
      } on Exception catch (error) {
        emit(MeetingError(error.toString()));
      }
    });

    on<GetMeetingsUser>((event, emit) async {
      try {
        emit(const MeetingLoading());
        var meetings = await MeetingService().readMeetingsFromUser(event.userId);
        emit(MeetingsLoaded(meetings));
      } on Exception catch (error) {
        emit(MeetingError(error.toString()));
      }
    });

    on<UpdateMeeting>((event, emit) async {
      try {
        emit(const MeetingUpdating());
        await MeetingService().setMeeting(event.meeting);
        emit(const MeetingUpdated());
      } on Exception catch (error) {
        emit(MeetingError(error.toString()));
      }
    });

    on<DeleteMeeting>((event, emit) async {
      try {
        emit(const MeetingDeleting());
        await MeetingService().deleteMeeting(event.meetingId);
        emit(const MeetingDeleted());
      } on Exception catch (error) {
        emit(MeetingError(error.toString()));
      }
    });
  }
}
