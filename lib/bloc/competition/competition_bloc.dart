import 'package:get_it/get_it.dart';

import '../../models/common/current_user.dart';
import '../../models/enums/competition_scope_status.dart';
import '/bloc/competition/competition_event.dart';
import '/bloc/competition/competition_state.dart';
import '/models/common/paging_result.dart';
import '/models/entities/competition/competition_detail_model.dart';
import '/models/entities/competition/competition_request_model.dart';
import '/models/enums/competition_status.dart';
import '/services/i_services.dart';
import '/utils/base_bloc.dart';
import '../../models/common/paging_result.dart';
import '../../models/entities/competition/competition_show_model.dart';

class CompetitionBloc extends BaseBloc<CompetitionEvent, CompetitionState> {
  final ICompetitionService service;

  CompetitionBloc({required this.service})
      : super(
          CompetitionState(
              competitions: <CompetitionShowModel>[],
              outStandingCompetitions: <CompetitionShowModel>[],
              scope: CompetitionScopeStatus.InterUniversity,
              searchName: null,
              isEvent: false,
              hasNext: false,
              currentPage: 1,
              isLoading: true),
        ) {
    on((event, emit) async {
      if (event is LoadOutStandingCompetitionEvent) {
        // trả ra viewMost ăn theo State Scope
        print('LoadOutStandingCompetitionEvent is running ...');
        //------------------------Request
        List<int> statuses = [];
        statuses.add(CompetitionStatus.Publish.index);
        statuses.add(CompetitionStatus.Register.index);

        CompetitionRequestModel request = CompetitionRequestModel(
            universityId:
                (state.scope == CompetitionScopeStatus.InterUniversity)
                    ? null
                    : GetIt.instance<CurrentUser>().universityId,
            viewMost: true,
            statuses: statuses,
            scope: state.scope,
            event: state.isEvent); // add more params if you want

        PagingResult<CompetitionShowModel>? result =
            await service.loadCompetition(request);

        emit(state.copyWith(
            outStandingCompetitions: result?.items ?? [], // change
            competitions: state.competitions,
            scope: state.scope,
            isEvent: state.isEvent,
            searchName: state.searchName,
            newHasNext: state.hasNext,
            newCurrentPage: state.currentPage,
            isLoading: false));
      }

      if (event is LoadCompetitionEvent) {
        print('LoadCompetitionEvent is running ...');

        List<int> statuses = [];
        statuses.add(CompetitionStatus.Publish.index);
        statuses.add(CompetitionStatus.Register.index);

        CompetitionRequestModel request = CompetitionRequestModel(
            universityId:
                (state.scope == CompetitionScopeStatus.InterUniversity)
                    ? null
                    : GetIt.instance<CurrentUser>().universityId,
            scope: state.scope,
            name: state.searchName,
            statuses: statuses,
            event: state.isEvent);
        // add more params if you want

        PagingResult<CompetitionShowModel>? result =
            await service.showCompetition(request, state.currentPage);
        if (result != null) {
          emit(state.copyWith(
              outStandingCompetitions: state.outStandingCompetitions,
              competitions: result.items,
              scope: state.scope,
              searchName: state.searchName,
              isEvent: state.isEvent,
              newHasNext: result.hasNext,
              newCurrentPage: result.currentPage,
              isLoading: false));
        }
      }

      if (event is SelectACompetitionEvent) {
        print('SelectACompetitionEvent is running ...');
        //isLoading = true;
        CompetitionDetailModel? competitionDetail =
            await service.loadDetailById(event.competitionId);
        emit(state.copyWith(
            outStandingCompetitions: state.outStandingCompetitions,
            competitions: state.competitions,
            competitionDetail: competitionDetail,
            scope: state.scope,
            searchName: state.searchName,
            isEvent: state.isEvent,
            newHasNext: state.hasNext,
            newCurrentPage: state.currentPage,
            //emit thêm competitionId Selected
            selectedCompetitionId: event.competitionId,
            isLoading: false));
      }

      //--------------------------------TA
      //emit state thay đổi của request
      if (event is ChangeSearchNameEvent) {
        emit(state.copyWith(
            outStandingCompetitions: state.outStandingCompetitions,
            competitions: state.competitions,
            scope: state.scope,
            searchName: event.searchName, // change
            isEvent: state.isEvent,
            newHasNext: state.hasNext,
            newCurrentPage: state.currentPage,
            isLoading: false));
      }
      //change scope
      if (event is ChangeCompetitionScopeEvent) {
        //_isLoading = true;

        List<int> statuses = [];
        statuses.add(CompetitionStatus.Publish.index);
        statuses.add(CompetitionStatus.Register.index);

        CompetitionRequestModel request = CompetitionRequestModel(
            universityId:
                (state.scope == CompetitionScopeStatus.InterUniversity)
                    ? null
                    : GetIt.instance<CurrentUser>().universityId,
            scope: event.scope,
            name: state.searchName,
            statuses: statuses,
            event: state.isEvent);
        // add more params if you want

        PagingResult<CompetitionShowModel>? result =
            await service.showCompetition(request, 1);

        emit(state.copyWith(
            competitions: result?.items ?? [],
            outStandingCompetitions: [], //state.outStandingCompetitions,
            scope: event.scope, // change
            searchName: state.searchName,
            isEvent: state.isEvent,
            newHasNext: result?.hasNext ?? false,
            newCurrentPage: result?.currentPage ?? 1,
            isLoading: false));

        // muốn search ăn theo filter luôn
        listener.add(ListenLoadOutStandingEvent());

        //_isLoading = false;
      }
      //change event
      if (event is ChangeValueEvent) {
        //isLoading = true;

        List<int> statuses = [];
        statuses.add(CompetitionStatus.Publish.index);
        statuses.add(CompetitionStatus.Register.index);

        CompetitionRequestModel request = CompetitionRequestModel(
            universityId:
                (state.scope == CompetitionScopeStatus.InterUniversity)
                    ? null
                    : GetIt.instance<CurrentUser>().universityId,
            scope: state.scope,
            name: state.searchName,
            statuses: statuses,
            event: event.isEvent);
        // add more params if you want

        PagingResult<CompetitionShowModel>? result =
            await service.showCompetition(request, 1);

        emit(state.copyWith(
            competitions: result?.items ?? [],
            outStandingCompetitions: [],
            scope: state.scope,
            searchName: state.searchName,
            isEvent: event.isEvent, // change
            newHasNext: result?.hasNext ?? false,
            newCurrentPage: result?.currentPage ?? 1,
            isLoading: false));

        // muốn search ăn theo filter luôn
        listener.add(ListenLoadOutStandingEvent());

        //isLoading = false;
      }

      if (event is ResetFilterEvent) {
        //load lại trạng thái ban đầu
        print('LoadCompetitionEvent is ResetFilter ...');

        List<int> statuses = [];
        statuses.add(CompetitionStatus.Publish.index);
        statuses.add(CompetitionStatus.Register.index);

        CompetitionRequestModel request = CompetitionRequestModel(
            universityId: null,
            scope: CompetitionScopeStatus.InterUniversity,
            event: false,
            statuses: statuses); // add more params if you want

        PagingResult<CompetitionShowModel>? result =
            await service.showCompetition(request, 1);
        //bằng null cho về mặc định
        emit(state.copyWith(
            outStandingCompetitions: [], //state.outStandingCompetitions,
            competitions: result?.items ?? [],
            scope: CompetitionScopeStatus.InterUniversity,
            searchName: null,
            isEvent: false,
            newHasNext: result?.hasNext ?? false,
            newCurrentPage: result?.currentPage ?? 1,
            isLoading: false));
        // muốn search ăn theo filter luôn
        listener.add(ListenLoadOutStandingEvent());
      }
      //Refesh Event
      if (event is RefreshEvent) {
        emit(state.copyWith(
            outStandingCompetitions: state.outStandingCompetitions,
            competitions: [], // list empty
            scope: state.scope,
            searchName: state.searchName,
            isEvent: state.isEvent,
            newHasNext: false,
            newCurrentPage: 1,
            isLoading: true));
      }
      //Increase Event
      if (event is IncrementalEvent) {
        int increase = state.currentPage + 1;
        emit(state.copyWith(
            outStandingCompetitions: state.outStandingCompetitions,
            competitions: state.competitions,
            scope: state.scope,
            searchName: state.searchName,
            isEvent: state.isEvent,
            newHasNext: state.hasNext,
            newCurrentPage: increase, // change
            isLoading: false));
      }
      //Load more
      if (event is LoadAddMoreEvent) {
        //-----------request
        List<int> statuses = [];
        statuses.add(CompetitionStatus.Publish.index);
        statuses
            .add(CompetitionStatus.Register.index); // maybe will delete later

        CompetitionRequestModel request = CompetitionRequestModel(
            universityId:
                (state.scope == CompetitionScopeStatus.InterUniversity)
                    ? null
                    : GetIt.instance<CurrentUser>().universityId,
            scope: state.scope,
            name: state.searchName,
            statuses: statuses,
            event: state.isEvent);

        PagingResult<CompetitionShowModel>? result =
            await service.showCompetition(request, state.currentPage);
        //
        List<CompetitionShowModel> listContinute = result?.items ?? [];
        //
        if (listContinute.isNotEmpty) {
          for (CompetitionShowModel competition in listContinute) {
            state.competitions.add(competition);
          }
        }
        emit(state.copyWith(
            outStandingCompetitions: state.outStandingCompetitions,
            competitions: state.competitions,
            scope: state.scope,
            searchName: state.searchName,
            isEvent: state.isEvent,
            newHasNext: result?.hasNext ?? false,
            newCurrentPage: result?.currentPage ?? state.currentPage,
            isLoading: false));
      }
      //Search event
      if (event is SearchEvent) {
        //-----------request
        List<int> statuses = [];
        statuses.add(CompetitionStatus.Publish.index);
        statuses.add(CompetitionStatus.Register.index);

        CompetitionRequestModel request = CompetitionRequestModel(
            universityId:
                (state.scope == CompetitionScopeStatus.InterUniversity)
                    ? null
                    : GetIt.instance<CurrentUser>().universityId,
            scope: state.scope,
            name: state.searchName,
            statuses: statuses,
            event: state.isEvent);

        PagingResult<CompetitionShowModel>? result = await service
            .showCompetition(request, 1); // search là currentPage = 1 hết

        if (result != null) {
          emit(state.copyWith(
              competitions: result.items,
              outStandingCompetitions: state.outStandingCompetitions,
              searchName: state.searchName,
              scope: state.scope,
              isEvent: state.isEvent,
              newHasNext: result.hasNext,
              newCurrentPage: result.currentPage,
              isLoading: false));
        } else {
          emit(state.copyWith(
              competitions: [],
              outStandingCompetitions: state.outStandingCompetitions,
              searchName: state.searchName,
              scope: state.scope,
              isEvent: state.isEvent,
              newHasNext: false,
              newCurrentPage: 1,
              isLoading: false));
        }
        // muốn search ăn theo filter luôn
        listener.add(ListenLoadOutStandingEvent());
      }
      //
      if (event is LoadingEvent) {
        emit(state.copyWith(
            outStandingCompetitions: state.outStandingCompetitions,
            competitions: state.competitions,
            scope: state.scope,
            searchName: state.searchName,
            isEvent: state.isEvent,
            newHasNext: state.hasNext,
            newCurrentPage: state.currentPage,
            isLoading: true // change
            ));
      }
    });
  }
}
