import 'package:unicec_mobi/models/common/paging_request.dart';

class ClubRequestModel extends PagingRequest{
  int universityId;
  String? name;
  bool? status;

  ClubRequestModel({required this.universityId, this.name, this.status});
}