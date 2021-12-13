class Task {
  String id;
  String name;
  String description;
  double estimatedTime;
  String state;
  int? deadLine;
  String? user;

  Task(this.id, this.name, this.description, this.estimatedTime, this.state,
      {this.deadLine, this.user});

  bool operator ==(Object o) => o is Task && o.id == id;

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "description": description,
      "estimatedTime": estimatedTime,
      "state": state,
      "deadLine": deadLine,
      "user": user,
    };
  }

  Task.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        name = map["name"],
        description = map["description"],
        estimatedTime = map["estimatedTime"],
        state = map["state"],
        deadLine = map["deadLine"],
        user = map["user"];

  @override
  String toString() {
    return 'Task: {name: ${name}, user: $user }';
  }
}
