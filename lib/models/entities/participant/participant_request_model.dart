import 'package:unicec_mobi/models/common/paging_request.dart';

class ParticipantRequestModel extends PagingRequest{
  int? competitionId;
  bool? hasTeam;
  int clubId;

  ParticipantRequestModel({this.competitionId, this.hasTeam, required this.clubId});
}