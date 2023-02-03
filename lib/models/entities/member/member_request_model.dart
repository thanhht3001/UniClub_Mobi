import 'package:unicec_mobi/models/common/paging_request.dart';
import 'package:unicec_mobi/models/enums/member_status.dart';

class MemberRequestModel extends PagingRequest{
  int clubId;
  String? searchString;
  int? clubRoleId;
  DateTime? startTime;
  DateTime? endTime;
  MemberStatus? status;
  bool? isOnline;

  MemberRequestModel({
    required this.clubId,
    this.searchString,
    this.clubRoleId,
    this.startTime,
    this.endTime,
    this.status,
    this.isOnline
  });
}