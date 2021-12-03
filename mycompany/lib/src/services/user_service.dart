import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mycompany/src/models/company.dart';
import 'package:mycompany/src/models/user.dart';
import 'package:mycompany/src/services/company_service.dart';

class UserService {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  //Create - Register
  Future<String> registerUser(
      String email, String password, UserFront user, String companyId) async {
    try {
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        if (value.user != null) {
          user.id = value.user!.uid;
          users.doc(value.user!.uid).set(user.toMap());
          Company company = await CompanyService().readCompany(companyId);
          company.users.add(value.user!.uid);
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
      return (UserFront.fromMap(data!));
    }
    throw Error();
  }

  //Update
  Future<void> updateUser(UserFront user) {
    return (users
        .doc(user.id)
        .set(user.toMap())
        .catchError((error) => print(error)));
  }
}
