import 'dart:convert';

import 'package:http/http.dart';
import 'package:unicec_mobi/utils/log.dart';

class Adapter {
  void logResponse(Response response){
    Log.debug("----------start----------");
    Log.debug("response: ${response.toString()}");
    Log.debug("status code: ${response.statusCode}");
    Log.debug("header: ${response.headers}");
    Log.debug("body: ${response.body}");
    Log.debug("----------end----------");
  }

  String parseToString(Response response) {
    logResponse(response);
    
    return response.body;
  }

  List<dynamic> parseToList(Response response) {
    logResponse(response);

    return jsonDecode(response.body) as List<dynamic>;
  }

  Map<String, dynamic> parseToMap(Response response) {
    logResponse(response);

    return jsonDecode(response.body) as Map<String, dynamic>;
  }
}
