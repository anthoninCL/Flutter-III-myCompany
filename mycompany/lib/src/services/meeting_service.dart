import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mycompany/src/models/meeting.dart';
import 'package:mycompany/src/services/user_service.dart';

class MeetingService {
  CollectionReference meetings =
      FirebaseFirestore.instance.collection('meetings');

  //Add & Update Method
  Future<void> setMeeting(Meeting meeting) async {
    Map<String, dynamic> map = meeting.toMap();

    if (meeting.users.isNotEmpty) {
      List<String> usersId = [];
      for (var user in meeting.users) {
        usersId.add(user.id);
      }
      map["users"] = usersId;
    }

    return (meetings
        .doc(meeting.id)
        .set(map)
        .catchError((error) => print(error)));
  }

  //Delete
  Future<void> deleteMeeting(String meetingId) {
    return (meetings
        .doc(meetingId)
        .delete()
        .catchError((error) => print(error)));
  }

  //Read

  Future<Meeting> readMeeting(String meetingId) async {
    var collection = FirebaseFirestore.instance.collection('meetings');
    var docSnapshot = await collection.doc(meetingId).get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      if (data != null) {
        List<dynamic> usersId = data["users"];
        data["users"] = await UserService().readUsers(usersId.cast<String>());
        return (Meeting.fromMap(data));
      }
    }
    throw Error();
  }

  Future<List<Meeting>> readMeetings(List<String> meetingsId) async {
    List<Meeting> meetings = [];
    var collection = FirebaseFirestore.instance.collection('meetings');
    if (meetingsId.isEmpty) {
      return meetings;
    }
    var docSnapshot =
        await collection.where(FieldPath.documentId, whereIn: meetingsId).get();
    List<QueryDocumentSnapshot> docs = docSnapshot.docs;
    for (var doc in docs) {
      if (doc.data() != null) {
        Map<String, dynamic>? data = doc.data() as Map<String, dynamic>;
        List<dynamic> usersId = data["users"];
        data["users"] = await UserService().readUsers(usersId.cast<String>());
        meetings.add(Meeting.fromMap(data));
      }
    }
    return meetings;
  }

  Future<List<Meeting>> readMeetingsFromUser(String userId) async {
    List<Meeting> meetings = [];
    var collection = FirebaseFirestore.instance.collection('meetings');
    var docSnapshot =
        await collection.where('users', arrayContains: userId).get();
    List<QueryDocumentSnapshot> docs = docSnapshot.docs;
    for (var doc in docs) {
      if (doc.data() != null) {
        Map<String, dynamic>? data = doc.data() as Map<String, dynamic>;
        List<dynamic> usersId = data["users"];
        data["users"] = await UserService().readUsers(usersId.cast<String>());
        meetings.add(Meeting.fromMap(data));
      }
    }
    return meetings;
  }
}
