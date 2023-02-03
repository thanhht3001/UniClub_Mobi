import 'package:unicec_mobi/models/common/resultCRUD.dart';
import 'package:unicec_mobi/models/entities/participant/participant_model.dart';

import '../../models/entities/competition/competition_detail_model.dart';
import '../../models/entities/competition/competition_model.dart';

abstract class ICompetitionDetailService {
  Future<CompetitionDetailModel> getDetailCompetitionByConditions();
  Future<CompetitionDetailModel?> getById(int id);
  Future<CompetitionModel?> getCompetitionStudentJoin(int id);
  Future<ParticipantModel?> getParticipant(int competitionId);
  Future<ResultCRUD> participateCompetition(int competitionId);
  Future<ResultCRUD> attendanceCompetition(String seedsCode);
}
