import '../../models/entities/uni_selector/uni_selector_model.dart';

class LoginEvent {}

class SignInGoogleEvent extends LoginEvent {}

class NavigatorWelcomePageEvent extends LoginEvent {}

class NavigatorUniversitySelectionPageEvent extends LoginEvent {
  final List<UniBelongToEmail> listUniBelongToEmail;

  NavigatorUniversitySelectionPageEvent({required this.listUniBelongToEmail});
}

class ShowingSnackBarEvent extends LoginEvent {
  final String message;

  ShowingSnackBarEvent({required this.message});
}

class LoadingEvent extends LoginEvent {}
