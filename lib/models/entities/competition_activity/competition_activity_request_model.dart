import 'package:unicec_mobi/models/common/paging_request.dart';
import 'package:unicec_mobi/models/enums/competition_activity_status.dart';

import '../../enums/priority_status.dart';

class CompetitionActivityRequestModel extends PagingRequest {
  int? competitionId;
  PriorityStatus? priority;
  List<CompetitionActivityStatus>? statuses;
  String? name;
  //int? clubId;

  CompetitionActivityRequestModel(
      {this.competitionId, this.priority, this.statuses, this.name
      //this.clubId
      });
}
