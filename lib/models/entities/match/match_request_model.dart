import 'package:unicec_mobi/models/common/paging_request.dart';
import 'package:unicec_mobi/models/enums/match_status.dart';

class MatchRequestModel extends PagingRequest{
  int? competitionId;
  int? roundId;
  int? matchTypeId;
  DateTime? startTime;
  DateTime? endTime;
  MatchStatus? status;

  MatchRequestModel({
    this.competitionId,
    this.roundId,
    this.matchTypeId,
    this.startTime,
    this.endTime,
    this.status
  });
}