import 'package:unicec_mobi/bloc/view_list_team_student/view_list_team_student_event.dart';
import 'package:unicec_mobi/bloc/view_list_team_student/view_list_team_student_state.dart';
import '../../models/common/paging_result.dart';
import '../../models/entities/team/team_model.dart';
import '../../models/entities/team/team_request_model.dart';
import '../../services/i_services.dart';
import '../../utils/base_bloc.dart';

class ViewListTeamStudentBloc
    extends BaseBloc<ViewListTeamStudentEvent, ViewListTeamStudentState> {
  ITeamService service;

  ViewListTeamStudentBloc({required this.service})
      : super(ViewListTeamStudentState(
            listTeam: [],
            competitionId: -1,
            hasNext: false,
            currentPage: 1,
            isLoading: true)) {
    on((event, emit) async {
      //InitEvent
      if (event is ViewListTeamInitEvent) {
        //------------Request
        TeamRequestModel request =
            TeamRequestModel(competitionId: state.competitionId);
        request.currentPage = state.currentPage;

        PagingResult<TeamModel>? result = await service.GetListTeam(request);

        if (result != null) {
          emit(state.copyWith(
              newListTeam: result.items,
              newCompetitionId: state.competitionId,
              newHasNext: result.hasNext,
              newCurrentPage: result.currentPage,
              isLoading: false));
        }
      }
      //Recieve Data
      if (event is ReceiveDataEvent) {
        //------------Request
        TeamRequestModel request =
            TeamRequestModel(competitionId: event.competitionId);
        request.currentPage = 1;

        PagingResult<TeamModel>? result = await service.GetListTeam(request);

        if (result != null) {
          emit(state.copyWith(
              newListTeam: result.items,
              newCompetitionId: event.competitionId, //change
              newHasNext: result.hasNext,
              newCurrentPage: result.currentPage,
              isLoading: false));
        } else {
          emit(state.copyWith(
              newListTeam: state.listTeam,
              newCompetitionId: event.competitionId, //change
              newHasNext: state.hasNext,
              newCurrentPage: state.currentPage,
              isLoading: false));
        }
      }
      //Refesh Event
      if (event is RefreshEvent) {
        emit(state.copyWith(
            newListTeam: [],
            newCompetitionId: state.competitionId,
            newHasNext: false,
            newCurrentPage: 1,
            isLoading: true));
      }
      //Increase Event
      if (event is IncrementalEvent) {
        int increase = state.currentPage + 1;
        emit(state.copyWith(
            newListTeam: state.listTeam,
            newCompetitionId: state.competitionId,
            newHasNext: state.hasNext,
            newCurrentPage: increase,
            isLoading: false));
      }
      //LoadMore
      if (event is LoadAddMoreEvent) {
        //------------Request
        TeamRequestModel request =
            TeamRequestModel(competitionId: state.competitionId);
        request.currentPage = state.currentPage;

        PagingResult<TeamModel>? result = await service.GetListTeam(request);
        //
        List<TeamModel> listContinute = result?.items ?? [];
        //
        if (listContinute.isNotEmpty) {
          for (TeamModel team in listContinute) {
            state.listTeam.add(team);
          }
        }
        //
        emit(state.copyWith(
            newListTeam: state.listTeam,
            newCompetitionId: state.competitionId,
            newHasNext: result?.hasNext ??
                false, // result trả ra null thì đồng nghĩa với việc hasNext = false
            newCurrentPage: result?.currentPage ?? state.currentPage,
            isLoading: false));
      }
      if (event is LoadingEvent) {
        emit(state.copyWith(
            newListTeam: state.listTeam,
            newCompetitionId: state.competitionId,
            newHasNext: state.hasNext,
            newCurrentPage: state.currentPage,
            isLoading: true // change
            ));
      }
    });
  }
}
