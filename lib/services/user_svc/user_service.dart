import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:unicec_mobi/models/common/current_user.dart';
import 'package:unicec_mobi/models/entities/department/department_model.dart';
import 'package:unicec_mobi/models/entities/seedswallet/seeds_wallet_model.dart';
import 'package:unicec_mobi/models/entities/university/university_model.dart';
import 'package:unicec_mobi/models/entities/user/user_model.dart';
import 'package:unicec_mobi/services/user_svc/i_user_service.dart';
import 'package:http/http.dart' as http;
import 'package:unicec_mobi/utils/adapter.dart';
import 'package:unicec_mobi/utils/api.dart';
import 'package:unicec_mobi/utils/log.dart';

import '../../models/common/paging_result.dart';
import '../../models/common/resultCRUD.dart';

class UserService implements IUserService {
  Adapter adapter = Adapter();

  @override
  Future<UserModel?> getById(int id) async {
    // TODO: implement getById
    var client = http.Client();
    String url = Api.GetUrl(apiPath: "${Api.users}/$id");
    String token = GetIt.I.get<CurrentUser>().idToken;
    try {
      var response =
          await client.get(Uri.parse(url), headers: Api.GetHeader(token));
      if (response.statusCode == 200) {
        Map<String, dynamic> result = adapter.parseToMap(response);
        return UserModel.fromJson(result);
      }
    } catch (e) {
      Log.error(e.toString());
    } finally {
      client.close();
    }

    return null;
  }

  @override
  Future<UniversityModel?> getUniById(int universityId) async {
    var client = http.Client();
    String url = Api.GetUrl(apiPath: '${Api.universities}/$universityId');
    String token = GetIt.I.get<CurrentUser>().idToken;

    try {
      var response =
          await client.get(Uri.parse(url), headers: Api.GetHeader(token));
      if (response.statusCode == 200) {
        Map<String, dynamic> json = adapter.parseToMap(response);
        return UniversityModel.fromJson(json);
      }
    } catch (e) {
      Log.error(e.toString());
    }

    return null;
  }

  @override
  Future<DepartmentModel?> getDepartmentById(int departmentId) async {
    var client = http.Client();
    String url = Api.GetUrl(apiPath: '${Api.departments}/$departmentId');
    String token = GetIt.I.get<CurrentUser>().idToken;

    try {
      var response =
          await client.get(Uri.parse(url), headers: Api.GetHeader(token));
      if (response.statusCode == 200) {
        Map<String, dynamic> json = adapter.parseToMap(response);
        return DepartmentModel.fromJson(json);
      }
    } catch (e) {
      Log.error(e.toString());
    }

    return null;
  }

  @override
  Future<SeedsWalletModel?> getSeedsWalletByUser(int userId) async {
    var client = http.Client();
    String params = '?studentId=$userId';

    String url = Api.GetUrl(apiPath: '${Api.seedsWallets}/search$params');
    String token = GetIt.I.get<CurrentUser>().idToken;

    try {
      var response =
          await client.get(Uri.parse(url), headers: Api.GetHeader(token));
      if (response.statusCode == 200 && response.body.isNotEmpty) {
        Map<String, dynamic> json = adapter.parseToMap(response);
        var items = json['items'][0];
        print('getSeedsWalletByUser: $items');
        return SeedsWalletModel.fromJson(items);
      }
    } catch (e) {      
      Log.error("getSeedsWalletByUser: ${e.toString()}");
    }

    return null;
  }

  @override
  Future<ResultCRUD> updateUser(UserModel user) async {
    var client = http.Client();
    String url = Api.GetUrl(apiPath: Api.users);
    String token = GetIt.I.get<CurrentUser>().idToken;

    try {
      var response = await client.put(Uri.parse(url),
          headers: Api.GetHeader(token),
          body: jsonEncode(<String, dynamic>{
            "id": user.id,
            "department_id": user.departmentId,
            "student_code": user.studentCode,
            "fullname": user.fullname,
            "email": user.email,
            "phone_number": user.phoneNumber,
            "gender": user.gender,
            "status": user.status.index,
            "dob": user.dob,
            "description": user.description,
            "avatar": user.avatar,
            "is_online": true // default status
          }));
      return (response.statusCode == 200)
          ? ResultCRUD(errorMessage: 'Cập nhật thành công', check: true, returnIntData: -1)
          : ResultCRUD(
              errorMessage: response.body.toString(),
              check: false,
              returnIntData: -1);
    } catch (error) {
      Log.error(error.toString());
    }

    return ResultCRUD(
        errorMessage: '', check: false, returnIntData: -1); // avoid error
  }

  @override
  Future<PagingResult<DepartmentModel>?> loadDepartmentsByUni(
      int universityId) async {
    var client = http.Client();
    String params = '?universityId=$universityId';
    String url = Api.GetUrl(apiPath: '${Api.departments}/search$params');
    String token = GetIt.I.get<CurrentUser>().idToken;

    try {
      var response =
          await client.get(Uri.parse(url), headers: Api.GetHeader(token));
      if (response.statusCode == 200) {
        Map<String, dynamic> json = adapter.parseToMap(response);
        return PagingResult.fromJson(json, DepartmentModel.fromJson);
      }
    } catch (error) {
      Log.error(error.toString());
    }

    return null;
  }
}
