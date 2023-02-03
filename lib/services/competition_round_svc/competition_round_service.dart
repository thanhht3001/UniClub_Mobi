import 'package:get_it/get_it.dart';
import 'package:unicec_mobi/models/common/current_user.dart';
import 'package:unicec_mobi/models/entities/competition_round/competition_round_model.dart';
import 'package:unicec_mobi/models/entities/team/team_in_round_model.dart';
import 'package:unicec_mobi/models/entities/team/team_model.dart';
import 'package:http/http.dart' as http;
import 'package:unicec_mobi/utils/log.dart';

import '../../models/common/paging_result.dart';
import '../../models/entities/team/team_in_competition_model.dart';
import '../../utils/adapter.dart';
import '../../utils/api.dart';
import 'i_competition_round_service.dart';

class CompetitionRoundService implements ICompetitionRoundService {
  Adapter adapter = Adapter();

  @override
  Future<CompetitionRoundModel?> getById(int id) async {
    var client = http.Client();
    String url = Api.GetUrl(apiPath: '${Api.competitionRounds}/$id');
    String token = GetIt.I.get<CurrentUser>().idToken;
    try {
      var response =
          await client.get(Uri.parse(url), headers: Api.GetHeader(token));
      if (response.statusCode == 200 && response.body.isNotEmpty) {
        Map<String, dynamic> json = adapter.parseToMap(response);
        return CompetitionRoundModel.fromJson(json);
      }
    } catch (error) {
      Log.error(error.toString());
    }

    return null;
  }

  @override
  Future<PagingResult<CompetitionRoundModel>?> loadRoundsByCompetition(
      int competitionId) async {
    var client = http.Client();
    String params = '?competitionId=$competitionId';
    String url = Api.GetUrl(apiPath: '${Api.competitionRounds}/search$params');
    String token = GetIt.I.get<CurrentUser>().idToken;
    try {
      var response =
          await client.get(Uri.parse(url), headers: Api.GetHeader(token));
      if (response.statusCode == 200 && response.body.isNotEmpty) {
        String isList = "[]";
        if (response.body.toString().compareTo(isList) == 0) {
          List<dynamic> json = adapter.parseToList(response);
          //TH1
          return null;
        } else {
          Map<String, dynamic> json = adapter.parseToMap(response);
          return PagingResult.fromJson(json, CompetitionRoundModel.fromJson);
        }
      }
    } catch (error) {
      Log.error(error.toString());
    }

    return null;
  }

  @override
  Future<PagingResult<TeamInRoundModel>?> loadRoundResultById(
      int roundId) async {
    var client = http.Client();
    String params = '?roundId=$roundId';
    String url = Api.GetUrl(apiPath: '${Api.teamsInRound}/search$params');
    String token = GetIt.I.get<CurrentUser>().idToken;
    try {
      var response =
          await client.get(Uri.parse(url), headers: Api.GetHeader(token));
      if (response.statusCode == 200 && response.body.isNotEmpty) {
        Map<String, dynamic> json = adapter.parseToMap(response);
        return PagingResult.fromJson(json, TeamInRoundModel.fromJson);
      }
    } catch (error) {
      Log.error(error.toString());
    }

    return null;
  }

  @override
  Future<List<ResultTeamsInCompetitionModel>?> loadTeamResultByCompetition(
      int competitionId) async {
    var client = http.Client();
    String params =
        'competitionId=$competitionId';
    String url =
        Api.GetUrl(apiPath: '${Api.teams}/final-result-competition?$params');
    String token = GetIt.I.get<CurrentUser>().idToken;
    try {
      var response =
          await client.get(Uri.parse(url), headers: Api.GetHeader(token));
      if (response.statusCode == 200 && response.body.isNotEmpty) {
        List<dynamic> json = adapter.parseToList(response);
        List<ResultTeamsInCompetitionModel> teams = [];
        for (var element in json) {
          ResultTeamsInCompetitionModel team = ResultTeamsInCompetitionModel.fromJson(element);
          teams.add(team);
        }
        return teams;
      }
    } catch (error) {
      Log.error(error.toString());
    }

    return null;
  }
}
