import 'package:unicec_mobi/models/common/paging_request.dart';

class DepartmentRequestModel extends PagingRequest{
  int universityId;
  int? majorId;
  String? name;
  bool? status;

  DepartmentRequestModel({
    required this.universityId,
    this.majorId,
    this.name,
    this.status
  });
}