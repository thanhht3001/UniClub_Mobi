import 'package:unicec_mobi/models/common/paging_request.dart';

class MemberInCompetitionRequestModel extends PagingRequest{
  int competitionId;
  int clubId;

  MemberInCompetitionRequestModel({required this.competitionId, required this.clubId});
}