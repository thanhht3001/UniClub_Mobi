class ClubSelectionEvent {}

class ChooseClubSelectionEvent extends ClubSelectionEvent {
  final int clubIdSelected;
  ChooseClubSelectionEvent({required this.clubIdSelected});
}

class ClubsViewPageEvent extends ClubSelectionEvent {}

class NavigatorClubPageEvent extends ClubSelectionEvent {}

class NavigatorClubsViewPageEvent extends ClubSelectionEvent {}

class RefreshEvent extends ClubSelectionEvent {}
