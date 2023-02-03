import '../../models/entities/user/user_model.dart';

class EditProfileEvent{}

class LoadProfileEvent extends EditProfileEvent{
  int userId;

  LoadProfileEvent({required this.userId});
}

class EditInfoEvent extends EditProfileEvent{
  UserModel user;
  EditInfoEvent({required this.user});
}

class LoadDepartmentsByUni extends EditProfileEvent{
  int universityId;

  LoadDepartmentsByUni({required this.universityId});
}

class ChangeSelectionDepartment extends EditProfileEvent{
  int newValue;

  ChangeSelectionDepartment({required this.newValue});
}

class ShowPopUpAnnouncement extends EditProfileEvent{
  String message;

  ShowPopUpAnnouncement({required this.message});
}