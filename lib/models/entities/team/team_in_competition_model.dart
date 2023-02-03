import 'package:unicec_mobi/models/enums/team_in_match_status.dart';

import '../participant/participant_in_team_model.dart';

class ResultTeamsInCompetitionModel {
  int teamId;
  int competitionId;
  String teamName;
  String description;
  bool status;
  int numberOfMemberInTeam;
  int totalPoint;
  int rank;

  ResultTeamsInCompetitionModel(
      {required this.teamId,
      required this.competitionId,
      required this.teamName,
      required this.description,
      required this.status,
      required this.numberOfMemberInTeam,
      required this.totalPoint,
      required this.rank});

  factory ResultTeamsInCompetitionModel.fromJson(Map<String, dynamic> json) {
    int teamId = json['team_id'] ?? 0;
    int competitionId = json['competition_id'] ?? 0;
    String teamName = json['name'] ?? '';
    String description = json['description'] ?? '';
    bool status = json['status'] ?? false;
    int numberOfMemberInTeam = json['number_of_member_in_team'] ?? 0;
    int totalPoint = json['total_point'] ?? 0;
    int rank = json['rank'] ?? 0;

    return ResultTeamsInCompetitionModel(
        teamId: teamId,
        competitionId: competitionId,
        teamName: teamName,
        description: description,
        status: status,
        numberOfMemberInTeam: numberOfMemberInTeam,
        totalPoint: totalPoint,
        rank: rank);
  }
}

class ResultTeamInCompetitionModel {
  int competitionId;
  String competitionName;
  int teamId;
  String teamName;
  List<ParticipantInTeamModel> membersInTeam;
  List<ResultTeamInRoundsModel> teamInRounds;

  ResultTeamInCompetitionModel(
      {required this.competitionId,
      required this.competitionName,
      required this.teamId,
      required this.teamName,
      required this.membersInTeam,
      required this.teamInRounds});

  factory ResultTeamInCompetitionModel.fromJson(Map<String, dynamic> json) {
    int competitionId = json['competition_id'] ?? 0;
    String competitionName = json['competition_name'] ?? "";
    int teamId = json['team_id'] ?? 0;
    String teamName = json['team_name'] ?? "";
    List<ParticipantInTeamModel> membersInTeam = [];
    json['members_in_team']?.forEach((v) {
      membersInTeam.add(ParticipantInTeamModel.fromJson(v));
    });
    List<ResultTeamInRoundsModel> teamInRounds = [];
    json['team_in_rounds']?.forEach((v) {
      teamInRounds.add(ResultTeamInRoundsModel.fromJson(v));
    });

    return ResultTeamInCompetitionModel(
        competitionId: competitionId,
        competitionName: competitionName,
        teamId: teamId,
        teamName: teamName,
        membersInTeam: membersInTeam,
        teamInRounds: teamInRounds);
  }
}

class ResultTeamInRoundsModel {
  int roundId;
  String roundName;
  int roundTypeId;
  String roundTypeName;
  int scores;
  bool status;
  int rank;
  List<ResultTeamInMatchesModel> teamInMatches;

  ResultTeamInRoundsModel(
      {required this.roundId,
      required this.roundName,
      required this.roundTypeId,
      required this.roundTypeName,
      required this.scores,
      required this.status,
      required this.rank,
      required this.teamInMatches});

  factory ResultTeamInRoundsModel.fromJson(Map<String, dynamic> json) {
    int roundId = json['round_id'] ?? 0;
    String roundName = json['round_name'] ?? "";
    int roundTypeId = json['round_type_id'] ?? 0;
    String roundTypeName = json['round_type_name'] ?? "";
    int scores = json['scores'] ?? 0;
    bool status = json['status'] ?? true;
    int rank = json['rank'] ?? 0;
    List<ResultTeamInMatchesModel> teamInMatches = [];
    json['team_in_matches']?.forEach((v) {
      teamInMatches.add(ResultTeamInMatchesModel.fromJson(v));
    });

    return ResultTeamInRoundsModel(
        roundId: roundId,
        roundName: roundName,
        roundTypeId: roundTypeId,
        roundTypeName: roundTypeName,
        scores: scores,
        status: status,
        rank: rank,
        teamInMatches: teamInMatches);
  }
}

class ResultTeamInMatchesModel {
  int matchId;
  String matchTitle;
  int scores;
  TeamInMatchStatus status;
  String description;

  ResultTeamInMatchesModel(
      {required this.matchId,
      required this.matchTitle,
      required this.scores,
      required this.status,
      required this.description});

  factory ResultTeamInMatchesModel.fromJson(Map<String, dynamic> json) {
    int matchId = json['match_id'] ?? 0;
    String matchTitle = json['match_title'] ?? "";
    int scores = json['scores'] ?? 0;
    TeamInMatchStatus status = TeamInMatchStatus.values[json['status']];
    String description = json['description'] ?? "";

    return ResultTeamInMatchesModel(
        matchId: matchId,
        matchTitle: matchTitle,
        scores: scores,
        status: status,
        description: description);
  }
}
