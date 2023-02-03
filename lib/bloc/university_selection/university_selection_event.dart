import 'package:unicec_mobi/models/entities/user/complete_profile.dart';
import '../../models/entities/uni_selector/uni_selector_model.dart';

class UniversitySelectionEvent {}

class ReceiveData extends UniversitySelectionEvent {
  final List<UniBelongToEmail> listUniBelongToEmail;
  ReceiveData({required this.listUniBelongToEmail});
}

class CompletelyProfile extends UniversitySelectionEvent {
  final CompleteProfile completeProfileModel;
  CompletelyProfile({required this.completeProfileModel});
}

class ChangeDropdownValueUni extends UniversitySelectionEvent {
  final int newValue;
  ChangeDropdownValueUni({required this.newValue});
}

class ChangeDropdownValueDep extends UniversitySelectionEvent {
  final int newValue;
  ChangeDropdownValueDep({required this.newValue});
}

//get phone
class ChangePhoneValue extends UniversitySelectionEvent {
  final String newPhoneValue;
  ChangePhoneValue({required this.newPhoneValue});
}

//get description
class ChangeDescriptionValue extends UniversitySelectionEvent {
  final String newDescriptionValue;
  ChangeDescriptionValue({required this.newDescriptionValue});
}

//get Student Code
class ChangeStudentCodeValue extends UniversitySelectionEvent {
  final String newStudentCodeValue;
  ChangeStudentCodeValue({required this.newStudentCodeValue});
}

//get Gender
class ChangeGenderValue extends UniversitySelectionEvent {
  final String newGenderValue;
  ChangeGenderValue({required this.newGenderValue});
}

//get DOB
class ChangeDOBValue extends UniversitySelectionEvent {
  final String newDOBValue;
  ChangeDOBValue({required this.newDOBValue});
}

//navigate - xử lý ngoài giao diện
class NavigatorWelcomePageEvent extends UniversitySelectionEvent {}

class ShowingSnackBarEvent extends UniversitySelectionEvent {
  final String message;

  ShowingSnackBarEvent({required this.message});
}
