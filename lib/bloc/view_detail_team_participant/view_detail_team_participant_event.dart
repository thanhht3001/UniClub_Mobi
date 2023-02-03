import '../../models/enums/team_status.dart';

class ViewDetailTeamParticipantEvent {}

class ReceiveDataEvent extends ViewDetailTeamParticipantEvent {
  int competitionId;
  int teamId;
  int? max;
  int? min;
  ReceiveDataEvent(
      {required this.teamId,
      required this.competitionId,
      required this.max,
      required this.min});
}

//get description
class ChangeTeamDescriptionValueEvent extends ViewDetailTeamParticipantEvent {
  final String newDescriptionValue;
  ChangeTeamDescriptionValueEvent({required this.newDescriptionValue});
}

//get team name
class ChangeTeamNameValueEvent extends ViewDetailTeamParticipantEvent {
  final String newNameValue;
  ChangeTeamNameValueEvent({required this.newNameValue});
}

class UpdateTeamNameAndDescriptionEvent extends ViewDetailTeamParticipantEvent {
}

class UpdateStatusTeam extends ViewDetailTeamParticipantEvent {
  final TeamStatus status;
  UpdateStatusTeam({required this.status});
}

//update team role
class UpdateMemberRoleEvent extends ViewDetailTeamParticipantEvent {
  final int participantInTeamId;
  UpdateMemberRoleEvent({required this.participantInTeamId});
}

//Delete Member by Team Leader
class DeleteMemberByTeamLeaderEvent extends ViewDetailTeamParticipantEvent {
  final int participantId;
  DeleteMemberByTeamLeaderEvent({required this.participantId});
}

//Member Out Team
class MemberOutTeamEvent extends ViewDetailTeamParticipantEvent {}

//Delete Team
class DeleteTeamByLeaderEvent extends ViewDetailTeamParticipantEvent {}

//show lỗi
class ShowingSnackBarEvent extends ViewDetailTeamParticipantEvent {
  final String message;

  ShowingSnackBarEvent({required this.message});
}

//back lại trang trước
class BackPreviousPageEvent extends ViewDetailTeamParticipantEvent {}

class ClickToViewInfoEvent extends ViewDetailTeamParticipantEvent {
  int userId;
  ClickToViewInfoEvent({required this.userId});
}

class NavigatorToAccountPageEvent extends ViewDetailTeamParticipantEvent {
  int userId;
  NavigatorToAccountPageEvent({required this.userId});
}

class LoadingEvent extends ViewDetailTeamParticipantEvent {}

//load lại data sau khi từ trang MyAccount về đây
class LoadDataEvent extends ViewDetailTeamParticipantEvent {}
