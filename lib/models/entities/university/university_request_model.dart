import 'package:unicec_mobi/models/common/paging_request.dart';

class UniversityRequestModel extends PagingRequest {
  String? name;
  int? cityId;
  bool? status;

  UniversityRequestModel({this.name, this.cityId, this.status});
}
