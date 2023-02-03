import 'package:intl/intl.dart';

import '../../enums/participant_in_team_status.dart';

class ViewDetailParticipantModel {
  int participantId;
  int competitionId;
  int studentId;
  String studentName;
  String studentAvatar;
  String studentCode;
  String universityName;
  DateTime registerTime;
  int participantInTeamId;
  int teamRoleId;
  String teamRoleName;
  ParticipantInTeamStatus status;

  ViewDetailParticipantModel(
      {required this.participantId,
      required this.competitionId,
      required this.studentId,
      required this.studentName,
      required this.studentAvatar,
      required this.studentCode,
      required this.universityName,
      required this.registerTime,
      required this.participantInTeamId,
      required this.teamRoleId,
      required this.teamRoleName,
      required this.status});

  factory ViewDetailParticipantModel.fromJson(Map<String, dynamic> json) {
    int participantId = json['participant_id'] ?? 0;
    int competitionId = json['competition_id'] ?? 0;
    int studentId = json['student_id'] ?? 0;
    String studentName = json['student_name'] ?? '';
    String studentAvatar = json['student_avatar'] ?? '';
    String studentCode = json['student_code'] ?? '';
    String universityName = json['university_name'] ?? '';
    //
    String registerTimeString = json['register_time'];
    registerTimeString = registerTimeString.replaceAll("T", " ");
    registerTimeString = registerTimeString.replaceAll("Z", "");
    DateTime registerTime =
        DateFormat("yyyy-MM-dd HH:mm:ss").parse(registerTimeString);
    //
    int participantInTeamId = json['participant_in_team_id'] ?? 0;
    int teamRoleId = json['team_role_id'] ?? 0;
    String teamRoleName = json['team_role_name'] ?? '';
    ParticipantInTeamStatus status =
        ParticipantInTeamStatus.values[json['status']];

    return ViewDetailParticipantModel(
        participantId: participantId,
        competitionId: competitionId,
        studentId: studentId,
        studentName: studentName,
        studentAvatar: studentAvatar,
        studentCode: studentCode,
        universityName: universityName,
        registerTime: registerTime,
        participantInTeamId: participantInTeamId,
        teamRoleId: teamRoleId,
        teamRoleName: teamRoleName,
        status: status);
  }
}
