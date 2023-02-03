import 'package:equatable/equatable.dart';
import 'package:unicec_mobi/models/entities/team/team_in_round_model.dart';

import '../../models/entities/competition_round/competition_round_model.dart';
import '../../models/entities/team/team_in_competition_model.dart';

class CompetitionRoundState extends Equatable {
  List<CompetitionRoundModel>? competitionRounds;
  List<TeamInRoundModel>? teamsInRoundResult;
  List<ResultTeamsInCompetitionModel>? teamsInCompetitionResult;

  CompetitionRoundState({this.competitionRounds, this.teamsInRoundResult, this.teamsInCompetitionResult});

  CompetitionRoundState copyWith(
      {List<CompetitionRoundModel>? competitionRoundModel, List<TeamInRoundModel>? teamsInRoundResult, List<ResultTeamsInCompetitionModel>? teamsInCompetitionResult}) {
    return CompetitionRoundState(competitionRounds: competitionRoundModel, teamsInRoundResult: teamsInRoundResult, teamsInCompetitionResult: teamsInCompetitionResult);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [competitionRounds, teamsInRoundResult, teamsInCompetitionResult];
}
