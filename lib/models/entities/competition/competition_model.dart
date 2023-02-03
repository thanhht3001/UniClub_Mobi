import 'package:intl/intl.dart';
import 'package:unicec_mobi/models/entities/competition/competition_in_clubs_model.dart';
import 'package:unicec_mobi/models/entities/competition/competition_in_majors_model.dart';

import '../../enums/competition_scope_status.dart';
import '../../enums/competition_status.dart';
import '../competition_entity/competition_entity_model.dart';

class CompetitionModel {
  int id;
  int universityId;
  String name;
  int competitionTypeId;
  String competitionTypeName;
  DateTime createTime;
  DateTime startTime;
  bool isSponsor;
  bool isEvent;
  CompetitionScopeStatus scope;
  CompetitionStatus status;
  int view;
  List<CompetitionInClubsModel> clubsInCompetition;
  List<CompetitionInMajorsModel> majorsInCompetition;
  List<CompetitionEntityModel> competitionEntities;

  CompetitionModel(
      {required this.id,
      required this.universityId,
      required this.name,
      required this.competitionTypeId,
      required this.competitionTypeName,
      required this.createTime,
      required this.startTime,
      required this.isSponsor,
      required this.scope,
      required this.isEvent,
      required this.status,
      required this.view,
      required this.clubsInCompetition,
      required this.majorsInCompetition,
      required this.competitionEntities});

  factory CompetitionModel.fromJson(Map<String, dynamic> json) {
    int id = json['id'] ?? 0;
    int universityId = json['university_id'] ?? 0;
    String name = json['name'] ?? '';
    int competitionTypeId = json['competition_type_id'] ?? 0;
    String competitionTypeName = json['competition_type_name'] ?? '';
    // DateTime createTime = DateTime.parse(json['create_time']);
    // DateTime startTime = DateTime.parse(json['start_time']);
    //String startTime = json['create_time'] ?? '';
    //String createTime = json['createTime'] ?? '';

    //
    String createTimeString = json['create_time'];
    createTimeString = createTimeString.replaceAll("T", " ");
    createTimeString = createTimeString.replaceAll("Z", "");
    DateTime createTime =
        DateFormat("yyyy-MM-dd HH:mm:ss").parse(createTimeString);
    //
    String startTimeString = json['start_time'];
    startTimeString = startTimeString.replaceAll("T", " ");
    startTimeString = startTimeString.replaceAll("Z", "");
    DateTime startTime =
        DateFormat("yyyy-MM-dd HH:mm:ss").parse(startTimeString);

    bool isSponsor = json['is_sponsor'];
    bool isEvent = json['is_event'];

    CompetitionScopeStatus scope = CompetitionScopeStatus.values[json['scope']];
    CompetitionStatus status =
        CompetitionStatus.values[int.parse(json['status'].toString())];
    int view = json['view'] ?? 0;
    List<CompetitionInClubsModel> competitionInClub = [];
    json['clubs_in_competition']?.forEach((v) {
      competitionInClub.add(CompetitionInClubsModel.fromJson(v));
    });

    List<CompetitionInMajorsModel> competitionInDepartment = [];
    json['majors_in_competition']?.forEach((v) {
      competitionInDepartment.add(CompetitionInMajorsModel.fromJson(v));
    });
    List<CompetitionEntityModel> competitionEntities = [];
    json['competition_entities']?.forEach((v) {
      competitionEntities.add(CompetitionEntityModel.fromJson(v));
    });
    return CompetitionModel(
        id: id,
        universityId: universityId,
        name: name,
        competitionTypeId: competitionTypeId,
        competitionTypeName: competitionTypeName,
        createTime: createTime,
        startTime: startTime,
        isSponsor: isSponsor,
        isEvent: isEvent,
        scope: scope,
        status: status,
        view: view,
        clubsInCompetition: competitionInClub,
        majorsInCompetition: competitionInDepartment,
        competitionEntities: competitionEntities);
  }
}
