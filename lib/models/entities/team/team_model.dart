import '/models/enums/team_status.dart';

class TeamModel {
  int id;
  int competitionId;
  String name;
  String description;
  String invitedCode;
  TeamStatus status;
  int numberOfMemberInTeam;
  int? totalPoint;
  int? rank;

  TeamModel(
      {required this.id,
      required this.competitionId,
      required this.name,
      required this.description,
      required this.invitedCode,
      required this.status,
      required this.numberOfMemberInTeam,
      this.totalPoint,
      this.rank});

  factory TeamModel.fromJson(Map<String, dynamic> json) {
    int id = json['team_id'] ?? 0;
    int competitionId = json['competition_id'] ?? 0;
    String name = json['name'] ?? '';
    String description = json['description'] ?? '';
    String invitedCode = json['invited_code'] ?? '';
    TeamStatus status = TeamStatus.values[json['status']];
    int numberOfMemberInTeam = json['number_of_member_in_team'] ?? 0;
    int totalPoint = json['total_point'] ?? 0;
    int rank = json['rank'] ?? 0;

    return TeamModel(
        id: id,
        competitionId: competitionId,
        name: name,
        description: description,
        invitedCode: invitedCode,
        status: status,
        numberOfMemberInTeam: numberOfMemberInTeam,
        totalPoint: totalPoint,
        rank: rank);
  }
}
