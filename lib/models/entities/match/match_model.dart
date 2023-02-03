import 'package:intl/intl.dart';
import 'package:unicec_mobi/models/enums/match_status.dart';

class MatchModel {
  int id;
  int roundId;
  String roundName;
  bool? isLoseMatch;
  int roundTypeId;
  String roundTypeName;
  String address;
  String title;
  String description;
  DateTime createTime;
  DateTime startTime;
  DateTime endTime;
  int numberOfTeam;
  MatchStatus status;

  MatchModel(
      {required this.id,
      required this.roundId,
      required this.roundName,
      required this.roundTypeId,
      required this.roundTypeName,
      required this.isLoseMatch,
      required this.address,
      required this.title,
      required this.description,
      required this.createTime,
      required this.startTime,
      required this.endTime,
      required this.numberOfTeam,
      required this.status});

  factory MatchModel.fromJson(Map<String, dynamic> json) {
    int id = json['id'] ?? 0;
    int roundId = json['round_id'] ?? 0;
    String roundName = json['round_name'] ?? "";
    bool? isLoseMatch = json['is_lose_match'] ?? null;
    int roundTypeId = json['round_type_id'] ?? 0;
    String roundTypeName = json['round_type_name'] ?? "";
    String address = json['address'] ?? "";
    String title = json['title'] ?? "";
    String description = json['description'] ?? "";
    String time =
        json['create_time'].toString().replaceAll("T", " ").replaceAll("Z", "");
    DateTime createTime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(time);
    time =
        json['start_time'].toString().replaceAll("T", " ").replaceAll("Z", "");
    DateTime startTime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(time);
    time = json['end_time'].toString().replaceAll("T", " ").replaceAll("Z", "");
    DateTime endTime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(time);
    int numberOfTeam = json['number_of_team'] ?? 0;
    MatchStatus status = MatchStatus.values[json['status']];

    return MatchModel(
        id: id,
        roundId: roundId,
        roundName: roundName,
        roundTypeId: roundTypeId,
        roundTypeName: roundTypeName,
        isLoseMatch: isLoseMatch,
        address: address,
        title: title,
        description: description,
        createTime: createTime,
        startTime: startTime,
        endTime: endTime,
        numberOfTeam: numberOfTeam,
        status: status);
  }
}
