class CompetitionInMajorsModel {
  int id;
  String name;

  CompetitionInMajorsModel({required this.id, required this.name});

  factory CompetitionInMajorsModel.fromJson(Map<String, dynamic> json){
    int id = json['id'] ?? 0;
    String name = json['name'] ?? '';

    return CompetitionInMajorsModel(id: id, name: name);
  }
}
