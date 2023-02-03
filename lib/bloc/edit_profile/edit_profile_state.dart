import 'package:equatable/equatable.dart';

import '../../models/entities/department/department_model.dart';
import '../../models/entities/user/user_model.dart';

class EditProfileState extends Equatable {
  UserModel? user;
  List<DepartmentModel>? departments;
  bool? isSuccess;
  DepartmentModel? selectedDepartment;
  List<String> genderSelection;
  String? selectedGender;

  EditProfileState(
      {this.user,
      this.departments,
      this.isSuccess,
      this.selectedDepartment,
      this.selectedGender,
      this.genderSelection = const ["Male", "Female"]});

  EditProfileState copyWith(
      {UserModel? user,
      List<DepartmentModel>? departments,
      bool? isSuccess,
      DepartmentModel? selectedDepartment,
      String? selectedGender}) {
    return EditProfileState(
        user: user,
        departments: departments,
        isSuccess: isSuccess,
        selectedDepartment: selectedDepartment,
        selectedGender: selectedGender);
  }

  @override
  // TODO: implement props
  List<Object?> get props =>
      [user, departments, isSuccess, selectedDepartment, selectedGender];
}
