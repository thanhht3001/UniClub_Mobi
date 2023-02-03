import 'package:unicec_mobi/models/common/paging_request.dart';

class MemberTakesActivityRequestModel extends PagingRequest{
  int competitionActivityId;
  int clubId;

  MemberTakesActivityRequestModel({required this.competitionActivityId, required this.clubId});
}