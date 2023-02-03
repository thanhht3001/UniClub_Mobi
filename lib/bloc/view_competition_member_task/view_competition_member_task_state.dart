import 'package:equatable/equatable.dart';

import '../../models/entities/competition/competition_model.dart';

class ViewCompetitionMemberTaskState extends Equatable {
  List<CompetitionModel> listCompetition;
  String? searchName;
  bool isEvent;
  bool hasNext;
  int currentPage;
  bool isLoading;

  ViewCompetitionMemberTaskState(
      {required this.listCompetition,
      required this.searchName,
      required this.isEvent,
      required this.hasNext,
      required this.currentPage,
      required this.isLoading});

  ViewCompetitionMemberTaskState copyWith(
      {required List<CompetitionModel> listCompetition,
      required String? searchName,
      required bool isEvent,
      required bool hasNext,
      required int currentPage,
      required bool isLoading}) {
    return ViewCompetitionMemberTaskState(
        listCompetition: listCompetition,
        searchName: searchName,
        isEvent: isEvent,
        hasNext: hasNext,
        currentPage: currentPage,
        isLoading: isLoading);
  }

  @override
  List<Object?> get props =>
      [listCompetition, searchName, isEvent, hasNext, currentPage, isLoading];
}
