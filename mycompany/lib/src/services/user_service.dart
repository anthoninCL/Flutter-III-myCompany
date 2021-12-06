import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mycompany/src/models/company.dart';
import 'package:mycompany/src/models/user.dart';
import 'package:mycompany/src/services/company_service.dart';
import 'package:mycompany/src/services/pole_service.dart';
import 'package:mycompany/src/services/project_service.dart';

class UserService {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  //Create - Register
  Future<String> registerUser(
      String email, String password, UserFront user, String companyId) async {
    try {
      return FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        if (value.user != null) {
          user.id = value.user!.uid;
          users.doc(value.user!.uid).set(user.toMap());
          Company company = await CompanyService().readCompany(companyId);
          company.users.add(user);
          CompanyService().setCompany(company);
          return (value.user!.uid);
        } else {
          throw Error();
        }
      });
    } catch (err) {
      print(err.toString());
    }
    throw Error();
  }

  //Sign In
  Future<String> signInUser(String email, String password) async {
    try {
      UserCredential result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      final User user = result.user!;

      return user.uid;
    } catch (err) {
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
    var docSnapshot =
        await collection.where(FieldPath.documentId, whereIn: usersId).get();
    List<QueryDocumentSnapshot> docs = docSnapshot.docs;
    for (var doc in docs) {
      if (doc.data() != null) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        List<dynamic> polesIds = data["poles"];
        List<dynamic> projectsIds = data["projects"];

        data["poles"] = await PoleService().readPoles(polesIds.cast<String>());
        data["projects"] =
            await ProjectService().readProjects(projectsIds.cast<String>());

        users.add(UserFront.fromMap(data));
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
}
