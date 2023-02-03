import 'package:get_it/get_it.dart';
import 'package:unicec_mobi/bloc/view_competition_member_task/view_competition_member_task_event.dart';
import 'package:unicec_mobi/bloc/view_competition_member_task/view_competition_member_task_state.dart';
import 'package:unicec_mobi/models/common/current_user.dart';

import 'package:unicec_mobi/models/common/paging_result.dart';

import '../../models/entities/competition/competition_model.dart';

import '../../services/competition_svc/i_competition_service.dart';
import '../../utils/base_bloc.dart';

class ViewCompetitionMemberTaskBloc extends BaseBloc<
    ViewCompetitionMemberTaskEvent, ViewCompetitionMemberTaskState> {
  final ICompetitionService service;

  ViewCompetitionMemberTaskBloc({required this.service})
      : super(ViewCompetitionMemberTaskState(
          listCompetition: [],
          searchName: null,
          isEvent: false,
          hasNext: false,
          currentPage: 1,
          isLoading: true,
        )) {
    on((event, emit) async {
      //init Event
      if (event is InitEvent) {
        CurrentUser user = GetIt.I.get<CurrentUser>();

        //get clubIdSelected
        if (user.clubIdSelected != 0 
              && user.clubsBelongToStudent.isNotEmpty
              && user.clubsBelongToStudent
                  .any((element) => element.id == user.clubIdSelected)) {
          //load
          PagingResult<CompetitionModel>? result =
              await service.loadCompetitionMemberTask(
                  state.currentPage, state.searchName, state.isEvent);
          //
          if (result != null) {
            //emit
            emit(state.copyWith(
                listCompetition: result.items,
                searchName: state.searchName,
                isEvent: state.isEvent,
                hasNext: result.hasNext,
                currentPage: result.currentPage,
                isLoading: false));
          } else {
            //emit
            emit(state.copyWith(
                listCompetition: [],
                searchName: state.searchName,
                isEvent: state.isEvent,
                hasNext: false,
                currentPage: 1,
                isLoading: false));
          }
        }
      }
      //Refesh Event
      if (event is RefreshEvent) {
        //refresh state
        emit(state.copyWith(
            listCompetition: [],
            searchName: state.searchName,
            isEvent: state.isEvent,
            hasNext: false,
            currentPage: 1,
            isLoading: true));
      }
      //Increase Event
      if (event is IncrementalEvent) {
        int increase = state.currentPage + 1;
        emit(state.copyWith(
            listCompetition: state.listCompetition,
            searchName: state.searchName,
            isEvent: state.isEvent,
            hasNext: state.hasNext,
            currentPage: increase,
            isLoading: false));
      }
      //Load More
      if (event is LoadAddMoreEvent) {
        //load
        PagingResult<CompetitionModel>? result =
            await service.loadCompetitionMemberTask(
                state.currentPage, state.searchName, state.isEvent);
        //
        List<CompetitionModel> listContinute = result?.items ?? [];
        //
        if (listContinute.isNotEmpty) {
          for (CompetitionModel competition in listContinute) {
            state.listCompetition.add(competition);
          }
        }
        //
        emit(state.copyWith(
            listCompetition: state.listCompetition,
            searchName: state.searchName,
            isEvent: state.isEvent,
            hasNext: result?.hasNext ??
                false, // result trả ra null thì đồng nghĩa với việc hasNext = false
            currentPage: result?.currentPage ?? state.currentPage,
            isLoading: false));
      }
      if (event is ChangeSearchNameEvent) {
        emit(state.copyWith(
            listCompetition: state.listCompetition,
            searchName: event.searchName, // change
            isEvent: state.isEvent,
            hasNext: state.hasNext,
            currentPage: state.currentPage,
            isLoading: false));
      }
      if (event is ChangeValueEvent) {
        //load
        PagingResult<CompetitionModel>? result = await service
            .loadCompetitionMemberTask(1, state.searchName, event.isEvent);

        emit(state.copyWith(
            listCompetition: result?.items ?? [],
            searchName: state.searchName,
            isEvent: event.isEvent, // change
            hasNext: result?.hasNext ?? false,
            currentPage: result?.currentPage ?? 1,
            isLoading: false));
      }
      if (event is SearchEvent) {
        CurrentUser user = GetIt.I.get<CurrentUser>();

        //get clubIdSelected
        if (user.clubIdSelected != 0 
              && user.clubsBelongToStudent.isNotEmpty
              && user.clubsBelongToStudent
                  .any((element) => element.id == user.clubIdSelected)) {
          //load
          PagingResult<CompetitionModel>? result = await service
              .loadCompetitionMemberTask(1, state.searchName, state.isEvent);
          //emit
          emit(state.copyWith(
              listCompetition: result?.items ?? [],
              searchName: state.searchName,
              isEvent: state.isEvent,
              hasNext: result?.hasNext ?? false,
              currentPage: result?.currentPage ?? 1,
              isLoading: false));
        }
      }
      if (event is LoadingEvent) {
        emit(state.copyWith(
            listCompetition: state.listCompetition,
            searchName: state.searchName,
            isEvent: state.isEvent,
            hasNext: state.hasNext,
            currentPage: state.currentPage,
            isLoading: true));
      }
    });
  }
}
