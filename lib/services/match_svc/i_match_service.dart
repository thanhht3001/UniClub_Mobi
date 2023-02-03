import 'package:unicec_mobi/models/common/paging_result.dart';

import '../../models/entities/match/match_model.dart';
import '../../models/entities/match/teams_in_match_model.dart';

abstract class IMatchService{
  Future<PagingResult<MatchModel>?> getMatchesByRound(int roundId);
  Future<List<TeamsInMatchModel>?> getTeamsInMatch(int matchId);
  Future<MatchModel?> getMatchById(int matchId);
}