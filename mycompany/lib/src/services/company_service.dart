import 'package:mycompany/src/models/company.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mycompany/src/models/pole.dart';
import 'package:mycompany/src/models/user.dart';
import 'package:mycompany/src/services/pole_service.dart';
import 'package:mycompany/src/services/user_service.dart';

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
  Future<void> deleteCompany(String companyId) {
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
