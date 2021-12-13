class Task {
  String id;
  String name;
  String description;
  double estimatedTime;
  String priority;
  int? deadLine;
  String? user;

  Task(this.id, this.name, this.description, this.estimatedTime, this.priority,
      {this.deadLine, this.user});

  bool operator ==(Object o) => o is Task && o.id == id;

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "description": description,
      "estimatedTime": estimatedTime,
      "deadLine": deadLine,
      "user": user,
      "priority": priority,
    };
  }

  Task.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        name = map["name"],
        description = map["description"],
        estimatedTime = map["estimatedTime"],
        deadLine = map["deadLine"],
        user = map["user"],
        priority = map["priority"];

  @override
  String toString() {
    return 'Task: {name: ${name}, user: $user }';
  }
}
