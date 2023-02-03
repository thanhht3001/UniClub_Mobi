class ParticipantInTeamModel{
  int id;
  int teamId;
  int participantId;
  int competitionId;

  ParticipantInTeamModel({
    required this.id,
    required this.teamId,
    required this.participantId,
    required this.competitionId
  });

  factory ParticipantInTeamModel.fromJson(Map<String, dynamic> json){
    int id = json['id'] ?? 0;
    int teamId = json['team_id'] ?? 0;
    int participantId = json['participant_id'] ?? 0;
    int competitionId = json['competition_id'] ?? 0;

    return ParticipantInTeamModel(
      id: id, 
      teamId: teamId, 
      participantId: participantId, 
      competitionId: competitionId
    );
  }
}