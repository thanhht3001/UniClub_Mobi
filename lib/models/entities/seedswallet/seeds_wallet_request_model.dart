import 'package:unicec_mobi/models/common/paging_request.dart';

class SeedsWalletRequestModel extends PagingRequest{
  int? universityId;
  int? studentId;
  double? amount;
  bool? status;

  SeedsWalletRequestModel({
    this.universityId,
    this.studentId,
    this.amount,
    this.status
  });
}