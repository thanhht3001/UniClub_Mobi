import 'package:equatable/equatable.dart';
import 'package:unicec_mobi/models/entities/team/team_in_competition_model.dart';

import '../../models/entities/match/match_model.dart';

class ViewResultTeamState extends Equatable{
  ResultTeamInCompetitionModel? resultTeamInCompetition;
  MatchModel? match;

  ViewResultTeamState({this.resultTeamInCompetition, this.match});

  ViewResultTeamState copyWith({ResultTeamInCompetitionModel? resultTeamInCompetition, MatchModel? match}){
    return ViewResultTeamState(resultTeamInCompetition: resultTeamInCompetition, match: match);
  }
  
  @override
  // TODO: implement props
  List<Object?> get props => [resultTeamInCompetition, match];

}