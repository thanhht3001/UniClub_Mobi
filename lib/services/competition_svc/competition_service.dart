import 'package:get_it/get_it.dart';
import '/models/common/current_user.dart';
import '/models/common/paging_result.dart';
import '/models/entities/competition/competition_detail_model.dart';
import '/models/entities/competition/competition_model.dart';
import '/models/entities/competition/competition_request_model.dart';
import '/models/entities/competition/competition_show_model.dart';
import '/models/entities/team/team_model.dart';
import '/services/competition_svc/i_competition_service.dart';

import 'package:http/http.dart' as http;
import '/utils/log.dart';
import '../../models/enums/competition_scope_status.dart';
import '../../utils/adapter.dart';
import '../../utils/api.dart';

class CompetitionService implements ICompetitionService {
  Adapter adapter = Adapter();

  //load out standing
  @override
  Future<PagingResult<CompetitionShowModel>?> loadCompetition(
      CompetitionRequestModel request) async {
    var client = http.Client();
    String params = '?';
    //lấy thằng status đầu tiên
    params += 'statuses=${request.statuses?[0]}';
    //remove thằng status đầu tiên ra
    request.statuses?.removeAt(0);

    if (request.clubId != null) {
      params += '&clubId=${request.clubId}';
    }

    if (request.scope != null) {
      params += '&scope=${request.scope?.index}';
    }

    if (request.viewMost != null) {
      params += '&viewMost=${request.viewMost}';
    }

    if (request.name != null) {
      params += '&name=${request.name}';
    }

    if (request.statuses != null) {
      request.statuses?.forEach((element) {
        params += '&statuses=$element';
      });
    }
    if (request.event != null) {
      params += '&event=${request.event}';
    }
    if (request.universityId != null) {
      params += '&universityId=${request.universityId}';
    }

    String url = Api.GetUrl(apiPath: '${Api.competitions}$params&pageSize=5');
    String? token = GetIt.I.get<CurrentUser>().idToken;
    try {
      var response =
          await client.get(Uri.parse(url), headers: Api.GetHeader(token));

      String isList = "[]";
      if (response.statusCode == 200) {
        if (response.body.toString().compareTo(isList) == 0) {
          //TH1
          List<dynamic> list = adapter.parseToList(response);
          return null;
        } else {
          //TH2
          Map<String, dynamic> json = adapter.parseToMap(response);
          return PagingResult.fromJson(json, CompetitionShowModel.fromJson);
        }
      }
    } catch (e) {
      Log.error(e.toString());
    }

    return null;
  }

  @override
  Future<TeamModel?> LoadTeamsInCompetitions(int competitionId) async {
    // TODO: implement LoadTeamsInCompetitions
    var client = http.Client();
    String url =
        Api.GetUrl(apiPath: '${Api.teams}/all?competitionId=$competitionId');
    String token = GetIt.I.get<CurrentUser>().idToken;

    try {
      var response =
          await client.get(Uri.parse(url), headers: Api.GetHeader(token));
      if (response.statusCode == 200) {
        Map<String, dynamic> json = adapter.parseToMap(response);
        return TeamModel.fromJson(json);
      }
    } catch (e) {
      Log.error(e.toString());
    }

    return null;
  }

  //show Competition Loading use LoadMore not outStanding
  @override
  Future<PagingResult<CompetitionShowModel>?> showCompetition(
      CompetitionRequestModel request, int currentPage) async {
    var client = http.Client();
    String params = '?';
    //lấy thằng status đầu tiên
    params += 'statuses=${request.statuses?[0]}';
    //remove thằng status đầu tiên ra
    request.statuses?.removeAt(0);

    if (request.clubId != null) {
      params += '&clubId=${request.clubId}';
    }

    if (request.scope != null) {
      params += '&scope=${request.scope?.index}';
    }

    if (request.viewMost != null) {
      params += '&viewMost=${request.viewMost}';
    }

    if (request.name != null) {
      params += '&name=${request.name}';
    }

    if (request.statuses != null) {
      request.statuses?.forEach((element) {
        params += '&statuses=$element';
      });
    }
    if (request.event != null) {
      params += '&event=${request.event}';
    }
    if (request.universityId != null) {
      params += '&universityId=${request.universityId}';
    }

    String url = Api.GetUrl(
        apiPath:
            '${Api.competitions}$params&currentPage=${currentPage}&pageSize=5');
    String? token = GetIt.I.get<CurrentUser>().idToken;
    try {
      var response =
          await client.get(Uri.parse(url), headers: Api.GetHeader(token));

      String isList = "[]";
      if (response.statusCode == 200) {
        if (response.body.toString().compareTo(isList) == 0) {
          //TH1
          List<dynamic> list = adapter.parseToList(response);
          return null;
        } else {
          //TH2
          Map<String, dynamic> json = adapter.parseToMap(response);
          return PagingResult.fromJson(json, CompetitionShowModel.fromJson);
        }
      }
    } catch (e) {
      Log.error(e.toString());
    }

    return null;
  }

  @override
  Future<CompetitionDetailModel?> loadDetailById(int competitionId) async {
    var client = http.Client();
    String url = Api.GetUrl(apiPath: '${Api.competitions}/$competitionId');
    String token = GetIt.I.get<CurrentUser>().idToken;
    try {
      var response =
          await client.get(Uri.parse(url), headers: Api.GetHeader(token));
      if (response.statusCode == 200) {
        Map<String, dynamic> json = adapter.parseToMap(response);
        return CompetitionDetailModel.fromJson(json);
      }
    } catch (e) {
      Log.error(e.toString());
    }

    return null;
  }

  //TA
  @override
  Future<PagingResult<CompetitionModel>?> loadCompetitionMemberTask(
      int currentPage, String? searchName, bool isEvent) async {
    var client = http.Client();
    //
    int clubIdSelected = GetIt.I.get<CurrentUser>().clubIdSelected;
    String url = Api.GetUrl(
        apiPath:
            '${Api.competitions}/student-is-assigned?clubId=$clubIdSelected' +
                "&pageSize=10&currentPage=$currentPage" +
                "&event=${isEvent}");

    //search name
    if (searchName != null) {
      url += "&name=${searchName}";
    }

    String token = GetIt.I.get<CurrentUser>().idToken;
    try {
      var response =
          await client.get(Uri.parse(url), headers: Api.GetHeader(token));
      String isList = "[]";
      if (response.statusCode == 200) {
        if (response.body.toString().compareTo(isList) == 0) {
          //TH1
          List<dynamic> list = adapter.parseToList(response);
          return null;
        } else {
          //TH2
          Map<String, dynamic> json = adapter.parseToMap(response);
          return PagingResult.fromJson(json, CompetitionModel.fromJson);
        }
      }
    } catch (e) {
      Log.error(e.toString());
    }
    return null;
  }

  @override
  Future<PagingResult<CompetitionModel>?> loadCompetitionParticipant(
      int currentPage,
      CompetitionScopeStatus? scope,
      String? name,
      bool? isEvent) async {
    var client = http.Client();
    String url = Api.GetUrl(
        apiPath:
            '${Api.competitions}/student-join-competitions?pageSize=5&currentPage=$currentPage');

    if (scope != null) {
      url += "&scope=${scope.index}";
    }

    if (name != null) {
      url += "&name=${name}";
    }

    if (isEvent != null) {
      url += "&event=${isEvent}";
    }

    String token = GetIt.I.get<CurrentUser>().idToken;
    try {
      var response =
          await client.get(Uri.parse(url), headers: Api.GetHeader(token));
      String isList = "[]";
      if (response.statusCode == 200) {
        if (response.body.toString().compareTo(isList) == 0) {
          //TH1
          List<dynamic> list = adapter.parseToList(response);
          return null;
        } else {
          //TH2
          Map<String, dynamic> json = adapter.parseToMap(response);
          return PagingResult.fromJson(json, CompetitionModel.fromJson);
        }
      }
    } catch (e) {
      Log.error(e.toString());
    }
    return null;
  }
}
