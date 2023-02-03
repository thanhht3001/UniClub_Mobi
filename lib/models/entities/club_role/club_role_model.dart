class ClubRoleModel{
  int id;
  String name;

  ClubRoleModel({required this.id, required this.name});

  factory ClubRoleModel.fromJson(Map<String, dynamic> json){
    int id = json["id"] ?? '';
    String name = json["name"] ?? '';

    return ClubRoleModel(id: id, name: name);
  }
}