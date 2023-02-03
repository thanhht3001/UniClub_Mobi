import 'package:get_it/get_it.dart';
import 'package:unicec_mobi/models/common/current_user.dart';
import 'package:unicec_mobi/models/common/paging_request.dart';
import 'package:unicec_mobi/models/entities/notification/notification_model.dart';
import 'package:unicec_mobi/models/common/paging_result.dart';
import 'package:unicec_mobi/services/notification_svc/i_notification_service.dart';
import 'package:unicec_mobi/utils/adapter.dart';
import 'package:http/http.dart' as http;
import 'package:unicec_mobi/utils/api.dart';
import 'package:unicec_mobi/utils/log.dart';

class NotificationService implements INotificationService {
  Adapter adapter = Adapter();

  @override
  Future<PagingResult<NotificationModel>?> GetAllNotisByUser(
      int userId, PagingRequest? request) async {
    var client = http.Client();
    String params =
        "?currentPage=${request?.currentPage ?? 1}&pageSize=${request?.pageSize ?? 10}";
    String url =
        Api.GetUrl(apiPath: "${Api.notifications}/user/$userId$params");
    String token = GetIt.I.get<CurrentUser>().idToken;
    print('notification url: $url');
    try {
      var response =
          await client.get(Uri.parse(url), headers: Api.GetHeader(token));
      print('response: $response');
      String isList = "[]";
      if (response.statusCode == 200) {
        if (response.body.toString().compareTo(isList) == 0) {
          //TH1
          List<dynamic> list = adapter.parseToList(response);
          return null;
        } else {
          Map<String, dynamic> json = adapter.parseToMap(response);
          return PagingResult.fromJson(json, NotificationModel.fromJson);
        }
      }
    } catch (e) {
      Log.error(e.toString());
    }
  }

  @override
  Future<NotificationModel?> GetDetailNoti(int id) async {
    var client = http.Client();
    String url = Api.GetUrl(apiPath: "${Api.notifications}/$id");
    String token = GetIt.I.get<CurrentUser>().idToken;
    try {
      var response =
          await client.get(Uri.parse(url), headers: Api.GetHeader(token));
      if (response.statusCode == 200) {
        Map<String, dynamic> json = adapter.parseToMap(response);
        return NotificationModel.fromJson(json);
      }
    } catch (e) {
      Log.error(e.toString());
    }
  }
}
