import 'package:unicec_mobi/models/enums/member_status.dart';

class MemberModel {
  int id;
  int studentId;
  String name;
  String studentCode;
  int clubRoleId;
  String clubRoleName;
  String avatar;
  DateTime startTime;
  DateTime? endTime;
  MemberStatus status;
  bool isOnline;

  MemberModel(
      {required this.id,
      required this.studentId,
      required this.name,
      required this.studentCode,
      required this.clubRoleId,
      required this.clubRoleName,
      required this.avatar,
      required this.startTime,
      this.endTime,
      required this.status,
      required this.isOnline});

  factory MemberModel.fromJson(Map<String, dynamic> json) {
    int id = json['id'] ?? '';
    int studentId = json['student_id'] ?? '';
    String name = json['name'] ?? '';
    String studentCode = json['student_code'] ?? '';
    int clubRoleId = json['club_role_id'] ?? '';
    String clubRoleName = json['club_role_name'] ?? '';
    String avatar = json['avatar'] ?? '';
    DateTime startTime = DateTime.parse(json['start_time']);
    //DateTime? endTime = DateTime.parse(json['end_time']) ?? null;
    MemberStatus status = MemberStatus.values[json['status']];
    bool isOnline = json['is_online'] ?? false;

    return MemberModel(
        id: id,
        studentId: studentId,
        name: name,
        studentCode: studentCode,
        clubRoleId: clubRoleId,
        clubRoleName: clubRoleName,
        avatar: avatar,
        startTime: startTime,
        //endTime: endTime,
        status: status,
        isOnline: isOnline);
  }
}
