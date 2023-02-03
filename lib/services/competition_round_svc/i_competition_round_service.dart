

import 'package:unicec_mobi/models/common/paging_result.dart';

import '../../models/entities/competition_round/competition_round_model.dart';
import '../../models/entities/team/team_in_competition_model.dart';
import '../../models/entities/team/team_in_round_model.dart';

abstract class ICompetitionRoundService{
  Future<CompetitionRoundModel?> getById(int id);
  Future<PagingResult<CompetitionRoundModel>?> loadRoundsByCompetition(int competitionId);
  Future<PagingResult<TeamInRoundModel>?> loadRoundResultById(int roundId); // result teams in a round
  Future<List<ResultTeamsInCompetitionModel>?> loadTeamResultByCompetition(int competitionId); // result teams in a competition
}