import 'package:unicec_mobi/bloc/university_selection/university_selection_event.dart';
import 'package:unicec_mobi/bloc/university_selection/university_selection_state.dart';
import 'package:unicec_mobi/services/i_services.dart';
import '../../models/entities/department/department_model.dart';
import '../../utils/base_bloc.dart';

class UniversitySelectionBloc
    extends BaseBloc<UniversitySelectionEvent, UniversitySelectionState> {
  final IUniversitySelectionService service;

  UniversitySelectionBloc({required this.service})
      : super(UniversitySelectionState(
            listUniBelongToEmail: [],
            listDepartment: [],
            dropdownNewValueDep: 1,
            dropdownNewValueUni: 1,
            universityId: 0,
            departmentId: 0,
            description: '',
            gender: '',
            phone: '',
            studentCode: '',
            dob: '')) {
    on((event, emit) async {
      //Recieve data
      if (event is ReceiveData) {
        //auto get Department theo event.newValue
        List<DepartmentModel>? GetListDepartmentByUni =
            await service.getDepartmentByUni(event.listUniBelongToEmail[0].id);

        //set state emit ra ngoài
        emit(state.copyWith(
            listUniBelongToEmail: event.listUniBelongToEmail, // -> change
            listDepartment: GetListDepartmentByUni ?? [],
            dropdownNewValueDep: state.dropdownNewValueDep,
            dropdownNewValueUni: state.dropdownNewValueUni,
            universityId: event.listUniBelongToEmail[0].id, //-> change
            departmentId: GetListDepartmentByUni![0].id, //-> change
            description: state.description,
            gender: "Male", //-> change
            phone: state.phone,
            studentCode: state.studentCode,
            dob: state.dob));
      }

      //Change dropDown value Uni
      if (event is ChangeDropdownValueUni) {
        //auto get Department theo event.newValue
        List<DepartmentModel>? GetListDepartmentByUni =
            await service.getDepartmentByUni(event.newValue);

        emit(state.copyWith(
            listUniBelongToEmail: state.listUniBelongToEmail,
            listDepartment: GetListDepartmentByUni ?? [], // ->change
            dropdownNewValueDep: event.newValue, // -> change
            dropdownNewValueUni: state.dropdownNewValueUni,
            universityId: state.universityId,
            departmentId: state.departmentId,
            description: state.description,
            gender: state.gender,
            phone: state.phone,
            studentCode: state.studentCode,
            dob: state.dob));
      }

      //Change dropDown value Dep
      if (event is ChangeDropdownValueDep) {
        emit(state.copyWith(
            listUniBelongToEmail: state.listUniBelongToEmail,
            listDepartment: state.listDepartment,
            dropdownNewValueDep: event.newValue, // -> change
            dropdownNewValueUni: state.dropdownNewValueUni,
            universityId: state.universityId,
            departmentId: state.departmentId,
            description: state.description,
            gender: state.gender,
            phone: state.phone,
            studentCode: state.studentCode,
            dob: state.dob));
      }

      //Change phone value
      if (event is ChangePhoneValue) {
        emit(state.copyWith(
            listUniBelongToEmail: state.listUniBelongToEmail,
            listDepartment: state.listDepartment,
            dropdownNewValueDep: state.dropdownNewValueDep,
            dropdownNewValueUni: state.dropdownNewValueUni,
            universityId: state.universityId,
            departmentId: state.departmentId,
            description: state.description,
            gender: state.gender,
            phone: event.newPhoneValue, //-> change
            studentCode: state.studentCode,
            dob: state.dob));
      }

      //Change description value
      if (event is ChangeDescriptionValue) {
        emit(state.copyWith(
            listUniBelongToEmail: state.listUniBelongToEmail,
            listDepartment: state.listDepartment,
            dropdownNewValueDep: state.dropdownNewValueDep,
            dropdownNewValueUni: state.dropdownNewValueUni,
            universityId: state.universityId,
            departmentId: state.departmentId,
            description: event.newDescriptionValue, //-> change
            gender: state.gender,
            phone: state.phone,
            studentCode: state.studentCode,
            dob: state.dob));
      }

      //Chang Student Code value
      if (event is ChangeStudentCodeValue) {
        emit(state.copyWith(
            listUniBelongToEmail: state.listUniBelongToEmail,
            listDepartment: state.listDepartment,
            dropdownNewValueDep: state.dropdownNewValueDep,
            dropdownNewValueUni: state.dropdownNewValueUni,
            universityId: state.universityId,
            departmentId: state.departmentId,
            description: state.description,
            gender: state.gender,
            phone: state.phone,
            studentCode: event.newStudentCodeValue, //-> change
            dob: state.dob));
      }

      if (event is ChangeGenderValue) {
        emit(state.copyWith(
            listUniBelongToEmail: state.listUniBelongToEmail,
            listDepartment: state.listDepartment,
            dropdownNewValueDep: state.dropdownNewValueDep,
            dropdownNewValueUni: state.dropdownNewValueUni,
            universityId: state.universityId,
            departmentId: state.departmentId,
            description: state.description,
            gender: event.newGenderValue, //-> change
            phone: state.phone,
            studentCode: state.studentCode,
            dob: state.dob));
      }

      if (event is ChangeDOBValue) {
        emit(state.copyWith(
          listUniBelongToEmail: state.listUniBelongToEmail,
          listDepartment: state.listDepartment,
          dropdownNewValueDep: state.dropdownNewValueDep,
          dropdownNewValueUni: state.dropdownNewValueUni,
          universityId: state.universityId,
          departmentId: state.departmentId,
          description: state.description,
          gender: state.gender,
          phone: state.phone,
          studentCode: state.studentCode,
          dob: event.newDOBValue, //-> change
        ));
      }

      //hàm update
      //Select University
      if (event is CompletelyProfile) {
        bool check = await service.completeProfile(event.completeProfileModel);
        if (check) {
          listener.add(NavigatorWelcomePageEvent());
        } else {
          listener.add(ShowingSnackBarEvent(message: "Lỗi"));
        }
      }
    });
  }
}
