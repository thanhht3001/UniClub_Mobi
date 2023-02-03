class ViewDetailTeamStudentEvent {}

class ReceiveDataEvent extends ViewDetailTeamStudentEvent {
  int competitionId;
  int teamId;
  ReceiveDataEvent({required this.teamId, required this.competitionId});
}

class ClickToViewInfoEvent extends ViewDetailTeamStudentEvent {
  int userId;
  ClickToViewInfoEvent({required this.userId});
}

class NavigatorToAccountPageEvent extends ViewDetailTeamStudentEvent {
  int userId;
  NavigatorToAccountPageEvent({required this.userId});
}

class LoadingEvent extends ViewDetailTeamStudentEvent {}

//load lại data sau khi từ trang MyAccount về đây
class LoadDataEvent extends ViewDetailTeamStudentEvent {}
