import 'package:unicec_mobi/models/entities/city/city_model.dart';
import 'package:unicec_mobi/models/entities/city/city_request_model.dart';

abstract class ICityService{
  Future<CityModel> getCitiesByConditions(CityRequestModel request);
  Future<CityModel> getById(int id);
}