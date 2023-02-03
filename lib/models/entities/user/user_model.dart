import 'package:unicec_mobi/models/enums/user_status.dart';

class UserModel {
  int id;
  int roleId;
  int? universityId;
  String? universityName;
  String email;
  String fullname;
  String avatar;
  String gender;
  int? departmentId;
  String? departmentName;
  String studentCode;
  String phoneNumber;
  UserStatus status;
  String dob;
  String description;
  bool isOnline;

  UserModel(
      {required this.id,
      required this.roleId,
      this.universityId,
      this.universityName,
      required this.email,
      required this.fullname,
      required this.avatar,
      required this.gender,
      this.departmentId,
      this.departmentName,
      required this.studentCode,
      required this.phoneNumber,
      required this.status,
      required this.dob,
      required this.description,
      required this.isOnline});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    int id = json['id'] ?? 0;
    int roleId = json['role_id'] ?? 0;
    int? universityId = json['university_id'] ?? 0;
    String? universityName = json['university_name'] ?? '';
    String email = json['email'] ?? '';
    String fullname = json['fullname'] ?? '';
    String avatar = json['avatar'] ?? '';
    String gender = json['gender'] ?? '';
    int? departmentId = json['department_id'] ?? 0;
    String? departmentName = json['department_name'] ?? '';
    String studentCode = json['student_code'] ?? '';
    String phoneNumber = json['phone_number'] ?? '';
    UserStatus status = UserStatus.values[json['status'] ?? 1];
    String dob = json['dob'] ?? '';
    String description = json['description'] ?? '';
    bool isOnline = json['is_online'] ?? false;

    return UserModel(
      id: id, 
      roleId: roleId,
      universityId: universityId,
      universityName: universityName,
      email: email,
      fullname: fullname, 
      avatar: avatar, 
      gender: gender,
      departmentId: departmentId,
      departmentName: departmentName,
      studentCode: studentCode, 
      phoneNumber: phoneNumber, 
      status: status, 
      dob: dob, 
      description: description, 
      isOnline: isOnline
    );
  }
}
