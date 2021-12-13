import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mycompany/src/models/company.dart';
import 'package:mycompany/src/models/pole.dart';
import 'package:mycompany/src/services/company_service.dart';

class PoleService {
  CollectionReference poles = FirebaseFirestore.instance.collection('poles');

  //Add & Update Method
  Future<void> setPole(Pole pole) async {
    Company company = await CompanyService().readCompany(pole.companyId);
    List<String> poleIds = company.poles.map((pole) => pole.id).toList();
    if (!poleIds.contains(pole.id)) {
      company.poles.add(pole);
      CompanyService().setCompany(company);
    }

    Map<String, dynamic> map = pole.toMap();

    return (poles.doc(pole.id).set(map).catchError((error) => print(error)));
  }

  //Delete
  Future<void> deletePole(String poleId) {
    return (poles.doc(poleId).delete().catchError((error) => print(error)));
  }

  //Read

  Future<Pole> readPole(String poleId) async {
    var collection = FirebaseFirestore.instance.collection('poles');
    var docSnapshot = await collection.doc(poleId).get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      if (data != null) {
        return (Pole.fromMap(data));
      }
    }
    throw Error();
  }

  Future<List<Pole>> readPoles(List<String> polesId) async {
    List<Pole> poles = [];
    var collection = FirebaseFirestore.instance.collection('poles');
    if (polesId.isEmpty) {
      return poles;
    }
    List<List<String>> subList = [];
    for (var i = 0; i < polesId.length; i += 10) {
      subList.add(polesId.sublist(
          i, i + 10 > polesId.length ? polesId.length : i + 10));
    }
    for (var element in subList) {
      var docSnapshot =
      await collection.where(FieldPath.documentId, whereIn: element).get();
      List<QueryDocumentSnapshot> docs = docSnapshot.docs;
      for (var doc in docs) {
        if (doc.data() != null) {
          Map<String, dynamic>? data = doc.data() as Map<String, dynamic>;

          poles.add(Pole.fromMap(data));
        }
      }
    }
    return poles;
  }

  Future<List<Pole>> readPolesFromCompany(String companyId) async {
    List<Pole> poles = [];
    var collection = FirebaseFirestore.instance.collection('poles');
    var docSnapshot =
        await collection.where('companyId', isEqualTo: companyId).get();
    List<QueryDocumentSnapshot> docs = docSnapshot.docs;
    for (var doc in docs) {
      if (doc.data() != null) {
        Map<String, dynamic>? data = doc.data() as Map<String, dynamic>;

        poles.add(Pole.fromMap(data));
      }
    }
    return poles;
  }
}
