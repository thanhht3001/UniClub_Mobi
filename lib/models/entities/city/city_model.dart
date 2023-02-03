class CityModel {
  int id;
  String name;
  String description;
  bool status;

  CityModel({required this.id, required this.name, required this.description, required this.status});

  factory CityModel.fromJson(Map<String, dynamic> json){
    int id = json['id'] ?? 0;
    String name = json['name'] ?? '';
    String description = json['description'] ?? '';
    bool  status = json['status'] ?? false;

    return CityModel(
      id: id,
      name: name,
      description: description,
      status: status
    );
  }

  static CityModel fromJsonModel(Map<String, dynamic> json) => CityModel.fromJson(json);  
}