import '../../common/paging_request.dart';
import '../../enums/team_status.dart';

class TeamRequestModel extends PagingRequest {
  int competitionId;
  String? teamName;
  TeamStatus? status;

  TeamRequestModel({required this.competitionId, this.teamName, this.status});
}
