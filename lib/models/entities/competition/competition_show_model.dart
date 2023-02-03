import '../../enums/competition_scope_status.dart';
import '../../enums/competition_status.dart';
import '../competition_entity/competition_entity_model.dart';

class CompetitionShowModel {
  int id;
  String name;
  int view;
  int competitionTypeId;
  String competitionTypeName;
  DateTime startTime;
  CompetitionStatus status;
  CompetitionScopeStatus scope;
  List<CompetitionEntityModel> competitionEntities;

  CompetitionShowModel(
      {required this.id,
      required this.name,
      required this.view,
      required this.competitionTypeId,
      required this.competitionTypeName,
      required this.startTime,
      required this.status,
      required this.scope,
      required this.competitionEntities});

  factory CompetitionShowModel.fromJson(Map<String, dynamic> json) {
    int id = json['id'] ?? 0;
    String name = json['name'] ?? '';
    int view = json['view'] ?? 0;
    int competitionTypeId = json['competition_type_id'] ?? 0;
    String competitionTypeName = json['competition_type_name'] ?? '';
    DateTime startTime = DateTime.parse(json['start_time']);
    CompetitionStatus status =
        CompetitionStatus.values[int.parse(json['status'].toString())];
    List<CompetitionEntityModel> competitionEntities = [];
    json['competition_entities']?.forEach((v) {
      competitionEntities.add(CompetitionEntityModel.fromJson(v));
    });
    CompetitionScopeStatus scope = CompetitionScopeStatus.values[json['scope']];

    return CompetitionShowModel(
        id: id,
        name: name,
        view: view,
        competitionTypeId: competitionTypeId,
        competitionTypeName: competitionTypeName,
        startTime: startTime,
        status: status,
        scope: scope,
        competitionEntities: competitionEntities);
  }
}
