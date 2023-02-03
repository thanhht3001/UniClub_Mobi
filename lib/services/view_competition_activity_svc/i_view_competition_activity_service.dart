import 'package:unicec_mobi/models/entities/competition_activity/competition_activity_model.dart';

import '../../models/common/paging_result.dart';
import '../../models/entities/competition_activity/competition_activity_detail_model.dart';
import '../../models/entities/competition_activity/competition_activity_request_model.dart';
import '../../models/enums/competition_activity_status.dart';

abstract class ICompetitionActivityService {
  Future<PagingResult<CompetitionActivityModel>?> getListCompetitionActivity(
      CompetitionActivityRequestModel request);

  Future<CompetitionActivityDetailModel?> getCompetitionActivityDetail(
      int competitionActivityId);

  Future<bool> updateStatusCompetitionActivity(
      CompetitionActivityStatus status, int competitionActivityId);
}
