import 'package:unicec_mobi/models/entities/participant/participant_in_team_model.dart';

class TeamInRoundModel{
  int id;
  int teamId;
  String teamName;
  int roundId;
  int scores;
  bool status;
  int rank;
  List<ParticipantInTeamModel> membersInTeam;

  TeamInRoundModel({
    required this.id,
    required this.teamId,
    required this.teamName,
    required this.roundId,
    required this.scores,
    required this.status,
    required this.rank,
    required this.membersInTeam
  });

  factory TeamInRoundModel.fromJson(Map<String, dynamic> json){
    int id = json['id'] ?? 0;
    int teamId = json['team_id'] ?? 0;
    String teamName = json['team_name'] ?? '';
    int roundId = json['round_id'] ?? 0;
    int scores = json['scores'] ?? 0;
    bool status = json['status'] ?? false;
    int rank = json['rank'] ?? 0;
    List<ParticipantInTeamModel> membersInTeam = [];
    json['members_in_team']?.forEach((v) {
      membersInTeam.add(ParticipantInTeamModel.fromJson(v));
    });

    return TeamInRoundModel(
      id: id, 
      teamId: teamId, 
      teamName: teamName, 
      roundId: roundId, 
      scores: scores, 
      status: status, 
      rank: rank, 
      membersInTeam: membersInTeam
    );
  }
}