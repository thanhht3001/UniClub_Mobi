class ViewResultTeamEvent {}

class LoadData extends ViewResultTeamEvent{
  int competitionId;
  int teamId;

  LoadData({required this.competitionId, required this.teamId});
}

class LoadMatchDetailEvent extends ViewResultTeamEvent{
  int matchId;

  LoadMatchDetailEvent({required this.matchId});
}

class NavigateToMatchDetailEvent extends ViewResultTeamEvent{}