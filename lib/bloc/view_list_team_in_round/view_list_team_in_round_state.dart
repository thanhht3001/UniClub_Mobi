import 'package:equatable/equatable.dart';

import '../../models/entities/team/team_in_round_model.dart';

class ViewListTeamInRoundState extends Equatable {
  List<TeamInRoundModel> listTeamInRound;
  int roundId;
  bool hasNext;
  int currentPage;
  bool isLoading;

  ViewListTeamInRoundState(
      {required this.listTeamInRound,
      required this.roundId,
      required this.currentPage,
      required this.hasNext,
      required this.isLoading});

  ViewListTeamInRoundState copyWith({
    required List<TeamInRoundModel> newListTeamInRound,
    required int newRoundId,
    required bool newHasNext,
    required int newCurrentPage,
    required bool isLoading,
  }) {
    return ViewListTeamInRoundState(
        listTeamInRound: newListTeamInRound,
        roundId: newRoundId,
        hasNext: newHasNext,
        currentPage: newCurrentPage,
        isLoading: isLoading);
  }

  @override
  List<Object?> get props =>
      [listTeamInRound, roundId, hasNext, currentPage, isLoading];
}
