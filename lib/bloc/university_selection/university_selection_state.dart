import 'package:equatable/equatable.dart';

import '../../models/entities/department/department_model.dart';
import '../../models/entities/uni_selector/uni_selector_model.dart';

class UniversitySelectionState extends Equatable {
  final List<UniBelongToEmail> listUniBelongToEmail;
  final List<DepartmentModel> listDepartment;
  final int dropdownNewValueDep;
  final int dropdownNewValueUni;
  //profile
  final int universityId;
  final int departmentId;
  final String phone;
  final String description;
  final String gender;
  final String studentCode;
  final String dob;

  UniversitySelectionState({
    required this.listUniBelongToEmail,
    required this.listDepartment,
    required this.dropdownNewValueDep,
    required this.dropdownNewValueUni,
    required this.universityId,
    required this.departmentId,
    required this.phone,
    required this.description,
    required this.gender,
    required this.studentCode,
    required this.dob,
  });

  UniversitySelectionState copyWith(
      {required List<UniBelongToEmail> listUniBelongToEmail,
      required List<DepartmentModel> listDepartment,
      required int dropdownNewValueDep,
      required int dropdownNewValueUni,
      required int universityId,
      required int departmentId,
      required String phone,
      required String description,
      required String gender,
      required String studentCode,
      required String dob}) {
    return UniversitySelectionState(
        listUniBelongToEmail: listUniBelongToEmail,
        listDepartment: listDepartment,
        dropdownNewValueDep: dropdownNewValueDep,
        dropdownNewValueUni: dropdownNewValueUni,
        universityId: universityId,
        departmentId: departmentId,
        phone: phone,
        description: description,
        gender: gender,
        studentCode: studentCode,
        dob: dob);
  }

  @override
  List<Object?> get props => [
        listUniBelongToEmail,
        listDepartment,
        dropdownNewValueDep,
        dropdownNewValueUni,
        universityId,
        departmentId,
        phone,
        description,
        gender,
        studentCode,
        dob
      ];
}
