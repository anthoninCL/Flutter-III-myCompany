import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mycompany/src/models/meeting.dart';
import 'package:mycompany/src/services/meeting_service.dart';

part 'meeting_event.dart';
part 'meeting_state.dart';

class MeetingBloc extends Bloc<MeetingEvent, MeetingState> {
  MeetingBloc() : super(const MeetingInitial()) {
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

    on<GetMeetingsFromUser>((event, emit) async {
      try {
        emit(const MeetingLoading());
        var meetings = await MeetingService().readMeetingsFromUser(event.userId);
        emit(MeetingsLoaded(meetings));
      } on Exception catch (error) {
        emit(MeetingError(error.toString()));
      }
    });
  }

}