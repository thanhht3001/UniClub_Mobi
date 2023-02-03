class ClubEvent {}

class ClubInitEvent extends ClubEvent {}

class ChooseAnotherClubEvent extends ClubEvent {}

class ClubSelectionEvent extends ClubEvent {}

class ClubsViewEvent extends ClubEvent {}

//Navigator to Club Selection page
class NavigatorClubSelectionPageEvent extends ClubEvent {}

//Navigator to Clubs View page
class NavigatorClubsViewPageEvent extends ClubEvent {}

class ShowingSnackBarEvent extends ClubEvent {
  final String message;

  ShowingSnackBarEvent({required this.message});
}

class OutClubEvent extends ClubEvent{
  int memberId;

  OutClubEvent({required this.memberId});
}

class ShowPopUpAnnouncementEvent extends ClubEvent{
  bool isSuccess;

  ShowPopUpAnnouncementEvent({required this.isSuccess});
} 