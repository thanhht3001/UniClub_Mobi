import 'package:get_it/get_it.dart';
import 'package:unicec_mobi/models/common/paging_result.dart';
import 'package:unicec_mobi/models/entities/club/club_model.dart';
import 'package:http/http.dart' as http;
import 'package:unicec_mobi/models/entities/member/member_detail_model.dart';
import '../../models/common/current_user.dart';
import '../../models/common/paging_request.dart';
import '../../utils/adapter.dart';
import '../../utils/api.dart';
import '../../utils/log.dart';
import 'i_club_service.dart';

class ClubService implements IClubService {
  Adapter adapter = Adapter();

  @override
  Future<ClubModel?> getClubSelected(int? clubId) async {
    var client = http.Client();
    String url = Api.GetUrl(apiPath: Api.clubs);
    url += "/$clubId";
    //get_it lấy IdToken
    String? idToken = GetIt.I.get<CurrentUser>().idToken;
    try {
      var response =
          await client.get(Uri.parse(url), headers: Api.GetHeader(idToken));
      if (response.statusCode == 200) {
        Map<String, dynamic> result = adapter.parseToMap(response);
        ClubModel club = ClubModel.fromJson(result);
        return club;
      }
    } catch (e) {
      Log.error(e.toString());
    } finally {
      client.close();
    }
    return null;
  }

  @override
  Future<PagingResult<ClubModel>?> getClubsBelongToUniversity(
      PagingRequest request) async {
    String? idToken = GetIt.I.get<CurrentUser>().idToken;
    int? universityId = GetIt.I.get<CurrentUser>().universityId;

    var client = http.Client();
    String url = Api.GetUrl(apiPath: Api.clubs);

    url += "/search";
    url += "?universityId=$universityId";
    url += "&status=true";
    url += "&currentPage=${request.currentPage}";
    url += "&pageSize=${request.pageSize}";

    try {
      var response =
          await client.get(Uri.parse(url), headers: Api.GetHeader(idToken));
      if (response.statusCode == 200) {
        String isList = "[]";
        if (response.statusCode == 200) {
          if (response.body.toString().compareTo(isList) == 0) { // compare response body with empty list
            //TH1
            // List<dynamic> list = adapter.parseToList(response);
            return null;
          } else {
            //TH2
            Map<String, dynamic> result = adapter.parseToMap(response);
            PagingResult<ClubModel> pagingResult =
                PagingResult.fromJson(result, ClubModel.fromJson);
            return pagingResult;
          }
        }
      }
    } catch (e) {
      Log.error(e.toString());
    } finally {
      client.close();
    }
    return PagingResult(
        currentPage: 0,
        totalPages: 0,
        pageSize: 0,
        totalCount: 0,
        hasNext: false,
        hasPrevious: false,
        items: []);
  }

  @override
  Future<MemberDetailModel?> getMemberSelected(int? clubId) async {
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

  @override
  Future<List<MemberDetailModel>?> getMembersBelongToClubs() async {
    var client = http.Client();
    String url = Api.GetUrl(apiPath: Api.members);
    url += "/info";
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

        return membersBelongToClubs;
      }
    } catch (e) {
      Log.error(e.toString());
    } finally {
      client.close();
    }
    return null;
  }

  @override
  Future<List<ClubModel>> getListClubsBelongToStudent(int? userId) async {
    var client = http.Client();
    String url = Api.GetUrl(apiPath: Api.clubsBelongToStudent);

    url += "/$userId";

    String? idToken = GetIt.I.get<CurrentUser>().idToken;
    try {
      var response = await client.get(Uri.parse(url), headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $idToken"
      });

      if (response.statusCode == 200) {
        //
        List<dynamic> resultList = adapter.parseToList(response);

        if (resultList.isEmpty) {
          return [];
        }
        //
        List<ClubModel> clubsBelongToStudent = [];
        //
        for (var element in resultList) {
          ClubModel model = ClubModel.fromJson(element);
          clubsBelongToStudent.add(model);
        }

        return clubsBelongToStudent;
      }
    } catch (e) {
      Log.error(e.toString());
    } finally {
      client.close();
    }
    return [];
  }

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

  @override
  Future<bool> outClubOfMember(int memberId) async {
    var client = http.Client();
    String url = Api.GetUrl(apiPath: "${Api.members}/$memberId");
    String? token = GetIt.I.get<CurrentUser>().idToken;
    
    try{
      var response = await client.delete(Uri.parse(url), headers: Api.GetHeader(token));
      return (response.statusCode == 204) ? true : false;

    }catch(e){
      Log.error(e.toString());
    }
    
    return false;
  }
}
