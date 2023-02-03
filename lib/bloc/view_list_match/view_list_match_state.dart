import 'package:equatable/equatable.dart';

import '../../models/entities/competition_round/competition_round_model.dart';
import '../../models/entities/match/match_model.dart';

class ViewListMatchState extends Equatable{
  List<MatchModel>? matches;
  CompetitionRoundModel? round;

  ViewListMatchState({this.matches, this.round});  

  ViewListMatchState copyWith({List<MatchModel>? matches, CompetitionRoundModel? round}){
    return ViewListMatchState(matches: matches, round: round);
  }
  
  @override
  // TODO: implement props
  List<Object?> get props => [matches, round];

}