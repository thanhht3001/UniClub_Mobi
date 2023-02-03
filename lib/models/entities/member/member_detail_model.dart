import 'package:intl/intl.dart';
import 'package:unicec_mobi/models/enums/member_status.dart';

class MemberDetailModel {
  int id;
  String name;
  String studentCode;
  int clubId;
  String clubName;
  int clubRoleId;
  String clubRoleName;
  String avatar;
  String phone;
  String email;
  DateTime joinDate;
  MemberStatus status;
  bool isOnline;

  MemberDetailModel(
      {required this.id,
      required this.name,
      required this.studentCode,
      required this.clubId,
      required this.clubName,
      required this.clubRoleId,
      required this.clubRoleName,
      required this.avatar,
      required this.phone,
      required this.email,
      required this.joinDate,
      required this.status,
      required this.isOnline});

  factory MemberDetailModel.fromJson(Map<String, dynamic> json) {
    int id = json['id'] ?? '';
    String name = json['name'] ?? '';
    String studentCode = json['student_code'] ?? '';
    int clubId = json['club_id'] ?? '';
    String clubName = json['club_name'] ?? '';
    int clubRoleId = json['club_role_id'] ?? '';
    String clubRoleName = json['club_role_name'] ?? '';
    String avatar = json['avatar'] ?? '';
    String phone = json['phone'] ?? '';
    String email = json['email'] ?? '';
    MemberStatus status = MemberStatus.values[json['status']];
    //
    String joinDateString = json['join_date'];
    joinDateString = joinDateString.replaceAll("T", " ");
    joinDateString = joinDateString.replaceAll("Z", "");
    DateTime joinDate = DateFormat("yyyy-MM-dd HH:mm:ss").parse(joinDateString);
    //
    bool isOnline = json['is_online'] ?? false;

    return MemberDetailModel(
        id: id,
        name: name,
        studentCode: studentCode,
        clubId: clubId,
        clubName: clubName,
        clubRoleId: clubRoleId,
        clubRoleName: clubRoleName,
        avatar: avatar,
        phone: phone,
        email: email,
        joinDate: joinDate,
        status: status,
        isOnline: isOnline);
  }
}
