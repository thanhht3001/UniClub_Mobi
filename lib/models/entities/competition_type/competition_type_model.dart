class CompetitionTypeModel{
  int id;
  String typeName;

  CompetitionTypeModel({required this.id, required this.typeName});

  factory CompetitionTypeModel.fromJson(Map<String, dynamic> json){
    int id = json['id'];
    String typeName = json['type_name'];

    return CompetitionTypeModel(id: id, typeName: typeName);
  }
}