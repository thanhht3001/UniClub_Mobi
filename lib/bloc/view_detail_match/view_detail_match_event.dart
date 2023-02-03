import '../../models/entities/match/match_model.dart';

class ViewDetailMatchEvent {}

class LoadData extends ViewDetailMatchEvent {
  //int matchId;
  MatchModel match;

  LoadData(
      { //required this.matchId,
      required this.match});
}
