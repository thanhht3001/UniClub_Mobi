import 'package:unicec_mobi/models/enums/team_in_match_status.dart';

class TeamsInMatchModel {
  int id;
  int matchId;
  String matchTitle;
  int teamId;
  String teamName;
  int scores;
  TeamInMatchStatus status;
  String description;

  TeamsInMatchModel(
      {required this.id,
      required this.matchId,
      required this.matchTitle,
      required this.teamId,
      required this.teamName,
      required this.scores,
      required this.status,
      required this.description});

  factory TeamsInMatchModel.fromJson(Map<String, dynamic> json) {
    int id = json['id'] ?? 0;
    int matchId = json['match_id'] ?? 0;
    String matchTitle = json['match_title'] ?? "";
    int teamId = json['team_id'] ?? 0;
    String teamName = json['team_name'] ?? "";
    int scores = json['scores'] ?? 0;
    TeamInMatchStatus status = TeamInMatchStatus.values[json['status']];
    String description = json['description'] ?? "";

    return TeamsInMatchModel(
        id: id,
        matchId: matchId,
        matchTitle: matchTitle,
        teamId: teamId,
        teamName: teamName,
        scores: scores,
        status: status,
        description: description);
  }
}
