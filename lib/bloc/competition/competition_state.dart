import 'package:equatable/equatable.dart';
import 'package:unicec_mobi/models/entities/competition/competition_detail_model.dart';
// import 'package:unicec_mobi/models/entities/competition/competition_model.dart';

import '../../models/entities/competition/competition_request_model.dart';
import '../../models/entities/competition/competition_show_model.dart';
import '../../models/enums/competition_scope_status.dart';

class CompetitionState extends Equatable {
  List<CompetitionShowModel> outStandingCompetitions;
  List<CompetitionShowModel> competitions;
  int? selectedCompetitionId;
  CompetitionDetailModel? competitionDetail;
  //CompetitionRequestModel requestModel;
  //Search
  String? searchName;
  CompetitionScopeStatus? scope;
  bool? isEvent;
  bool hasNext;
  int currentPage;
  bool isLoading;

  CompetitionState(
      {required this.competitions,
      required this.outStandingCompetitions,
      required this.searchName,
      required this.scope,
      required this.isEvent,
      this.competitionDetail,
      this.selectedCompetitionId,
      required this.hasNext,
      required this.currentPage,
      required this.isLoading});

  CompetitionState copyWith({
    required List<CompetitionShowModel> competitions,
    required List<CompetitionShowModel> outStandingCompetitions,
    CompetitionDetailModel? competitionDetail,
    //required CompetitionRequestModel requestModel,
    required String? searchName,
    required CompetitionScopeStatus? scope,
    required bool? isEvent,
    int? selectedCompetitionId,
    required bool newHasNext,
    required int newCurrentPage,
    required bool isLoading,
  }) {
    return CompetitionState(
        competitions: competitions,
        outStandingCompetitions: outStandingCompetitions,
        //requestModel: requestModel,
        searchName: searchName,
        scope: scope,
        isEvent: isEvent,
        competitionDetail: competitionDetail,
        selectedCompetitionId: selectedCompetitionId,
        hasNext: newHasNext,
        currentPage: newCurrentPage,
        isLoading: isLoading);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        competitions,
        outStandingCompetitions,
        //requestModel,
        searchName,
        scope,
        isEvent,
        competitionDetail,
        selectedCompetitionId,
        hasNext,
        currentPage,
        isLoading
      ];
}
