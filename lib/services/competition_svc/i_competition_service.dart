import 'package:unicec_mobi/models/common/paging_result.dart';
import 'package:unicec_mobi/models/entities/competition/competition_detail_model.dart';
import 'package:unicec_mobi/models/entities/competition/competition_request_model.dart';
import 'package:unicec_mobi/models/entities/competition/competition_show_model.dart';

import '../../models/entities/competition/competition_model.dart';
import '../../models/entities/team/team_model.dart';
import '../../models/enums/competition_scope_status.dart';

abstract class ICompetitionService {
  Future<PagingResult<CompetitionShowModel>?> loadCompetition(
      CompetitionRequestModel request);
  Future<PagingResult<CompetitionShowModel>?> showCompetition(
      CompetitionRequestModel request, int currentPage);
  Future<TeamModel?> LoadTeamsInCompetitions(int competitionId);
  Future<CompetitionDetailModel?> loadDetailById(int competitionId);

  //TA
  Future<PagingResult<CompetitionModel>?> loadCompetitionMemberTask(
      int clubId, String? searchName, bool isEvent);
  Future<PagingResult<CompetitionModel>?> loadCompetitionParticipant(
      int currentPage,
      CompetitionScopeStatus? scope,
      String? name,
      bool? isEvent);
}
