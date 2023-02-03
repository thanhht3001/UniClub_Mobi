import 'package:unicec_mobi/models/common/paging_request.dart';

class MajorRequestModel extends PagingRequest{
  String? name;
  bool? status;

  MajorRequestModel({this.name, this.status});
}