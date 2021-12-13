class Pole {
  String id;
  String name;
  String color;
  String companyId;

  Pole(this.id, this.name, this.color, this.companyId);

  Map<String, dynamic> toMap() {
    return {"id": id, "name": name, "color": color, "companyId": companyId};
  }

  Pole.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        name = map["name"],
        color = map["color"],
        companyId = map["companyId"];

  @override
  String toString() {
    return 'Pole: name: $name';
  }
}
