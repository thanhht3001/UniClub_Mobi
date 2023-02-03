import 'package:unicec_mobi/models/entities/city/city_request_model.dart';
import 'package:unicec_mobi/models/entities/city/city_model.dart';
import 'package:unicec_mobi/services/city_svc/i_city_service.dart';

class CityService implements ICityService {
  @override
  Future<CityModel> getById(int id) {
    // TODO: implement getById
    throw UnimplementedError();
  }

  @override
  Future<CityModel> getCitiesByConditions(CityRequestModel request) {
    // TODO: implement getCitiesByConditions
    throw UnimplementedError();
  }
}
