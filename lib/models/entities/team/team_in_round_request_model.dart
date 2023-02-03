import '../../common/paging_request.dart';

class TeamInRoundRequestModel extends PagingRequest {
  int roundId;

  TeamInRoundRequestModel({required this.roundId});
}
