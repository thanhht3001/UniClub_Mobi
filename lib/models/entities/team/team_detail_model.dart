import '/models/enums/team_status.dart';
import '../participant/view_detail_participant.dart';

class TeamDetailModel {
  int id;
  int competitionId;
  String name;
  String description;
  String invitedCode;
  TeamStatus status;
  List<ViewDetailParticipantModel> participants;

  TeamDetailModel(
      {required this.id,
      required this.competitionId,
      required this.name,
      required this.description,
      required this.invitedCode,
      required this.status,
      required this.participants});

  factory TeamDetailModel.fromJson(Map<String, dynamic> json) {
    int id = json['team_id'] ?? 0;
    int competitionId = json['competition_id'] ?? 0;
    String name = json['name'] ?? '';
    String description = json['description'] ?? '';
    String invitedCode = json['invited_code'] ?? '';
    TeamStatus status = TeamStatus.values[json['status']];
    List<ViewDetailParticipantModel> participants = [];
    if (json['list_participant'] != null) {
      json['list_participant']?.forEach((v) {
        participants.add(ViewDetailParticipantModel.fromJson(v));
      });
    }

    return TeamDetailModel(
        id: id,
        competitionId: competitionId,
        name: name,
        description: description,
        invitedCode: invitedCode,
        status: status,
        participants: participants);
  }
}
