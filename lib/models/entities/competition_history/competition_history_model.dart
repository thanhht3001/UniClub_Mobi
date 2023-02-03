import 'package:unicec_mobi/models/enums/competition_status.dart';

class CompetitionHistoryModel{
  int id;
  int competitionId;
  int? changerId;
  String? changerName;
  DateTime changeDate;
  String? description;
  CompetitionStatus status;

  CompetitionHistoryModel({
    required this.id,
    required this.competitionId,
    this.changerId,
    this.changerName,
    required this.changeDate,
    this.description,
    required this.status
  });

  factory CompetitionHistoryModel.fromJson(Map<String, dynamic> json){
    int id = json['id'] ?? 0;
    int competitionId = json['competition_id'] ?? 0;
    int? changerId = json['changer_id'];
    String? changerName = json['changer_name'];
    DateTime changeDate = DateTime.parse(json['change_date']);
    String? description = json['description'];
    CompetitionStatus status = CompetitionStatus.values[json['status']];

    return CompetitionHistoryModel(
      id: id, 
      competitionId: competitionId,
      changerId: changerId,
      changerName: changerName, 
      changeDate: changeDate,
      description: description, 
      status: status
    );
  }
}