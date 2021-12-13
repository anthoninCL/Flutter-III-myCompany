import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mycompany_admin/src/models/project.dart';
import 'package:mycompany_admin/src/models/task.dart';
import 'package:mycompany_admin/src/services/task_service.dart';

class ProjectService {
  CollectionReference projects =
      FirebaseFirestore.instance.collection('projects');

  //Add & Update Method
  Future<void> setProject(Project project) {
    Map<String, dynamic> map = project.toMap();

    if (project.tasks.isNotEmpty) {
      List<String> tasksID = [];
      for (var task in project.tasks) {
        tasksID.add(task.id);
      }
      map["tasks"] = tasksID;
    }

    return (projects
        .doc(project.id)
        .set(map)
        .catchError((error) => print(error)));
  }

  //Delete
  Future<void> deleteProject(String projectId) async {
    Project project = await ProjectService().readProject(projectId);
    for (Task task in project.tasks) {
      TaskService().deleteTask(task.id, projectId);
    }

    return (projects
        .doc(projectId)
        .delete()
        .catchError((error) => print(error)));
  }

  //Read
  Future<Project> readProject(String projectId) async {
    var collection = FirebaseFirestore.instance.collection('projects');
    var docSnapshot = await collection.doc(projectId).get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      if (data != null) {
        List<dynamic> tasksId = data["tasks"];
        data["tasks"] = await TaskService().readTasks(tasksId.cast<String>());
        return (Project.fromMap(data));
      }
    }
    throw Error();
  }

  Future<List<Project>> readProjects(List<String> projectsId) async {
    List<Project> projects = [];
    if (projectsId.isEmpty) {
      return projects;
    }
    List<List<String>> subList = [];
    for (var i = 0; i < projectsId.length; i += 10) {
      subList.add(projectsId.sublist(
          i, i + 10 > projectsId.length ? projectsId.length : i + 10));
    }
    for (var element in subList) {
      var collection = FirebaseFirestore.instance.collection('projects');
      var docSnapshot =
          await collection.where(FieldPath.documentId, whereIn: element).get();
      List<QueryDocumentSnapshot> docs = docSnapshot.docs;
      for (var doc in docs) {
        if (doc.data() != null) {
          Map<String, dynamic>? data = doc.data() as Map<String, dynamic>;
          var tasksId = data["tasks"] as List;
          if (tasksId.isEmpty) {
            List<Task> emptyTasks = [];
            data["tasks"] = emptyTasks;
          } else {
            data["tasks"] =
                await TaskService().readTasks(tasksId.cast<String>());
          }
          projects.add(Project.fromMap(data));
        }
      }
    }
    return projects;
  }

  Future<List<Project>> readProjectsFromCompany(String companyId) async {
    List<Project> projects = [];
    var collection = FirebaseFirestore.instance.collection('projects');
    var docSnapshot =
        await collection.where('companyId', isEqualTo: companyId).get();
    List<QueryDocumentSnapshot> docs = docSnapshot.docs;
    for (var doc in docs) {
      if (doc.data() != null) {
        Map<String, dynamic>? data = doc.data() as Map<String, dynamic>;
        var tasksId = data["tasks"] as List;
        if (tasksId.isEmpty) {
          List<Task> emptyTasks = [];
          data["tasks"] = emptyTasks;
        } else {
          data["tasks"] = await TaskService().readTasks(tasksId.cast<String>());
        }
        projects.add(Project.fromMap(data));
      }
    }
    return projects;
  }
}
