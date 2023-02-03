import 'package:intl/intl.dart';
import '/models/entities/activities_entity/activities_entity_model.dart';
import '/models/entities/member/member_takes_activity_model.dart';
import '/models/enums/competition_activity_status.dart';
import '/models/enums/priority_status.dart';

class CompetitionActivityDetailModel {
  int id;
  int competitionId;
  int seedsPoint;
  DateTime createTime;
  DateTime ending;
  String name;
  String description;
  PriorityStatus priority;
  CompetitionActivityStatus status;
  int numOfMember;
  int creatorId;
  String creatorName;
  String creatorEmail;
  List<ActivitiesEntityModel> activitiesEntities;
  List<MemberTakesActivityModel> memberTakesActivities;

  CompetitionActivityDetailModel(
      {required this.id,
      required this.competitionId,
      required this.seedsPoint,
      required this.createTime,
      required this.ending,
      required this.name,
      required this.description,
      required this.priority,
      required this.status,
      required this.numOfMember,
      required this.creatorId,
      required this.creatorName,
      required this.creatorEmail,
      required this.activitiesEntities,
      required this.memberTakesActivities});

  factory CompetitionActivityDetailModel.fromJson(Map<String, dynamic> json) {
    int id = json['id'];
    int competitionId = json['competition_id'];
    int seedsPoint = json['seeds_point'];
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
    //
    String name = json['name'];
    String description = json['description'];
    //
    PriorityStatus priority = PriorityStatus.values[json['priority']];
    CompetitionActivityStatus status =
        CompetitionActivityStatus.values[json['competition_activity_status']];
    //
    int numOfMember = json['num_of_member'];
    int creatorId = json['creator_id'];
    String creatorName = json['creator_name'];
    String creatorEmail = json['creator_email'];
    //
    List<ActivitiesEntityModel> activitiesEntities = [];
    if (json['activities_entities'] != null) {
      json['activities_entities'].forEach((v) {
        activitiesEntities.add(new ActivitiesEntityModel.fromJson(v));
      });
    }
    //
    List<MemberTakesActivityModel> memberTakesActivities = [];
    if (json['member_takes_activities'] != null) {
      json['member_takes_activities'].forEach((v) {
        memberTakesActivities.add(new MemberTakesActivityModel.fromJson(v));
      });
    }

    return CompetitionActivityDetailModel(
        id: id,
        competitionId: competitionId,
        seedsPoint: seedsPoint,
        createTime: createTime,
        ending: ending,
        name: name,
        description: description,
        priority: priority,
        status: status,
        numOfMember: numOfMember,
        creatorId: creatorId,
        creatorName: creatorName,
        creatorEmail: creatorEmail,
        activitiesEntities: activitiesEntities,
        memberTakesActivities: memberTakesActivities);
  }
}
