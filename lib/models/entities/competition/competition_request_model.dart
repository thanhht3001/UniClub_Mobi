import 'package:unicec_mobi/models/common/paging_request.dart';

import '../../enums/competition_scope_status.dart';

class CompetitionRequestModel extends PagingRequest {
  int? clubId;
  int? universityId;
  bool? event;
  String? name;
  CompetitionScopeStatus? scope;
  bool? viewMost;
  List<int>? statuses;

  CompetitionRequestModel(
      {this.clubId,
      this.universityId,
      this.event,
      this.name,
      this.scope,
      this.viewMost,
      this.statuses});
}
