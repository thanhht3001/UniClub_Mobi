import 'package:unicec_mobi/models/entities/competition/competition_in_clubs_model.dart';
import 'package:unicec_mobi/models/entities/competition/competition_in_majors_model.dart';

import '../../enums/competition_scope_status.dart';
import '../../enums/competition_status.dart';
import '../competition_entity/competition_entity_model.dart';

class CompetitionDetailModel {
  int id;
  int universityId;
  String universityImage;
  String universityName;
  String name;
  int competitionTypeId;
  String competitionTypeName;
  double fee;
  String seedsCode;
  double seedsPoint;
  double seedsDeposited;
  int numberOfParticipation;
  int? numberOfTeam;
  int maxNumber;
  int minNumber;
  DateTime createTime;
  DateTime startTimeRegister;
  DateTime endTimeRegister;
  DateTime startTime;
  DateTime endTime;
  String addressName;
  String address;
  String content;
  bool isSponsor;
  CompetitionScopeStatus scope;
  CompetitionStatus status;
  int view;
  List<CompetitionInClubsModel> clubsInCompetition;
  List<CompetitionInMajorsModel> majorsInCompetition;
  List<CompetitionEntityModel> competitionEntities;

  CompetitionDetailModel(
      {required this.id,
      required this.universityId,
      required this.universityName,
      required this.universityImage,
      required this.name,
      required this.competitionTypeId,
      required this.competitionTypeName,
      required this.fee,
      required this.seedsCode,
      required this.seedsPoint,
      required this.seedsDeposited,
      required this.numberOfParticipation,
      this.numberOfTeam,
      required this.maxNumber,
      required this.minNumber,
      required this.createTime,
      required this.startTimeRegister,
      required this.endTimeRegister,
      required this.startTime,
      required this.endTime,
      required this.addressName,
      required this.address,
      required this.content,
      required this.isSponsor,
      required this.scope,
      required this.status,
      required this.view,
      required this.clubsInCompetition,
      required this.majorsInCompetition,
      required this.competitionEntities});

  factory CompetitionDetailModel.fromJson(Map<String, dynamic> json) {
    int id = json['id'] ?? 0;
    int universityId = json['university_id'] ?? 0;
    String universityName = json['university_name'] ?? '';
    String universityImg = json['university_image'] ?? '';
    String name = json['name'] ?? '';
    int competitionTypeId = json['competition_type_id'] ?? 0;
    String competitionTypeName = json['competition_type_name'] ?? '';
    double fee = json['fee'] + .0 ?? 0;
    String seedsCode = json['seeds_code'] ?? '';
    double seedsPoint = json['seeds_point'] + .0 ?? 0;
    double seedsDeposited = json['seeds_deposited'] + .0 ?? 0;
    int numberOfParticipation = json['number_of_participations'] ?? 0;
    int? numberOfTeam = json['number_of_team'] ?? 0;
    int maxNumber = json['max_number'] ?? 0;
    int minNumber = json['min_number'] ?? 0;
    DateTime createTime = DateTime.parse(json['create_time']);
    DateTime startTimeRegister = DateTime.parse(json['start_time_register']);
    DateTime endTimeRegister = DateTime.parse(json['end_time_register']);
    DateTime startTime = DateTime.parse(json['start_time']);
    DateTime endTime = DateTime.parse(json['end_time']);
    String addressName = json['address_name'] ?? '';
    String address = json['address'] ?? '';
    String content = json['content'] ?? '';
    bool isSponsor = json['is_sponsor'] ?? false;
    CompetitionScopeStatus scope =
        CompetitionScopeStatus.values[int.parse(json['scope'].toString())];
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

    return CompetitionDetailModel(
        id: id,
        universityId: universityId,
        universityName: universityName,
        universityImage: universityImg,
        name: name,
        competitionTypeId: competitionTypeId,
        competitionTypeName: competitionTypeName,
        fee: fee,
        seedsCode: seedsCode,
        seedsPoint: seedsPoint,
        seedsDeposited: seedsDeposited,
        numberOfParticipation: numberOfParticipation,
        numberOfTeam: numberOfTeam,
        maxNumber: maxNumber,
        minNumber: minNumber,
        createTime: createTime,
        startTimeRegister: startTimeRegister,
        endTimeRegister: endTimeRegister,
        startTime: startTime,
        endTime: endTime,
        addressName: addressName,
        content: content,
        address: address,
        isSponsor: isSponsor,
        scope: scope,
        status: status,
        view: view,
        clubsInCompetition: competitionInClub,
        majorsInCompetition: competitionInDepartment,
        competitionEntities: competitionEntities);
  }
}
