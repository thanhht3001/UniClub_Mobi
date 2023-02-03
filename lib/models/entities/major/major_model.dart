class MajorModel{
  int id;
  String name;
  bool status;

  MajorModel({required this.id, required this.name, required this.status});

  factory MajorModel.fromJson(Map<String, dynamic> json){
    int id = json['id'] ?? 0;
    String name = json['name'] ?? '';
    bool status = json['status'] ?? false;

    return MajorModel(id: id, name: name, status: status);
  }
}