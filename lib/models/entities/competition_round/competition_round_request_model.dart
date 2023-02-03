import 'package:unicec_mobi/models/common/paging_request.dart';

class CompetitionRoundRequestModel extends PagingRequest{
  int competitionId;
  String? title;
  DateTime? startTime;
  DateTime? endTime;
  List<int>? statuses;

  CompetitionRoundRequestModel({
    required this.competitionId,
    this.title,
    this.startTime,
    this.endTime,
    this.statuses
  });
}