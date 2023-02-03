import '../../enums/competition_status.dart';
import '../../enums/team_status.dart';

class SendingDataModel {
  final int competitionId;
  final int teamId;
  final String teamName;
  final String teamDescription;
  final TeamStatus status;
  //final CompetitionStatus? competitionStatus;
  int? min;
  int? max;

  SendingDataModel(
      {required this.competitionId,
      required this.teamId,
      required this.teamName,
      required this.teamDescription,
      required this.status,
      //required this.competitionStatus,
      this.min,
      this.max});
}
