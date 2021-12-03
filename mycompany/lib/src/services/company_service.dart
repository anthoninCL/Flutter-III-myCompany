import 'package:mycompany/src/models/company.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CompanyService {
  CollectionReference companies =
      FirebaseFirestore.instance.collection('companies');

  //Add & Update Method
  Future<void> setCompany(Company company) {
    return (companies
        .doc(company.id)
        .set(company.toMap())
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
      return (Company.fromMap(data!));
    }
    throw Error();
  }
}
