import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mycompany_admin/src/exceptions/email_already_used_exception.dart';
import 'package:mycompany_admin/src/exceptions/invalid_email_exception.dart';
import 'package:mycompany_admin/src/exceptions/user_not_found_exception.dart';
import 'package:mycompany_admin/src/exceptions/weak_password_exception.dart';
import 'package:mycompany_admin/src/exceptions/wrong_password_exception.dart';
import 'package:mycompany_admin/src/models/company.dart';
import 'package:mycompany_admin/src/models/meeting.dart';
import 'package:mycompany_admin/src/models/project.dart';
import 'package:mycompany_admin/src/models/task.dart';
import 'package:mycompany_admin/src/models/user.dart';
import 'package:mycompany_admin/src/services/meeting_service.dart';
import 'package:mycompany_admin/src/services/pole_service.dart';
import 'package:mycompany_admin/src/services/project_service.dart';
import 'package:mycompany_admin/src/services/task_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'company_service.dart';

class UserService {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  //Create - Register
  Future<String> registerUser(
      String email, String password, UserFront user, String companyId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      if (userCredential.user != null) {
        user.id = userCredential.user!.uid;
        users.doc(userCredential.user!.uid).set(user.toMap());
        if (companyId.isNotEmpty) {
          Company company = await CompanyService().readCompany(companyId);
          company.users.add(user);
          CompanyService().setCompany(company);
        }
        await prefs.setString("userToken", user.id);
        await prefs.setString("companyId", user.companyId);
        return user.id;
      } else {
        throw Error();
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == 'weak-password') {
        throw WeakPasswordException();
      } else if (err.code == 'email-already-in-use') {
        throw EmailAlreadyUsedException();
      }
    }
    throw Error();
  }

  //Sign In
  Future<String> signInUser(String email, String password) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      UserCredential result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      final User user = result.user!;

      await prefs.setString("userToken", user.uid);
      UserFront userFront = await UserService().readUser(user.uid);
      if (userFront.role != "admin") {
        throw NotAdminException();
      }
      await prefs.setString("companyId", userFront.companyId);
      return user.uid;
    } on FirebaseAuthException catch (err) {
      if (err.code == 'invalid-email') {
        throw InvalidEmailException();
      } else if (err.code == 'user-not-found') {
        throw UserNotFoundException();
      } else if (err.code == 'wrong-password') {
        throw WrongPasswordException();
      }
      throw Error();
    }
  }

  //Read
  Future<UserFront> readUser(String userId) async {
    var collection = FirebaseFirestore.instance.collection('users');
    var docSnapshot = await collection.doc(userId).get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      if (data != null) {
        List<dynamic> polesIds = data["poles"];
        List<dynamic> projectsIds = data["projects"];
        data["poles"] = await PoleService().readPoles(polesIds.cast<String>());
        data["projects"] =
            await ProjectService().readProjects(projectsIds.cast<String>());

        return (UserFront.fromMap(data));
      }
    }
    throw Error();
  }

  //Read
  Future<List<UserFront>> readUsers(List<String> usersId) async {
    List<UserFront> users = [];
    var collection = FirebaseFirestore.instance.collection('users');
    if (usersId.isEmpty) {
      return users;
    }
    List<List<String>> subList = [];
    for (var i = 0; i < usersId.length; i += 10) {
      subList.add(usersId.sublist(
          i, i + 10 > usersId.length ? usersId.length : i + 10));
    }
    for (var element in subList) {
      var docSnapshot =
          await collection.where(FieldPath.documentId, whereIn: element).get();
      List<QueryDocumentSnapshot> docs = docSnapshot.docs;
      for (var doc in docs) {
        if (doc.data() != null) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

          List<dynamic> polesIds = data["poles"];
          List<dynamic> projectsIds = data["projects"];

          data["poles"] =
              await PoleService().readPoles(polesIds.cast<String>());
          data["projects"] =
              await ProjectService().readProjects(projectsIds.cast<String>());

          users.add(UserFront.fromMap(data));
        }
      }
    }
    return users;
  }

  //Update
  Future<void> updateUser(UserFront user) {
    Map<String, dynamic> map = user.toMap();

    List<String> projectsId =
        user.projects.map((project) => project.id).toList();
    List<String> polesId = user.poles.map((pole) => pole.id).toList();

    map["poles"] = polesId;
    map["projects"] = projectsId;

    return (users.doc(user.id).set(map).catchError((error) => print(error)));
  }

  //Delete
  Future<void> deleteUser(String userId) async {
    UserFront user = await readUser(userId);

    Company company = await CompanyService().readCompany(user.companyId);
    final userIndex = company.users.indexWhere((usr) => usr.id == userId);
    if (userIndex != -1) {
      company.users.removeAt(userIndex);
      CompanyService().setCompany(company);
    }

    List<Meeting> meetings =
        await MeetingService().readMeetingsFromUser(userId);
    for (var meeting in meetings) {
      final idx = meeting.users.indexWhere((usr) => usr.id == userId);
      if (idx != -1) {
        meeting.users.removeAt(idx);
        MeetingService().setMeeting(meeting);
      }
    }

    List<Project> projects =
        await ProjectService().readProjectsFromCompany(user.companyId);

    List<Task> tasks = await TaskService().readTasksFromUser(userId);
    for (var task in tasks) {
      task.user = "";
      final projectIdx = projects.indexWhere((prj) => prj.tasks.contains(task));
      if (projectIdx != -1) {
        TaskService().setTask(task, projects[projectIdx].id);
      }
    }
    return (users.doc(userId).delete().catchError((error) => print(error)));
  }
}
