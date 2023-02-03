class AddTeamDialogEvent {}

//get description
class ChangeTeamDescriptionValueEvent extends AddTeamDialogEvent {
  final String newDescriptionValue;
  ChangeTeamDescriptionValueEvent({required this.newDescriptionValue});
}

//get team name
class ChangeTeamNameValueEvent extends AddTeamDialogEvent {
  final String newNameValue;
  ChangeTeamNameValueEvent({required this.newNameValue});
}

//ClickButtonCreate
class ClickButtonCreate extends AddTeamDialogEvent {}

//sending data event
class SendingDataEvent extends AddTeamDialogEvent {
  final String teamName;
  final String teamDescription;
  SendingDataEvent({required this.teamName, required this.teamDescription});
}
