import 'package:unicec_mobi/bloc/view_list_team_in_round/view_list_team_in_round_event.dart';
import 'package:unicec_mobi/bloc/view_list_team_in_round/view_list_team_in_round_state.dart';
import 'package:unicec_mobi/models/entities/competition_round/competition_round_model.dart';

import '../../models/common/paging_result.dart';
import '../../models/entities/team/team_in_round_model.dart';
import '../../models/entities/team/team_in_round_request_model.dart';
import '../../services/competition_round_svc/i_competition_round_service.dart';
import '../../services/team_svc/i_team_service.dart';
import '../../utils/base_bloc.dart';

class ViewListTeamInRoundBloc
    extends BaseBloc<ViewListTeamInRoundEvent, ViewListTeamInRoundState> {
  ITeamService service;
  ICompetitionRoundService roundService;

  ViewListTeamInRoundBloc({required this.service, required this.roundService})
      : super(ViewListTeamInRoundState(
            listTeamInRound: [],
            roundId: -1,
            hasNext: false,
            currentPage: 1,
            isLoading: true)) {
    on((event, emit) async {
      //InitEvent
      if (event is ViewListTeamInitEvent) {
        print('ViewListTeamInitEvent is running ... !!!');
        //------------Request
        TeamInRoundRequestModel request =
            TeamInRoundRequestModel(roundId: state.roundId);
        request.currentPage = state.currentPage;

        PagingResult<TeamInRoundModel>? result =
            await service.GetListTeamInRound(request);

        if (result != null) {
          emit(state.copyWith(
              newListTeamInRound: result.items,
              newRoundId: state.roundId,
              newHasNext: result.hasNext,
              newCurrentPage: result.currentPage,
              isLoading: false));
        }
      }
      //Receive Data
      if (event is ReceiveDataEvent) {
        print('ReceiveDataEvent is running ... !!!');
        //------------Request
        TeamInRoundRequestModel request =
            TeamInRoundRequestModel(roundId: event.roundId);
        request.currentPage = 1;

        PagingResult<TeamInRoundModel>? result =
            await service.GetListTeamInRound(request);

        if (result != null) {
          emit(state.copyWith(
              newListTeamInRound: result.items,
              newRoundId: event.roundId, //change
              newHasNext: result.hasNext,
              newCurrentPage: result.currentPage,
              isLoading: false));
        } else {
          emit(state.copyWith(
              newListTeamInRound: state.listTeamInRound,
              newRoundId: event.roundId, //change
              newHasNext: state.hasNext,
              newCurrentPage: state.currentPage,
              isLoading: false));
        }
      }
      //Refresh Event
      if (event is RefreshEvent) {
        emit(state.copyWith(
            newListTeamInRound: [],
            newRoundId: state.roundId,
            newHasNext: false,
            newCurrentPage: 1,
            isLoading: true));
      }
      //Increase Event
      if (event is IncrementalEvent) {
        int increase = state.currentPage + 1;
        emit(state.copyWith(
            newListTeamInRound: state.listTeamInRound,
            newRoundId: state.roundId,
            newHasNext: state.hasNext,
            newCurrentPage: increase,
            isLoading: false));
      }
      //LoadMore
      if (event is LoadAddMoreEvent) {
        //------------Request
        TeamInRoundRequestModel request =
            TeamInRoundRequestModel(roundId: state.roundId);
        request.currentPage = state.currentPage;

        PagingResult<TeamInRoundModel>? result =
            await service.GetListTeamInRound(request);
        //
        List<TeamInRoundModel> listContinute = result?.items ?? [];
        //
        if (listContinute.isNotEmpty) {
          for (TeamInRoundModel team in listContinute) {
            state.listTeamInRound.add(team);
          }
        }
        //
        emit(state.copyWith(
            newListTeamInRound: state.listTeamInRound,
            newRoundId: state.roundId,
            newHasNext: result?.hasNext ??
                false, // result trả ra null thì đồng nghĩa với việc hasNext = false
            newCurrentPage: result?.currentPage ?? state.currentPage,
            isLoading: false));
      }
      if (event is LoadingEvent) {
        emit(state.copyWith(
            newListTeamInRound: state.listTeamInRound,
            newRoundId: state.roundId,
            newHasNext: state.hasNext,
            newCurrentPage: state.currentPage,
            isLoading: true // change
            ));
      }

      if (event is LoadInfoRoundEvent) {
        CompetitionRoundModel? round =
            await roundService.getById(event.roundId);
        emit(state.copyWith(
            newListTeamInRound: state.listTeamInRound,
            newRoundId: state.roundId,
            newHasNext: state.hasNext,
            newCurrentPage: state.currentPage,
            isLoading: state.isLoading));

        listener.add(NavigateToTeamDetailEvent(competitionId: round?.competitionId ?? 0, teamId: event.teamId ?? 0));       
      }
    });
  }
}
