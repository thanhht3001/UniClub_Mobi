import '../../models/enums/competition_activity_status.dart';
import '../../models/enums/priority_status.dart';

class ViewCompetitionActivityEvent {}

//init event
class ViewCompetitionActivityInitEvent extends ViewCompetitionActivityEvent {}

//recieve data
class ReceiveDataEvent extends ViewCompetitionActivityEvent {
  final int competitionId;
  ReceiveDataEvent({required this.competitionId});
}

//LoadMore
class IncrementalEvent extends ViewCompetitionActivityEvent {}

class RefreshEvent extends ViewCompetitionActivityEvent {}

class LoadAddMoreEvent extends ViewCompetitionActivityEvent {}

//ChangeName
class ChangeSearchNameEvent extends ViewCompetitionActivityEvent {
  String? searchName;
  ChangeSearchNameEvent({required this.searchName});
}

class ChangeValueStatusEvent extends ViewCompetitionActivityEvent {
  CompetitionActivityStatus chooseStatus;
  ChangeValueStatusEvent({required this.chooseStatus});
}

class ChangeValuePriorityStatusEvent extends ViewCompetitionActivityEvent {
  PriorityStatus choosePriorityStatus;
  ChangeValuePriorityStatusEvent({required this.choosePriorityStatus});
}

//Search Filter
class SearchEvent extends ViewCompetitionActivityEvent {}

//Reset Filter
class ResetFilterEvent extends ViewCompetitionActivityEvent {}

class LoadingEvent extends ViewCompetitionActivityEvent {}
