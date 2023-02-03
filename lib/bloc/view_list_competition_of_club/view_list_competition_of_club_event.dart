class ViewListCompetitionOfClubEvent {}

class LoadOutStandingCompetitionEvent extends ViewListCompetitionOfClubEvent {}

class LoadCompetitionEvent extends ViewListCompetitionOfClubEvent {}

//ChangeName
class ChangeSearchNameEvent extends ViewListCompetitionOfClubEvent {
  String? searchName;
  ChangeSearchNameEvent({required this.searchName});
}

class ChangeValueEvent extends ViewListCompetitionOfClubEvent {
  bool isEvent;
  ChangeValueEvent({required this.isEvent});
}

//Search Event
class SearchEvent extends ViewListCompetitionOfClubEvent {}

//LoadMore
class IncrementalEvent extends ViewListCompetitionOfClubEvent {}

class RefreshEvent extends ViewListCompetitionOfClubEvent {}

class LoadAddMoreEvent extends ViewListCompetitionOfClubEvent {}

class LoadRefreshEvent extends ViewListCompetitionOfClubEvent {}

class SelectACompetitionEvent extends ViewListCompetitionOfClubEvent {
  final int competitionId;
  SelectACompetitionEvent({required this.competitionId});
}

class ListenLoadOutStandingEvent extends ViewListCompetitionOfClubEvent {}

class LoadingEvent extends ViewListCompetitionOfClubEvent {}
