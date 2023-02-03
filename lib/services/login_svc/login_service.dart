import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:unicec_mobi/models/entities/club/club_model.dart';
import 'package:unicec_mobi/models/entities/member/member_detail_model.dart';

import '../../models/common/current_user.dart';
import '../../models/entities/uni_selector/uni_selector_model.dart';
import '../../utils/adapter.dart';
import '../../utils/api.dart';
import '../../utils/log.dart';
import 'i_login_service.dart';

class LoginService implements ILoginService {
  Adapter adapter = Adapter();

  @override
  Future<UniSelectorModel?> getUniSelector(String? idToken) async {
    var client = http.Client();
    String url = Api.GetUrl(apiPath: Api.authentication);
    String tokenDevice = (await FirebaseMessaging.instance.getToken())!;
    try {
      var response =
          // await client.post(Uri.parse(url), headers: Api.GetHeader(idToken));
          await client.post(Uri.parse(url),
              headers: Api.GetHeaderForLogin(idToken, tokenDevice));

      if (response.statusCode == 400) {
        return null;
      }
      if (response.statusCode == 200) {
        Log.info('URL: $response');
        //
        Map<String, dynamic> result = adapter.parseToMap(response);
        //
        UniSelectorModel userInfo = UniSelectorModel.fromJson(result);

        return userInfo;
      }
    } catch (e) {
      Log.error(e.toString());
    } finally {
      client.close();
    }
    return null;
  }

  // @override
  // Future<List<ClubModel>> getListClubsBelongToStudent(int? userId) async {
  //   var client = http.Client();
  //   String url = Api.GetUrl(apiPath: Api.clubsBelongToStudent);

  //   url += "/" + userId.toString();

  //   String? idToken = GetIt.I.get<CurrentUser>().idToken;
  //   try {
  //     var response = await client.get(Uri.parse(url), headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //       'Authorization': "Bearer $idToken"
  //     });

  //     if (response.statusCode == 200) {
  //       //
  //       List<dynamic> resultList = adapter.parseToList(response);

  //       if (resultList.isEmpty) {
  //         return [];
  //       }
  //       //
  //       List<ClubModel> clubsBelongToStudent = [];
  //       //
  //       for (var element in resultList) {
  //         ClubModel model = ClubModel.fromJson(element);
  //         clubsBelongToStudent.add(model);
  //       }

  //       return clubsBelongToStudent;
  //     }
  //   } catch (e) {
  //     Log.error(e.toString());
  //   } finally {
  //     client.close();
  //   }
  //   return [];
  // }

  @override
  Future<MemberDetailModel?> getMemberBelongToClub(int? clubId) async {
    var client = http.Client();
    String url = Api.GetUrl(apiPath: Api.members);
    url += "/info?clubId=$clubId";
    String? idToken = GetIt.I.get<CurrentUser>().idToken;
    try {
      var response =
          await client.get(Uri.parse(url), headers: Api.GetHeader(idToken));

      if (response.statusCode == 400) {
        Log.error(response.body.toString());
      }
      if (response.statusCode == 200) {
        List<dynamic> result = adapter.parseToList(response);

        if (result.isEmpty) {
          return null;
        }

        //
        List<MemberDetailModel> membersBelongToClubs = [];
        //
        for (var element in result) {
          MemberDetailModel model = MemberDetailModel.fromJson(element);
          membersBelongToClubs.add(model);
        }

        return membersBelongToClubs[0];
      }
    } catch (e) {
      Log.error(e.toString());
    } finally {
      client.close();
    }
    return null;
  }
}
