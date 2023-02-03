class UniversityModel{
  int id;
  int cityId;
  String uniCode;
  String name;
  String email;
  String description;
  String phone;
  DateTime founding;
  String opening;
  String closing;
  bool status;

  UniversityModel({
    required this.id,
    required this.cityId,
    required this.uniCode,
    required this.name,
    required this.email,
    required this.description,
    required this.phone,
    required this.founding,
    required this.opening,
    required this.closing,
    required this.status
  });

  factory UniversityModel.fromJson(Map<String, dynamic> json){
    int id = json['id'];
    int cityId = json['city_id'];
    String uniCode = json['uni_code'];
    String name = json['name'];
    String email = json['email'];
    String description = json['description'];
    String phone = json['phone'];
    DateTime founding = DateTime.parse(json['founding']);
    String opening = json['opening'];
    String closing = json['closing'];
    bool status = json['status'];

    return UniversityModel(
      id: id, 
      cityId: cityId, 
      uniCode: uniCode, 
      name: name, 
      email: email, 
      description: description, 
      phone: phone, 
      founding: founding, 
      opening: opening, 
      closing: closing, 
      status: status
    );
  }
}