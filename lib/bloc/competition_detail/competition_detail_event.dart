class CompetitionDetailEvent{}

class LoadCompetitionDetailEvent extends CompetitionDetailEvent{
  int competitionId;
  LoadCompetitionDetailEvent({required this.competitionId});
}

class ParticipateTheCompetitionEvent extends CompetitionDetailEvent{
  int competitionId;
  ParticipateTheCompetitionEvent({required this.competitionId});
}

class AttendanceCompetitionEvent extends CompetitionDetailEvent{
  String seedsCode;

  AttendanceCompetitionEvent({required this.seedsCode});
}

class ShowPopUpAnnouncement extends CompetitionDetailEvent{
  String message;

  ShowPopUpAnnouncement({required this.message});
}

class CreateTeamEvent extends CompetitionDetailEvent{
  int competitionId;
  String teamName;
  String? description;

  CreateTeamEvent({required this.competitionId, required this.teamName, this.description});
}