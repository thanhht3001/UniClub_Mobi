import 'package:equatable/equatable.dart';

import '../../models/entities/competition/competition_detail_model.dart';
import '../../models/entities/competition/competition_model.dart';

class CompetitionDetailState extends Equatable {
  CompetitionDetailModel? competitionDetail;
  bool? isParticipant;
  bool? isAttendance;

  CompetitionDetailState(
      {this.competitionDetail, this.isParticipant, this.isAttendance});

  CompetitionDetailState copyWith(
      {CompetitionDetailModel? competitionDetail,
      bool? isParticipant,
      bool? isAttendance,
      List<CompetitionModel>? listCompetitionBelongToCurrentUser}) {
    return CompetitionDetailState(
        competitionDetail: competitionDetail,
        isParticipant: isParticipant,
        isAttendance: isAttendance);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [competitionDetail, isParticipant, isAttendance];
}
