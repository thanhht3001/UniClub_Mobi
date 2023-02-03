class ViewListTeamInRoundEvent {}

//LoadMore
class IncrementalEvent extends ViewListTeamInRoundEvent {}

class RefreshEvent extends ViewListTeamInRoundEvent {}

class LoadAddMoreEvent extends ViewListTeamInRoundEvent {}

//receive data
class ReceiveDataEvent extends ViewListTeamInRoundEvent {
  int roundId;
  ReceiveDataEvent({required this.roundId});
}

class LoadingEvent extends ViewListTeamInRoundEvent {}

class ViewListTeamInitEvent extends ViewListTeamInRoundEvent {}

class LoadInfoRoundEvent extends ViewListTeamInRoundEvent{
  int roundId;
  int? teamId;

  LoadInfoRoundEvent({required this.roundId, this.teamId});
}

class NavigateToTeamDetailEvent extends ViewListTeamInRoundEvent{
  int competitionId;
  int teamId;

  NavigateToTeamDetailEvent({required this.competitionId, required this.teamId});
}
