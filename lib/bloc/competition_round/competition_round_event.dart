class CompetitionRoundEvent{}

class LoadRoundsByCompetition extends CompetitionRoundEvent{
  int competitionId;
  LoadRoundsByCompetition({required this.competitionId});
}

class LoadResultARoundInCompetition extends CompetitionRoundEvent{
  int roundId;
  LoadResultARoundInCompetition({required this.roundId});
}

class LoadResultTeamsInCompetition extends CompetitionRoundEvent{
  int competitionId;
  LoadResultTeamsInCompetition({required this.competitionId});
}