class CompetitionRoleModel {
  int id;
  String name;

  CompetitionRoleModel({required this.id, required this.name});

  factory CompetitionRoleModel.fromJson(Map<String, dynamic> json) {
    int id = json['id'];
    String name = json['name'];

    return CompetitionRoleModel(id: id, name: name);
  }
}
