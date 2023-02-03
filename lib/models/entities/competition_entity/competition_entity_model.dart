class CompetitionEntityModel {
  int id;
  int competitionId;
  int entityTypeId;
  String entityTypeName;
  String name;
  String imageUrl;
  String website;
  String email;
  String description;

  CompetitionEntityModel(
      {required this.id,
      required this.competitionId,
      required this.entityTypeId,
      required this.entityTypeName,
      required this.name,
      required this.imageUrl,
      required this.website,
      required this.email,
      required this.description});

  factory CompetitionEntityModel.fromJson(Map<String, dynamic> json) {
    int id = json['id'] ?? 0;
    int competitionId = json['competition_id'] ?? 0;
    int entityTypeId = json['entity_type_id'] ?? 0;
    String entityTypeName = json['entity_type_name'] ?? '';
    String name = json['name'] ?? '';
    String imageUrl = json['image_url'] ?? '';
    String website = json['website'] ?? '';
    String email = json['email'] ?? '';
    String description = json['description'] ?? '';

    return CompetitionEntityModel(
        id: id,
        competitionId: competitionId,
        entityTypeId: entityTypeId,
        entityTypeName: entityTypeName,
        name: name,
        imageUrl: imageUrl,
        website: website,
        email: email,
        description: description
    );
  }
}
