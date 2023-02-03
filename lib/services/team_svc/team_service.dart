import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:unicec_mobi/models/entities/team/team_in_competition_model.dart';
import 'package:unicec_mobi/models/entities/team/team_in_round_model.dart';
import 'package:unicec_mobi/models/enums/team_status.dart';
import '../../models/common/resultCRUD.dart';
import '../../models/entities/participant/participant_in_team_model.dart';
import '../../models/entities/team/team_in_round_request_model.dart';
import '/models/entities/team/team_request_model.dart';
import '/models/entities/team/team_model.dart';
import '/services/team_svc/i_team_service.dart';
import '/utils/adapter.dart';

import 'package:http/http.dart' as http;
import '/utils/api.dart';
import '/utils/log.dart';

import '../../models/common/current_user.dart';
import '../../models/common/paging_result.dart';
import '../../models/entities/team/team_detail_model.dart';

class TeamService extends ITeamService {
  Adapter adapter = Adapter();

  @override
  Future<TeamDetailModel?> GetCurrentTeam(int teamId, int competitionId) async {
    var client = http.Client();
    String params = '?teamId=$teamId&competitionId=$competitionId';
    String url = Api.GetUrl(apiPath: '${Api.teams}/detail$params');
    String token = GetIt.I.get<CurrentUser>().idToken;

    try {
      var response =
          await client.get(Uri.parse(url), headers: Api.GetHeader(token));
      if (response.statusCode == 200) {
        Map<String, dynamic> json = adapter.parseToMap(response);
        return TeamDetailModel.fromJson(json);
      }
    } catch (e) {
      Log.error(e.toString());
    }

    return null;
  }

  @override
  Future<PagingResult<TeamModel>?> GetListTeam(TeamRequestModel request) async {
    var client = http.Client();
    String params = '?';

    //competitionId
    if (request.competitionId != null) {
      params += 'competitionId=${request.competitionId}';
    }

    //teamName
    if (request.teamName != null) {
      params += '&teamName=${request.teamName}';
    }

    //status
    if (request.status != null) {
      params += '&status=${request.status?.index}';
    }

    //currentPage
    if (request.currentPage != null) {
      params += '&currentPage=${request.currentPage}';
    }

    String url = Api.GetUrl(apiPath: '${Api.teams}/all$params');
    String? token = GetIt.I.get<CurrentUser>().idToken;

    try {
      var response =
          await client.get(Uri.parse(url), headers: Api.GetHeader(token));
      if (response.statusCode == 200) {
        String isList = "[]";
        if (response.body.toString().compareTo(isList) == 0) {
          List<dynamic> json = adapter.parseToList(response);
          //TH1
          return null;
        } else {
          //TH2
          Map<String, dynamic> json = adapter.parseToMap(response);
          return PagingResult.fromJson(json, TeamModel.fromJson);
        }
      }
    } catch (e) {
      Log.error(e.toString());
    }
    return null;
  }

  @override
  Future<ResultCRUD> CreateTeam(
      int competitionId, String teamName, String teamDescription) async {
    var client = http.Client();
    String url = Api.GetUrl(apiPath: '${Api.teams}');
    String? token = GetIt.I.get<CurrentUser>().idToken;
    try {
      var response = await client.post(Uri.parse(url),
          headers: Api.GetHeader(token),
          body: jsonEncode(<String, dynamic>{
            "competition_id": competitionId,
            "name": teamName,
            "description": teamDescription
          }));
      if (response.statusCode == 200) {
        // here
        Map<String, dynamic> json = adapter.parseToMap(response);
        TeamModel team = TeamModel.fromJson(json);
        ResultCRUD result =
            ResultCRUD(check: true, errorMessage: '', returnIntData: team.id);
        return result;
      }
      if (response.statusCode == 400) {
        ResultCRUD result = ResultCRUD(
            check: false, errorMessage: response.body, returnIntData: -1);
        return result;
      }
    } catch (e) {
      Log.error(e.toString());
    }
    return ResultCRUD(
        check: false, errorMessage: 'Lỗi rồi!', returnIntData: -1);
  }

  @override
  Future<ResultCRUD> JoinTeam(String InvitedCode) async {
    var client = http.Client();
    String url = Api.GetUrl(apiPath: '${Api.teams}/add-participant');
    String? token = GetIt.I.get<CurrentUser>().idToken;
    try {
      var response = await client.post(Uri.parse(url),
          headers: Api.GetHeader(token),
          body: jsonEncode(<String, dynamic>{"invited_code": InvitedCode}));
      if (response.statusCode == 200) {
        Map<String, dynamic> result = adapter.parseToMap(response);
        ParticipantInTeamModel pit = ParticipantInTeamModel.fromJson(result);
        ResultCRUD returnData = ResultCRUD(
            check: false, errorMessage: '', returnIntData: pit.teamId);
        return returnData;
      }
      if (response.statusCode == 400) {
        ResultCRUD result = ResultCRUD(
            check: false, errorMessage: response.body, returnIntData: -1);
        return result;
      }
    } catch (e) {
      Log.error(e.toString());
    }
    return ResultCRUD(check: false, errorMessage: '', returnIntData: -1);
  }

  @override
  Future<TeamDetailModel?> GetDetailTeamModel(
      int competitionId, int teamId) async {
    var client = http.Client();
    String url = Api.GetUrl(
        apiPath:
            '${Api.teams}/detail?teamId=${teamId}&competitionId=${competitionId}');
    String? token = GetIt.I.get<CurrentUser>().idToken;
    try {
      var response =
          await client.get(Uri.parse(url), headers: Api.GetHeader(token));
      if (response.statusCode == 200) {
        Map<String, dynamic> result = adapter.parseToMap(response);
        TeamDetailModel teamDetail = TeamDetailModel.fromJson(result);
        return teamDetail;
      }
    } catch (e) {
      Log.error(e.toString());
    }
    return null;
  }

  @override
  Future<ResultCRUD> UpdateTeam(int teamId, String teamName,
      String teamDescription, TeamStatus status) async {
    var client = http.Client();
    String url = Api.GetUrl(apiPath: '${Api.teams}');
    String? token = GetIt.I.get<CurrentUser>().idToken;
    try {
      var response = await client.put(Uri.parse(url),
          headers: Api.GetHeader(token),
          body: jsonEncode(<String, dynamic>{
            "team_id": teamId,
            "name": teamName,
            "description": teamDescription,
            "status": status.index
          }));
      if (response.statusCode == 200) {
        ResultCRUD result =
            ResultCRUD(check: true, errorMessage: '', returnIntData: -1);
        return result;
      }
      if (response.statusCode == 400) {
        ResultCRUD result = ResultCRUD(
            check: false, errorMessage: response.body, returnIntData: -1);
        return result;
      }
    } catch (e) {
      Log.error(e.toString());
    }
    return ResultCRUD(
        check: false, errorMessage: 'Lỗi rồi!', returnIntData: -1);
  }

  @override
  Future<ResultCRUD> MemberOutTeam(int teamId) async {
    var client = http.Client();
    String url =
        Api.GetUrl(apiPath: '${Api.teams}/member-out-team?teamId=${teamId}');
    String? token = GetIt.I.get<CurrentUser>().idToken;
    try {
      var response = await client.delete(
        Uri.parse(url),
        headers: Api.GetHeader(token),
      );
      if (response.statusCode == 200) {
        ResultCRUD result =
            ResultCRUD(check: true, errorMessage: '', returnIntData: -1);
        return result;
      }
      if (response.statusCode == 400) {
        ResultCRUD result = ResultCRUD(
            check: false, errorMessage: response.body, returnIntData: -1);
        return result;
      }
    } catch (e) {
      Log.error(e.toString());
    }
    return ResultCRUD(
        check: false, errorMessage: 'Lỗi rồi!', returnIntData: -1);
  }

  @override
  Future<ResultCRUD> DeleteTeam(int teamId) async {
    var client = http.Client();
    String url = Api.GetUrl(apiPath: '${Api.teams}/team?teamId=${teamId}');
    String? token = GetIt.I.get<CurrentUser>().idToken;
    try {
      var response = await client.delete(
        Uri.parse(url),
        headers: Api.GetHeader(token),
      );
      if (response.statusCode == 200) {
        ResultCRUD result =
            ResultCRUD(check: true, errorMessage: '', returnIntData: -1);
        return result;
      }
      if (response.statusCode == 400) {
        ResultCRUD result = ResultCRUD(
            check: false, errorMessage: response.body, returnIntData: -1);
        return result;
      }
    } catch (e) {
      Log.error(e.toString());
    }
    return ResultCRUD(
        check: false, errorMessage: 'Lỗi rồi!', returnIntData: -1);
  }

  @override
  Future<ResultCRUD> DeleteMemberByTeamLeader(
      int teamId, int participantId) async {
    var client = http.Client();
    String url = Api.GetUrl(
        apiPath:
            '${Api.teams}/team/member?teamId=${teamId}&participantId=${participantId}');
    String? token = GetIt.I.get<CurrentUser>().idToken;
    try {
      var response = await client.delete(
        Uri.parse(url),
        headers: Api.GetHeader(token),
      );
      if (response.statusCode == 200) {
        ResultCRUD result =
            ResultCRUD(check: true, errorMessage: '', returnIntData: -1);
        return result;
      }
      if (response.statusCode == 400) {
        ResultCRUD result = ResultCRUD(
            check: false, errorMessage: response.body, returnIntData: -1);
        return result;
      }
    } catch (e) {
      Log.error(e.toString());
    }
    return ResultCRUD(
        check: false, errorMessage: 'Lỗi rồi!', returnIntData: -1);
  }

  @override
  Future<ResultCRUD> UpdateRoleToLeader(int participanInTeamId) async {
    var client = http.Client();
    String url = Api.GetUrl(apiPath: '${Api.teams}/team-role');
    String? token = GetIt.I.get<CurrentUser>().idToken;
    try {
      var response = await client.put(Uri.parse(url),
          headers: Api.GetHeader(token),
          body: jsonEncode(
              <String, dynamic>{"participant_in_team_id": participanInTeamId}));
      if (response.statusCode == 200) {
        ResultCRUD result =
            ResultCRUD(check: true, errorMessage: '', returnIntData: -1);
        return result;
      }
      if (response.statusCode == 400) {
        ResultCRUD result = ResultCRUD(
            check: false, errorMessage: response.body, returnIntData: -1);
        return result;
      }
    } catch (e) {
      Log.error(e.toString());
    }
    return ResultCRUD(
        check: false, errorMessage: 'Lỗi rồi!', returnIntData: -1);
  }

  @override
  Future<PagingResult<TeamInRoundModel>?> GetListTeamInRound(
      TeamInRoundRequestModel request) async {
    var client = http.Client();
    //nếu muốn build thêm param thì đổi tham số truyền
    String params = 'roundId=${request.roundId}';
    //currentPage
    if (request.currentPage != null) {
      params += '&currentPage=${request.currentPage}';
    }
    String url = Api.GetUrl(apiPath: '${Api.teamsInRound}/search?$params');
    String? token = GetIt.I.get<CurrentUser>().idToken;
    try {
      var response =
          await client.get(Uri.parse(url), headers: Api.GetHeader(token));
      if (response.statusCode == 200) {
        String isList = "[]";
        if (response.body.toString().compareTo(isList) == 0) {
          //List<dynamic> json = adapter.parseToList(response);
          //TH1
          return null;
        } else {
          //TH2
          Map<String, dynamic> json = adapter.parseToMap(response);
          return PagingResult.fromJson(json, TeamInRoundModel.fromJson);
        }
      }
    } catch (e) {
      Log.error(e.toString());
    }
    return null;
  }

  @override
  Future<ResultTeamInCompetitionModel?> GetTotalResultTeamInCompetition(int competitionId, int teamId) async {
    var client = http.Client();
    String url = Api.GetUrl(apiPath: "${Api.teams}/$teamId/competition/$competitionId");
    String token = GetIt.I.get<CurrentUser>().idToken;
    try{
      var response = await client.get(Uri.parse(url), headers: Api.GetHeader(token));
      if(response.statusCode == 200 && response.body.isNotEmpty){
        Map<String, dynamic> json = adapter.parseToMap(response);
        return ResultTeamInCompetitionModel.fromJson(json);
      }

    }catch(e){
      Log.error(e.toString());
    }

    return null;
  }
}
