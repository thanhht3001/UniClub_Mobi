import '../../models/entities/club/club_model.dart';

class ClubViewDetailEvent {}

class ReceiveDataEvent extends ClubViewDetailEvent {
  final ClubModel clubView;
  ReceiveDataEvent({required this.clubView});
}

class ApplyInClubEvent extends ClubViewDetailEvent {
  final int clubId;
  ApplyInClubEvent({required this.clubId});
}

class ShowPopUpAnnouncement extends ClubViewDetailEvent {
  String message;

  ShowPopUpAnnouncement({required this.message});
}
