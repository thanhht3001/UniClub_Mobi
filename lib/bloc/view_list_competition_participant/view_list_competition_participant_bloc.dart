import '../../models/common/paging_result.dart';
import '../../models/entities/competition/competition_model.dart';
import '../../models/enums/competition_scope_status.dart';
import '../../services/competition_svc/i_competition_service.dart';
import '/bloc/view_list_competition_participant/view_list_competition_participant_state.dart';
import '../../utils/base_bloc.dart';
import 'view_list_competition_participant_event.dart';

class ViewListCompetitionParticipantBloc extends BaseBloc<
    ViewListCompetitionParticipantEvent, ViewListCompetitionParticipantState> {
  ICompetitionService service;
  ViewListCompetitionParticipantBloc({required this.service})
      : super(ViewListCompetitionParticipantState(
            competitions: [],
            searchName: null,
            scope: CompetitionScopeStatus.InterUniversity,
            isEvent: false,
            hasNext: false,
            currentPage: 1,
            isLoading: true)) {
    (on((event, emit) async {
      if (event is LoadListCompetitionParticipantEvent) {
        PagingResult<CompetitionModel>? result =
            await service.loadCompetitionParticipant(state.currentPage,
                state.scope, state.searchName, state.isEvent);
        if (result != null) {
          emit(state.copyWith(
            newCompetitions: result.items,
            newScope: state.scope,
            newSearchName: state.searchName,
            newIsEvent: state.isEvent,
            newHasNext: result.hasNext,
            newCurrentPage: result.currentPage,
            isLoading: false,
          ));
        } else {
          emit(state.copyWith(
              newCompetitions: state.competitions,
              newScope: state.scope,
              newSearchName: state.searchName,
              newIsEvent: state.isEvent,
              newHasNext: false,
              newCurrentPage: 1,
              isLoading: false));
        }
      }
      //Refesh Event
      if (event is RefreshEvent) {
        emit(state.copyWith(
            newCompetitions: [],
            newScope: state.scope,
            newSearchName: state.searchName,
            newIsEvent: state.isEvent,
            newHasNext: false,
            newCurrentPage: 1,
            isLoading: true));
      }
      //Increase Event
      if (event is IncrementalEvent) {
        int increase = state.currentPage + 1;
        emit(state.copyWith(
            newCompetitions: state.competitions,
            newScope: state.scope,
            newSearchName: state.searchName,
            newIsEvent: state.isEvent,
            newHasNext: state.hasNext,
            newCurrentPage: increase,
            isLoading: false));
      }
      //LoadMore
      if (event is LoadAddMoreEvent) {
        PagingResult<CompetitionModel>? result =
            await service.loadCompetitionParticipant(state.currentPage,
                state.scope, state.searchName, state.isEvent);
        //
        List<CompetitionModel> listContinute = result?.items ?? [];
        //
        if (listContinute.isNotEmpty) {
          for (CompetitionModel competition in listContinute) {
            state.competitions.add(competition);
          }
        }
        //
        emit(state.copyWith(
            newCompetitions: state.competitions,
            newScope: state.scope,
            newSearchName: state.searchName,
            newIsEvent: state.isEvent,
            newHasNext: result?.hasNext ??
                false, // result trả ra null thì đồng nghĩa với việc hasNext = false
            newCurrentPage: result?.currentPage ?? state.currentPage,
            isLoading: false));
      }
      //search event
      //dựa theo state search
      //mỗi lần search là current page = 1
      if (event is SearchEvent) {
        PagingResult<CompetitionModel>? result =
            await service.loadCompetitionParticipant(
                1, state.scope, state.searchName, state.isEvent);
        if (result != null) {
          emit(state.copyWith(
              newCompetitions: result.items,
              newScope: state.scope,
              newSearchName: state.searchName,
              newIsEvent: state.isEvent,
              newHasNext: result.hasNext,
              newCurrentPage: result.currentPage,
              isLoading: false));
        } //nếu kq ra null thì emit như v
        else {
          emit(state.copyWith(
              newCompetitions: [],
              newScope: state.scope,
              newSearchName: state.searchName,
              newIsEvent: state.isEvent,
              newHasNext: false,
              newCurrentPage: 1,
              isLoading: false));
        }
      }
      //
      if (event is ChangeSearchNameEvent) {
        emit(state.copyWith(
            newCompetitions: state.competitions,
            newSearchName: event.searchName, //change
            newScope: state.scope,
            newIsEvent: state.isEvent,
            newCurrentPage: state.currentPage,
            newHasNext: state.hasNext,
            isLoading: false));
      }
      //
      if (event is ChangeCompetitionScopeEvent) {
        //search luôn
        PagingResult<CompetitionModel>? result =
            await service.loadCompetitionParticipant(
                1, event.scope, state.searchName, state.isEvent);
        emit(state.copyWith(
            newCompetitions: result?.items ?? [],
            newSearchName: state.searchName,
            newScope: event.scope, // change
            newIsEvent: state.isEvent,
            newCurrentPage: result?.currentPage ?? 1,
            newHasNext: result?.hasNext ?? false,
            isLoading: false));
      }
      if (event is ChangeValueEvent) {
        //search luôn
        PagingResult<CompetitionModel>? result =
            await service.loadCompetitionParticipant(
                1, state.scope, state.searchName, event.isEvent);
        //nếu get kh ra thì trả ra như v
        emit(state.copyWith(
            newCompetitions: result?.items ?? [],
            newSearchName: state.searchName,
            newScope: state.scope,
            newIsEvent: event.isEvent, //change
            newCurrentPage: result?.currentPage ?? 1,
            newHasNext: result?.hasNext ?? false,
            isLoading: false));
      }
      //load lại trạng thái ban đầu mặc định
      if (event is ResetFilterEvent) {
        PagingResult<CompetitionModel>? result =
            await service.loadCompetitionParticipant(
                1, CompetitionScopeStatus.InterUniversity, null, false);
        if (result != null) {
          emit(state.copyWith(
              newCompetitions: result.items,
              newScope: CompetitionScopeStatus.InterUniversity,
              newSearchName: null,
              newIsEvent: false,
              newHasNext: result.hasNext,
              newCurrentPage: result.currentPage,
              isLoading: false));
        } //null cho về mặc định
        else {
          emit(state.copyWith(
              newCompetitions: [],
              newScope: CompetitionScopeStatus.InterUniversity,
              newSearchName: null,
              newIsEvent: false,
              newHasNext: false,
              newCurrentPage: 1,
              isLoading: false));
        }
      }
      if (event is LoadingEvent) {
        emit(state.copyWith(
            newCompetitions: state.competitions,
            newSearchName: state.searchName,
            newScope: state.scope,
            newIsEvent: state.isEvent,
            newCurrentPage: state.currentPage,
            newHasNext: state.hasNext,
            isLoading: true)); // change
      }
    }));
  }
}
