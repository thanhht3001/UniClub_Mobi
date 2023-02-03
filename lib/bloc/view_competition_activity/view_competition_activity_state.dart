import 'package:equatable/equatable.dart';

import '../../models/entities/competition_activity/competition_activity_model.dart';
import '../../models/enums/competition_activity_status.dart';
import '../../models/enums/priority_status.dart';

class ViewCompetitionActivityState extends Equatable {
  List<CompetitionActivityModel> listCompetitionActivity;
  int competitionId;
  //search
  String? searchName;
  PriorityStatus choosePriorityStatus;
  List<PriorityStatus> loadPriorityStatus;
  CompetitionActivityStatus chooseStatus;
  List<CompetitionActivityStatus> loadListStatuses;
  bool hasNext;
  int currentPage;
  bool isLoading;

  ViewCompetitionActivityState(
      {required this.listCompetitionActivity,
      required this.competitionId,
      required this.searchName,
      required this.choosePriorityStatus,
      required this.loadPriorityStatus,
      required this.chooseStatus,
      required this.loadListStatuses,
      required this.hasNext,
      required this.currentPage,
      required this.isLoading});

  ViewCompetitionActivityState copyWith(
      {required List<CompetitionActivityModel> newListCompetitionActivity,
      required int newCompetitionId,
      required String? searchName,
      required PriorityStatus choosePriorityStatus,
      required List<PriorityStatus> loadPriorityStatus,
      required CompetitionActivityStatus chooseStatus,
      required List<CompetitionActivityStatus> loadListStatuses,
      required bool newHasNext,
      required int newCurrentPage,
      required bool isLoading}) {
    return ViewCompetitionActivityState(
        listCompetitionActivity: newListCompetitionActivity,
        competitionId: newCompetitionId,
        searchName: searchName,
        choosePriorityStatus: choosePriorityStatus,
        loadPriorityStatus: loadPriorityStatus,
        chooseStatus: chooseStatus,
        loadListStatuses: loadListStatuses,
        hasNext: newHasNext,
        currentPage: newCurrentPage,
        isLoading: isLoading);
  }

  @override
  List<Object?> get props => [
        listCompetitionActivity,
        competitionId,
        searchName,
        choosePriorityStatus,
        loadPriorityStatus,
        chooseStatus,
        loadListStatuses,
        hasNext,
        currentPage,
        isLoading
      ];
}
