import 'package:intl/intl.dart';
import '/models/enums/competition_activity_status.dart';
import '/models/enums/priority_status.dart';
import '../activities_entity/activities_entity_model.dart';

class CompetitionActivityModel {
  int id;
  int competitionId;
  DateTime createTime;
  DateTime ending;
  String name;
  PriorityStatus priority;
  CompetitionActivityStatus status;
  int creatorId;
  String creatorName;
  List<ActivitiesEntityModel> activitiesEntity;

  CompetitionActivityModel(
      {required this.id,
      required this.competitionId,
      required this.createTime,
      required this.ending,
      required this.name,
      required this.creatorId,
      required this.creatorName,
      required this.priority,
      required this.status,
      required this.activitiesEntity});

  factory CompetitionActivityModel.fromJson(Map<String, dynamic> json) {
    int id = json['id'];
    int competitionId = json['competition_id'];
    //
    String createTimeString = json['create_time'];
    createTimeString = createTimeString.replaceAll("T", " ");
    createTimeString = createTimeString.replaceAll("Z", "");
    DateTime createTime =
        DateFormat("yyyy-MM-dd HH:mm:ss").parse(createTimeString);
    //
    String endingString = json['ending'];
    endingString = endingString.replaceAll("T", " ");
    endingString = endingString.replaceAll("Z", "");
    DateTime ending = DateFormat("yyyy-MM-dd HH:mm:ss").parse(endingString);

    String name = json['name'];
    PriorityStatus priority = PriorityStatus.values[json['priority']];
    CompetitionActivityStatus status =
        CompetitionActivityStatus.values[json['competition_activity_status']];
    int creatorId = json['creator_id'];
    String creatorName = json['creator_name'];
    //
    List<ActivitiesEntityModel> activitiesEntity = [];
    if (json['activities_entities'] != null) {
      json['activities_entities'].forEach((v) {
        activitiesEntity.add(new ActivitiesEntityModel.fromJson(v));
      });
    }

    return CompetitionActivityModel(
        id: id,
        competitionId: competitionId,
        createTime: createTime,
        ending: ending,
        name: name,
        creatorId: creatorId,
        creatorName: creatorName,
        priority: priority,
        status: status,
        activitiesEntity: activitiesEntity);
  }
}
