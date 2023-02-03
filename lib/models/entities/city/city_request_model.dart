import 'package:unicec_mobi/models/common/paging_request.dart';

class CityRequestModel extends PagingRequest{
  String? name;
  bool? status;

  CityRequestModel({this.name, this.status});
}