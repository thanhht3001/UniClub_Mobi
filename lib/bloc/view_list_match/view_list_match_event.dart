import '../../models/entities/competition_round/competition_round_model.dart';

class ViewListMatchEvent{}

class LoadMatchesByRoundEvent extends ViewListMatchEvent{
  int roundId;
  CompetitionRoundModel? round;

  LoadMatchesByRoundEvent({required this.roundId, this.round});
}

