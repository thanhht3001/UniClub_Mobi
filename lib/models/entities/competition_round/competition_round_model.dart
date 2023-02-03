import 'package:unicec_mobi/models/enums/competition_round_status.dart';

class CompetitionRoundModel{
  int id;
  int competitionId;
  String title;
  String description;
  // DateTime startTime;
  // DateTime endTime;
  String startTime;
  String endTime;
  int numberOfTeam;
  int seedsPoint;
  CompetitionRoundStatus status;

  CompetitionRoundModel({
    required this.id,
    required this.competitionId,
    required this.title,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.numberOfTeam,
    required this.seedsPoint,
    required this.status
  });

  factory CompetitionRoundModel.fromJson(Map<String, dynamic> json){
    int id = json['id'] ?? 0;
    int competitionId = json['competition_id'] ?? 0;
    String title = json['title'] ?? '';
    String description = json['description'] ?? '';
    String startTime = json['start_time'] ?? '';
    String endTime = json['end_time'] ?? '';
    int numberOfTeam = json['number_of_team'] ?? 0;
    int seedsPoint = json['seeds_point'] ?? 0;
    CompetitionRoundStatus status = CompetitionRoundStatus.values[json['status']];

    return CompetitionRoundModel(
      id: id, 
      competitionId: competitionId, 
      title: title, 
      description: description, 
      startTime: startTime, 
      endTime: endTime, 
      numberOfTeam: numberOfTeam, 
      seedsPoint: seedsPoint, 
      status: status
    );
  }
}