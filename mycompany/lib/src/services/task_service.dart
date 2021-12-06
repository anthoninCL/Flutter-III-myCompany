import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mycompany/src/models/project.dart';
import 'package:mycompany/src/models/task.dart';
import 'package:mycompany/src/models/user.dart';
import 'package:mycompany/src/services/project_service.dart';
import 'package:mycompany/src/services/user_service.dart';

class TaskService {
  CollectionReference tasks = FirebaseFirestore.instance.collection('tasks');

  //Add & Update Method
  Future<void> setTask(Task task, String projectId) async {
    Project project = await ProjectService().readProject(projectId);
    project.tasks.add(task);
    ProjectService().setProject(project);

    return (tasks
        .doc(task.id)
        .set(task.toMap())
        .catchError((error) => print(error)));
  }

  //Delete
  Future<void> deleteTask(String taskId) {
    return (tasks.doc(taskId).delete().catchError((error) => print(error)));
  }

  //Read

  Future<Task> readTask(String taskId) async {
    var collection = FirebaseFirestore.instance.collection('tasks');
    var docSnapshot = await collection.doc(taskId).get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      if (data != null) {
        return (Task.fromMap(data));
      }
    }
    throw Error();
  }

  Future<List<Task>> readTasks(List<String> tasksId) async {
    List<Task> tasks = [];
    var collection = FirebaseFirestore.instance.collection('tasks');
    if (tasksId.isEmpty) {
      return tasks;
    }
    var docSnapshot =
        await collection.where(FieldPath.documentId, whereIn: tasksId).get();
    List<QueryDocumentSnapshot> docs = docSnapshot.docs;
    for (var doc in docs) {
      if (doc.data() != null) {
        Map<String, dynamic>? data = doc.data() as Map<String, dynamic>;
        tasks.add(Task.fromMap(data));
      }
    }
    return tasks;
  }

  Future<List<Task>> readTasksFromUser(String userId) async {
    List<Task> tasks = [];
    var collection = FirebaseFirestore.instance.collection('tasks');
    var docSnapshot = await collection.where('user', isEqualTo: userId).get();
    List<QueryDocumentSnapshot> docs = docSnapshot.docs;
    for (var doc in docs) {
      if (doc.data() != null) {
        Map<String, dynamic>? data = doc.data() as Map<String, dynamic>;

        tasks.add(Task.fromMap(data));
      }
    }
    return tasks;
  }
}
