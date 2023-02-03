import 'package:equatable/equatable.dart';
import '../../models/entities/team/team_model.dart';
import '../../models/enums/team_status.dart';

class ViewListTeamParticipantState extends Equatable {
  List<TeamModel> listTeam;
  int competitionId;
  bool hasNext;
  int currentPage;
  String valueInvitedCode;
  //search
  String? searchName;
  TeamStatus? status;
  bool isLoading;
  //
  int minNumber;
  int maxNumber;

  ViewListTeamParticipantState({
    required this.listTeam,
    required this.competitionId,
    required this.currentPage,
    required this.hasNext,
    required this.valueInvitedCode,
    required this.searchName,
    required this.status,
    required this.isLoading,
    required this.minNumber,
    required this.maxNumber,
  });

  ViewListTeamParticipantState copyWith({
    required List<TeamModel> newListTeam,
    required int newCompetitionId,
    required bool newHasNext,
    required int newCurrentPage,
    required String valueInvitedCode,
    required String? newSearchName,
    required TeamStatus? newStatus,
    required bool isLoading,
    int? minNumber,
    int? maxNumber,
  }) {
    return ViewListTeamParticipantState(
      listTeam: newListTeam,
      competitionId: newCompetitionId,
      hasNext: newHasNext,
      currentPage: newCurrentPage,
      valueInvitedCode: valueInvitedCode,
      searchName: newSearchName,
      status: newStatus,
      isLoading: isLoading,
      minNumber: minNumber ?? this.minNumber,
      maxNumber: maxNumber ?? this.maxNumber,
    );
  }

  @override
  List<Object?> get props => [
        listTeam,
        competitionId,
        hasNext,
        currentPage,
        valueInvitedCode,
        searchName,
        status,
        isLoading,
        minNumber,
        maxNumber,
      ];
}
