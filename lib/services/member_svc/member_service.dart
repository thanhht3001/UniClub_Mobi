import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:unicec_mobi/models/entities/club_role/club_role_model.dart';
import '/models/entities/member/member_model.dart';
import '/services/member_svc/i_member_service.dart';
import '/utils/api.dart';
import '../../models/common/current_user.dart';
import '../../models/entities/member/member_detail_model.dart';
import '../../models/enums/member_status.dart';
import '../../utils/adapter.dart';
import '../../utils/log.dart';

class MemberService implements IMemberService {
  Adapter adapter = Adapter();
  @override
  Future<MemberModel?> applyInClub(int clubId) async {
    var client = http.Client();
    String url = Api.GetUrl(apiPath: Api.members);
    //
    url += "/apply/club/${clubId}";

    //get_it lấy IdToken
    String? idToken = GetIt.I.get<CurrentUser>().idToken;
    int? userId = GetIt.I.get<CurrentUser>().id;
    try {
      var response = await client.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': "Bearer $idToken"
        },
        // //truyền vào body
        // body: jsonEncode(<String, dynamic>{"id": clubId})
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> result = adapter.parseToMap(response);
        MemberModel member = MemberModel.fromJson(result);
        return member;
      }
    } catch (e) {
      Log.error(e.toString());
    } finally {
      client.close();
    }
    return null;
  }

  @override
  Future<MemberStatus> getStatusMember(int clubId) async {
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
          return MemberStatus.Student;
        }
        //
        List<MemberDetailModel> membersBelongToClubs = [];
        //
        for (var element in result) {
          MemberDetailModel model = MemberDetailModel.fromJson(element);
          membersBelongToClubs.add(model);
        }
        if (membersBelongToClubs[0].status == MemberStatus.Pending) {
          return MemberStatus.Pending;
        }
        if (membersBelongToClubs[0].status == MemberStatus.Active) {
          return MemberStatus.Active;
        }
      }
    } catch (e) {
      Log.error(e.toString());
    } finally {
      client.close();
    }
    return MemberStatus.InActive;
  }

  @override
  Future<List<MemberModel>?> getListMemberByClub(
      int clubId, String? searchName, int? clubRoleId) async {
    var client = http.Client();
    String url = Api.GetUrl(apiPath: Api.members);

    url += "/by-club?clubId=$clubId";

    if (searchName != null) {
      url += "&searchName=${searchName}";
    }

    if (clubRoleId != null) {
      url += "&roleId=${clubRoleId}";
    }

    String? idToken = GetIt.I.get<CurrentUser>().idToken;
    try {
      var response =
          await client.get(Uri.parse(url), headers: Api.GetHeader(idToken));
      if (response.statusCode == 200) {
        List<dynamic> result = adapter.parseToList(response);
        if (result.isEmpty) {
          return null;
        }
        //
        List<MemberModel> membersBelongToClubs = [];
        //
        for (var element in result) {
          MemberModel model = MemberModel.fromJson(element);
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
  Future<List<ClubRoleModel>?> getListClubRole() async {
    var client = http.Client();
    String url = Api.GetUrl(apiPath: Api.clubRoles);
    String? idToken = GetIt.I.get<CurrentUser>().idToken;
    try {
      var response =
          await client.get(Uri.parse(url), headers: Api.GetHeader(idToken));
      if (response.statusCode == 200) {
        List<dynamic> result = adapter.parseToList(response);
        if (result.isEmpty) {
          return null;
        }
        //
        List<ClubRoleModel> clubRole = [];
        //
        for (var element in result) {
          ClubRoleModel model = ClubRoleModel.fromJson(element);
          clubRole.add(model);
        }
        return clubRole;
      }
    } catch (e) {
      Log.error(e.toString());
    } finally {
      client.close();
    }
    return null;
  }
}
