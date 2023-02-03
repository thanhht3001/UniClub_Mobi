import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:unicec_mobi/models/entities/department/department_model.dart';
import 'package:unicec_mobi/models/entities/university/university_model.dart';

import '../../models/common/current_user.dart';
import '../../models/entities/user/complete_profile.dart';
import '../../utils/adapter.dart';
import '../../utils/api.dart';
import '../../utils/log.dart';
import 'i_university_selection_service.dart';
import 'package:http/http.dart' as http;

class UniversitySelectionService implements IUniversitySelectionService {
  @override
  Future<bool> completeProfile(CompleteProfile model) async {
    Adapter adapter = Adapter();

    var client = http.Client();
    String url = Api.GetUrl(apiPath: Api.usersUpdateWithJWT);

    //get_it lấy IdToken
    String? idToken = GetIt.I.get<CurrentUser>().idToken;
    int? userId = GetIt.I.get<CurrentUser>().id;

    try {
      var response = await client.put(Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': "Bearer $idToken"
          },
          //truyền vào body
          body: jsonEncode(<String, dynamic>{
            "id": userId,
            "university_id": model.universityId,
            "department_id": model.departmentId,
            "student_code": model.studentCode,
            "phone": model.phone,
            "gender": model.gender,
            "dob": model.dob,
            "description": model.description
          }));
      // if (response.statusCode == 400) {
      // }
      if (response.statusCode == 200) {
        String token = adapter.parseToString(response);
        GetIt.I.get<CurrentUser>().idToken = token;
        GetIt.I.get<CurrentUser>().universityId = model.universityId;
        return true;
      }
    } catch (e) {
      Log.error(e.toString());
    } finally {
      client.close();
    }
    return false;
  }

  @override
  Future<List<DepartmentModel>?> getDepartmentByUni(int universityId) async {
    Adapter adapter = Adapter();

    var client = http.Client();
    String url = Api.GetUrl(apiPath: Api.departments);
    
    //chỗ này phải thêm hàm get department trả ra list chứ kh đc paging
    url += "/all-by-uni?universityId=$universityId";

    try {
      //get_it lấy IdToken
      String? idToken = GetIt.I.get<CurrentUser>().idToken;

      var response = await client.get(Uri.parse(url), headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $idToken"
      });

      if (response.statusCode == 200) {
        List<dynamic> result = adapter.parseToList(response);
        if (result.isEmpty) {
          return null;
        }
        List<DepartmentModel> departments = [];
        for (dynamic department in result) {
          departments.add(DepartmentModel.fromJson(department));
        }
        return departments;
      }
    } catch (e) {
      Log.error(e.toString());
    } finally {
      client.close();
    }
    return null;
  }

  @override
  Future<List<UniversityModel>?> getUniversities() async {
    Adapter adapter = Adapter();

    var client = http.Client();
    String url = Api.GetUrl(apiPath: Api.universities);

    //PagingResult<DepartmentModel> pagingResult;

    url += "/all";

    try {
      //get_it lấy IdToken
      String? idToken = GetIt.I.get<CurrentUser>().idToken;

      var response = await client.get(Uri.parse(url), headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $idToken"
      });

      if (response.statusCode == 200) {
        List<dynamic> result = adapter.parseToList(response);
        if (result.isEmpty) {
          return null;
        }
        List<UniversityModel> universities = [];
        for (dynamic uni in result) {
          universities.add(UniversityModel.fromJson(uni));
        }
        return universities;
      }
    } catch (e) {
      Log.error(e.toString());
    } finally {
      client.close();
    }
    return null;
  }
}
