import 'dart:convert';
import 'package:intl/intl.dart';
import 'log.dart';

class Utils {
  static Map<String, dynamic> fromJWT(String? token) {
    Map<String, dynamic> payloadMap = {};
    try {
      final parts = token?.split('.');
      final payload = parts![1];
      var normalized = base64Url.normalize(payload);
      var resp = utf8.decode(base64Url.decode(normalized));
      payloadMap = json.decode(resp);
    } catch (e) {
      Log.error("$e");
    }
    return payloadMap;
  }

  static List<T> modelBuilder<M, T>(
          List<M> models, T Function(int index, M model) builder) =>
      models
          .asMap()
          .map<int, T>((index, model) => MapEntry(index, builder(index, model)))
          .values
          .toList();

  static String convertDateTime(DateTime dateTime){
    final DateFormat format = DateFormat("dd-MM-yyyy HH:mm:ss");
    return format.format(dateTime);
  }

  static String formatDateTime(String dateTime){
    return dateTime.replaceAll("T", " ");
  }
}
