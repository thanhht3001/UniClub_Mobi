import 'package:get_it/get_it.dart';
import 'package:unicec_mobi/models/common/current_user.dart';
import 'package:unicec_mobi/models/entities/match/match_model.dart';
import 'package:unicec_mobi/models/common/paging_result.dart';
import 'package:unicec_mobi/models/entities/match/teams_in_match_model.dart';
import 'package:unicec_mobi/services/match_svc/i_match_service.dart';
import 'package:http/http.dart' as http;
import 'package:unicec_mobi/utils/adapter.dart';
import 'package:unicec_mobi/utils/api.dart';
import 'package:unicec_mobi/utils/log.dart';

class MatchService implements IMatchService {
  Adapter adapter = Adapter();

  @override
  Future<PagingResult<MatchModel>?> getMatchesByRound(int roundId) async {
    var client = http.Client();
    String url = Api.GetUrl(apiPath: "${Api.matches}/search?roundId=$roundId");
    String token = GetIt.I.get<CurrentUser>().idToken;

    try {
      var response =
          await client.get(Uri.parse(url), headers: Api.GetHeader(token));
      if (response.statusCode == 200) {
        String isList = "[]";
        if (response.body.toString().compareTo(isList) == 0) {
          return null;
        }
        //
        Map<String, dynamic> json = adapter.parseToMap(response);
        return PagingResult.fromJson(json, MatchModel.fromJson);
      }
    } catch (e) {
      Log.error(e.toString());
    }

    return null;
  }

  @override
  Future<List<TeamsInMatchModel>?> getTeamsInMatch(int matchId) async {
    var client = http.Client();
    String url = Api.GetUrl(apiPath: Api.teamInMatches);
    url += "/search?matchId=${matchId}";
    String token = GetIt.I.get<CurrentUser>().idToken;
    try {
      var response =
          await client.get(Uri.parse(url), headers: Api.GetHeader(token));
      if (response.statusCode == 200) {
        String isList = "[]";
        if (response.body.toString().compareTo(isList) == 0) {
          return null;
        }
        //
        Map<String, dynamic> json = adapter.parseToMap(response);
        PagingResult<TeamsInMatchModel> result =
            PagingResult.fromJson(json, TeamsInMatchModel.fromJson);
        //
        List<TeamsInMatchModel> listResult = result.items;
        //gọi liên tục theo total page
        if (result.totalPages > 1) {
          int totalCall = result.totalPages;
          for (int i = 2; i <= result.totalPages; i++) {
            String url = Api.GetUrl(apiPath: Api.teamInMatches);
            url += "/search?matchId=${matchId}&currentPage=${i}";
            if (response.statusCode == 200) {
              String isList = "[]";
              if (response.body.toString().compareTo(isList) == 0) {
                //not thing
              } else {
                Map<String, dynamic> json = adapter.parseToMap(response);
                PagingResult<TeamsInMatchModel> result =
                    PagingResult.fromJson(json, TeamsInMatchModel.fromJson);
                //
                for (TeamsInMatchModel tim in result.items) {
                  listResult.add(tim);
                }
              }
            }
          }
        }
        return listResult;
      }
    } catch (e) {
      Log.error(e.toString());
    }
    return null;
  }
  
  @override
  Future<MatchModel?> getMatchById(int matchId) async {
    var client = http.Client();
    String url = Api.GetUrl(apiPath: "${Api.matches}/$matchId");
    String token = GetIt.I.get<CurrentUser>().idToken;

    try {
      var response =
          await client.get(Uri.parse(url), headers: Api.GetHeader(token));
      if (response.statusCode == 200 && response.body.isNotEmpty) {
        Map<String, dynamic> json = adapter.parseToMap(response);
        return MatchModel.fromJson(json);
      }
    } catch (e) {
      Log.error(e.toString());
    }

    return null;
  }
}
