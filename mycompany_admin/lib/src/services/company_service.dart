import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mycompany_admin/src/models/company.dart';
import 'package:mycompany_admin/src/models/meeting.dart';
import 'package:mycompany_admin/src/models/pole.dart';
import 'package:mycompany_admin/src/models/project.dart';
import 'package:mycompany_admin/src/models/user.dart';
import 'package:mycompany_admin/src/services/meeting_service.dart';
import 'package:mycompany_admin/src/services/pole_service.dart';
import 'package:mycompany_admin/src/services/project_service.dart';
import 'package:mycompany_admin/src/services/user_service.dart';

class CompanyService {
  CollectionReference companies =
      FirebaseFirestore.instance.collection('companies');

  //Add & Update Method
  Future<void> setCompany(Company company) {
    Map<String, dynamic> map = company.toMap();

    if (company.poles.isNotEmpty) {
      List<String> polesID = [];
      for (var pole in company.poles) {
        polesID.add(pole.id);
      }
      map["poles"] = polesID;
    }

    if (company.users.isNotEmpty) {
      List<String> usersID = [];
      for (var user in company.users) {
        usersID.add(user.id);
      }
      map["users"] = usersID;
    }

    return (companies
        .doc(company.id)
        .set(map)
        .catchError((error) => print(error)));
  }

  //Delete
  Future<void> deleteCompany(String companyId) async {
    Company company = await readCompany(companyId);
    List<Meeting> meetings =
        await MeetingService().readMeetingsFromCompany(companyId);

    for (var meeting in meetings) {
      MeetingService().deleteMeeting(meeting.id);
    }

    for (var pole in company.poles) {
      PoleService().deletePole(pole.id, companyId);
    }

    List<Project> projects =
        await ProjectService().readProjectsFromCompany(companyId);
    for (var project in projects) {
      ProjectService().deleteProject(project.id);
    }

    for (var user in company.users) {
      await UserService().deleteUser(user.id);
    }

    return (companies
        .doc(companyId)
        .delete()
        .catchError((error) => print(error)));
  }

  //Read

  Future<Company> readCompany(String companyId) async {
    var collection = FirebaseFirestore.instance.collection('companies');
    var docSnapshot = await collection.doc(companyId).get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();

      if (data != null) {
        var polesId = data["poles"] as List;
        var usersId = data["users"] as List;
        if (polesId.isEmpty) {
          List<Pole> emptyPoles = [];
          data["poles"] = emptyPoles;
        } else {
          data["poles"] = await PoleService().readPoles(polesId.cast<String>());
        }
        if (usersId.isEmpty) {
          List<UserFront> emptyUsers = [];
          data["users"] = emptyUsers;
        } else {
          data["users"] = await UserService().readUsers(usersId.cast<String>());
        }

        return (Company.fromMap(data));
      }
    }
    throw Error();
  }
}
