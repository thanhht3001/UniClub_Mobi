class ActivitiesEntityModel{
  int id;
  int competitionActivityId;
  String name;
  String imageUrl;

  ActivitiesEntityModel({
    required this.id,
    required this.competitionActivityId,
    required this.name,
    required this.imageUrl
  });

  factory ActivitiesEntityModel.fromJson(Map<String, dynamic> json){
    int id = json['id'] ?? 0;
    int competitionActivityId= json['competition_activity_id'] ?? 0;
    String name = json['name'] ?? '';
    String imageUrl = json['image_url'] ?? '';

    return ActivitiesEntityModel(
      id: id, 
      competitionActivityId: competitionActivityId, 
      name: name, 
      imageUrl: imageUrl
    );  
  }
}