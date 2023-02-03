class ViewCompetitionMemberTaskEvent {}

//inite event
class InitEvent extends ViewCompetitionMemberTaskEvent {}

//LoadMore
class IncrementalEvent extends ViewCompetitionMemberTaskEvent {}

class RefreshEvent extends ViewCompetitionMemberTaskEvent {}

class LoadAddMoreEvent extends ViewCompetitionMemberTaskEvent {}

//ChangeName
class ChangeSearchNameEvent extends ViewCompetitionMemberTaskEvent {
  String? searchName;
  ChangeSearchNameEvent({required this.searchName});
}

class ChangeValueEvent extends ViewCompetitionMemberTaskEvent {
  bool isEvent;
  ChangeValueEvent({required this.isEvent});
}

//Search Filter
class SearchEvent extends ViewCompetitionMemberTaskEvent {}

class LoadingEvent extends ViewCompetitionMemberTaskEvent {}
// //Reset Filter
// class ResetFilterEvent extends ViewCompetitionMemberTaskEvent {}