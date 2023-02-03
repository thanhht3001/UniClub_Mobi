class CompleteProfile {
  //DepartmentId
  //Phone
  //Description
  //Gender
  //MSSV
  //DOB
  final int universityId;
  final int departmentId;
  final String phone;
  final String description;
  final String gender;
  final String studentCode;
  final String dob;

  CompleteProfile(
      {required this.universityId,
      required this.departmentId,
      required this.phone,
      required this.description,
      required this.gender,
      required this.studentCode,
      required this.dob});
}
