import '../../models/entities/club/club_model.dart';

class ClubsViewEvent {}

class ClubsViewInitEvent extends ClubsViewEvent {}

class ChooseClubEvent extends ClubsViewEvent {
  final ClubModel clubSelect;
  ChooseClubEvent({required this.clubSelect});
}

class NavigatorClubViewDetailPageEvent extends ClubsViewEvent {
  final ClubModel clubSelect;
  NavigatorClubViewDetailPageEvent({required this.clubSelect});
}

//LoadMore
class IncrementalEvent extends ClubsViewEvent {}

class RefreshEvent extends ClubsViewEvent {}

class LoadAddMoreEvent extends ClubsViewEvent {}
