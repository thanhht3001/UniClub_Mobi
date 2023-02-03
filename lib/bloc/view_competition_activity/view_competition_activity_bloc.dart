import '../../models/enums/priority_status.dart';
import '/bloc/view_competition_activity/view_competition_activity_state.dart';
import '/models/enums/competition_activity_status.dart';
import '../../models/common/paging_result.dart';
import '../../models/entities/competition_activity/competition_activity_model.dart';
import '../../models/entities/competition_activity/competition_activity_request_model.dart';
import '../../services/view_competition_activity_svc/i_view_competition_activity_service.dart';
import '../../utils/base_bloc.dart';
import '/bloc/view_competition_activity/view_competition_activity_event.dart';

class ViewCompetitionActivityBloc extends BaseBloc<ViewCompetitionActivityEvent,
    ViewCompetitionActivityState> {
  ICompetitionActivityService service;

  ViewCompetitionActivityBloc({required this.service})
      : super(ViewCompetitionActivityState(
            listCompetitionActivity: [],
            competitionId: 0,
            searchName: null,
            choosePriorityStatus: PriorityStatus.All,
            loadPriorityStatus: [],
            chooseStatus: CompetitionActivityStatus.All,
            loadListStatuses: [],
            hasNext: false,
            currentPage: 1,
            isLoading: true)) {
    on((event, emit) async {
      //Init Event
      if (event is ViewCompetitionActivityInitEvent) {
        //------------Request
        CompetitionActivityRequestModel request =
            CompetitionActivityRequestModel();
        request.competitionId = state.competitionId;
        request.currentPage = state.currentPage;
        request.name = state.searchName;

        if (state.chooseStatus == CompetitionActivityStatus.All) {
          //status
          request.statuses = [];
          request.statuses?.add(CompetitionActivityStatus.Open);
          request.statuses?.add(CompetitionActivityStatus.OnGoing);
          request.statuses?.add(CompetitionActivityStatus.Finished);
          request.statuses?.add(CompetitionActivityStatus.Pending);
          request.statuses?.add(CompetitionActivityStatus.Completed);
        } else {
          request.statuses = [];
          request.statuses?.add(state.chooseStatus);
        }
        if (state.choosePriorityStatus == PriorityStatus.All) {
          request.priority = null;
        } else {
          request.priority = state.choosePriorityStatus;
        }

        PagingResult<CompetitionActivityModel>? result =
            await service.getListCompetitionActivity(request);

        if (result != null) {
          emit(state.copyWith(
              newListCompetitionActivity: result.items,
              newCompetitionId: state.competitionId,
              searchName: state.searchName,
              choosePriorityStatus: state.choosePriorityStatus,
              loadPriorityStatus: state.loadPriorityStatus,
              chooseStatus: state.chooseStatus,
              loadListStatuses: state.loadListStatuses,
              newHasNext: result.hasNext,
              newCurrentPage: result.currentPage,
              isLoading: false));
        } else {
          emit(state.copyWith(
              newListCompetitionActivity: [],
              newCompetitionId: state.competitionId,
              searchName: state.searchName,
              choosePriorityStatus: state.choosePriorityStatus,
              loadPriorityStatus: state.loadPriorityStatus,
              chooseStatus: state.chooseStatus,
              loadListStatuses: state.loadListStatuses,
              newHasNext: false,
              newCurrentPage: 1,
              isLoading: false));
        }
      }

      //Recieve Data Event
      //lúc nào cũng giá trị đầu
      if (event is ReceiveDataEvent) {
        //---------LoadStatuses
        List<CompetitionActivityStatus> loadListStatuses = [];
        loadListStatuses.add(CompetitionActivityStatus.Open);
        loadListStatuses.add(CompetitionActivityStatus.OnGoing);
        loadListStatuses.add(CompetitionActivityStatus.Finished);
        loadListStatuses.add(CompetitionActivityStatus.Pending);
        loadListStatuses.add(CompetitionActivityStatus.Completed);
        loadListStatuses.add(CompetitionActivityStatus.All);

        //---------Load List Priority Status
        List<PriorityStatus> loadListPriority = [];
        loadListPriority.add(PriorityStatus.Low);
        loadListPriority.add(PriorityStatus.High);
        loadListPriority.add(PriorityStatus.Medium);
        loadListPriority.add(PriorityStatus.All);

        //------------Request
        CompetitionActivityRequestModel request =
            CompetitionActivityRequestModel();
        request.competitionId = event.competitionId;
        request.currentPage = state.currentPage;
        request.name = state.searchName; // null
        if (state.chooseStatus == CompetitionActivityStatus.All) {
          //status
          request.statuses = [];
          request.statuses?.add(CompetitionActivityStatus.Open);
          request.statuses?.add(CompetitionActivityStatus.OnGoing);
          request.statuses?.add(CompetitionActivityStatus.Finished);
          request.statuses?.add(CompetitionActivityStatus.Pending);
          request.statuses?.add(CompetitionActivityStatus.Completed);
        } else {
          request.statuses = [];
          request.statuses?.add(state.chooseStatus);
        }
        if (state.choosePriorityStatus == PriorityStatus.All) {
          request.priority = null;
        } else {
          request.priority = state.choosePriorityStatus;
        }

        PagingResult<CompetitionActivityModel>? result =
            await service.getListCompetitionActivity(request);

        emit(state.copyWith(
            newListCompetitionActivity:
                result?.items ?? state.listCompetitionActivity,
            newCompetitionId: event.competitionId,
            searchName: state.searchName,
            choosePriorityStatus: state.choosePriorityStatus,
            loadPriorityStatus: loadListPriority,
            chooseStatus: state.chooseStatus,
            loadListStatuses: loadListStatuses, // change
            newHasNext: result?.hasNext ?? state.hasNext,
            newCurrentPage: result?.currentPage ?? state.currentPage,
            isLoading: false));
      }

      //Refesh Event
      if (event is RefreshEvent) {
        emit(state.copyWith(
            newListCompetitionActivity: [],
            newCompetitionId: state.competitionId,
            choosePriorityStatus: state.choosePriorityStatus,
            loadPriorityStatus: state.loadPriorityStatus,
            searchName: state.searchName,
            chooseStatus: state.chooseStatus,
            loadListStatuses: state.loadListStatuses,
            newHasNext: false,
            newCurrentPage: 1,
            isLoading: true));
      }
      //Increase Event
      if (event is IncrementalEvent) {
        int increase = state.currentPage + 1;
        emit(state.copyWith(
            newListCompetitionActivity: state.listCompetitionActivity,
            newCompetitionId: state.competitionId,
            choosePriorityStatus: state.choosePriorityStatus,
            loadPriorityStatus: state.loadPriorityStatus,
            searchName: state.searchName,
            chooseStatus: state.chooseStatus,
            loadListStatuses: state.loadListStatuses,
            newHasNext: state.hasNext,
            newCurrentPage: increase, // change
            isLoading: false));
      }
      //LoadMore
      if (event is LoadAddMoreEvent) {
        //------------Request
        CompetitionActivityRequestModel request =
            CompetitionActivityRequestModel();
        request.competitionId = state.competitionId;
        request.currentPage = state.currentPage;
        request.name = state.searchName;
        if (state.chooseStatus == CompetitionActivityStatus.All) {
          //status
          request.statuses = [];
          request.statuses?.add(CompetitionActivityStatus.Open);
          request.statuses?.add(CompetitionActivityStatus.OnGoing);
          request.statuses?.add(CompetitionActivityStatus.Finished);
          request.statuses?.add(CompetitionActivityStatus.Pending);
          request.statuses?.add(CompetitionActivityStatus.Completed);
        } else {
          request.statuses = [];
          request.statuses?.add(state.chooseStatus);
        }
        if (state.choosePriorityStatus == PriorityStatus.All) {
          request.priority = null;
        } else {
          request.priority = state.choosePriorityStatus;
        }

        //load
        PagingResult<CompetitionActivityModel>? result =
            await service.getListCompetitionActivity(request);
        //
        List<CompetitionActivityModel> listContinute = result?.items ?? [];
        //
        if (listContinute.isNotEmpty) {
          for (CompetitionActivityModel competitionActivity in listContinute) {
            state.listCompetitionActivity.add(competitionActivity);
          }
        }
        //
        emit(state.copyWith(
            newListCompetitionActivity: state.listCompetitionActivity,
            newCompetitionId: state.competitionId,
            choosePriorityStatus: state.choosePriorityStatus,
            loadPriorityStatus: state.loadPriorityStatus,
            searchName: state.searchName,
            chooseStatus: state.chooseStatus,
            loadListStatuses: state.loadListStatuses,
            newHasNext: result?.hasNext ??
                false, // result trả ra null thì đồng nghĩa với việc hasNext = false
            newCurrentPage: result?.currentPage ?? state.currentPage,
            isLoading: false));
      }
      if (event is ChangeSearchNameEvent) {
        emit(state.copyWith(
            newListCompetitionActivity: state.listCompetitionActivity,
            newCompetitionId: state.competitionId,
            choosePriorityStatus: state.choosePriorityStatus,
            loadPriorityStatus: state.loadPriorityStatus,
            searchName: event.searchName, // change
            chooseStatus: state.chooseStatus,
            loadListStatuses: state.loadListStatuses,
            newHasNext: state.hasNext,
            newCurrentPage: state.currentPage,
            isLoading: false));
      }
      if (event is ChangeValueStatusEvent) {
        //------------Request
        CompetitionActivityRequestModel request =
            CompetitionActivityRequestModel();
        request.competitionId = state.competitionId;
        request.currentPage = 1; // này là 1 để search từ đầu
        request.name = state.searchName; // null
        if (event.chooseStatus == CompetitionActivityStatus.All) {
          //status
          request.statuses = [];
          request.statuses?.add(CompetitionActivityStatus.Open);
          request.statuses?.add(CompetitionActivityStatus.OnGoing);
          request.statuses?.add(CompetitionActivityStatus.Finished);
          request.statuses?.add(CompetitionActivityStatus.Pending);
          request.statuses?.add(CompetitionActivityStatus.Completed);
        } else {
          request.statuses = [];
          request.statuses?.add(event.chooseStatus);
        }
        if (state.choosePriorityStatus == PriorityStatus.All) {
          request.priority = null;
        } else {
          request.priority = state.choosePriorityStatus;
        }

        PagingResult<CompetitionActivityModel>? result =
            await service.getListCompetitionActivity(request);

        emit(state.copyWith(
            newListCompetitionActivity: result?.items ?? [],
            newCompetitionId: state.competitionId,
            choosePriorityStatus: state.choosePriorityStatus,
            loadPriorityStatus: state.loadPriorityStatus,
            searchName: state.searchName,
            chooseStatus: event.chooseStatus, // change
            loadListStatuses: state.loadListStatuses,
            newHasNext: result?.hasNext ?? false,
            newCurrentPage: result?.currentPage ?? 1,
            isLoading: false));
      }
      if (event is ChangeValuePriorityStatusEvent) {
        //------------Request
        CompetitionActivityRequestModel request =
            CompetitionActivityRequestModel();
        request.competitionId = state.competitionId;
        request.currentPage = 1;
        request.name = state.searchName; // null
        if (state.chooseStatus == CompetitionActivityStatus.All) {
          //status
          request.statuses = [];
          request.statuses?.add(CompetitionActivityStatus.Open);
          request.statuses?.add(CompetitionActivityStatus.OnGoing);
          request.statuses?.add(CompetitionActivityStatus.Finished);
          request.statuses?.add(CompetitionActivityStatus.Pending);
          request.statuses?.add(CompetitionActivityStatus.Completed);
        } else {
          request.statuses = [];
          request.statuses?.add(state.chooseStatus);
        }
        if (event.choosePriorityStatus == PriorityStatus.All) {
          request.priority = null;
        } else {
          request.priority = event.choosePriorityStatus;
        }

        PagingResult<CompetitionActivityModel>? result =
            await service.getListCompetitionActivity(request);

        emit(state.copyWith(
            newListCompetitionActivity: result?.items ?? [],
            newCompetitionId: state.competitionId,
            choosePriorityStatus: event.choosePriorityStatus, // change
            loadPriorityStatus: state.loadPriorityStatus,
            searchName: state.searchName,
            chooseStatus: state.chooseStatus,
            loadListStatuses: state.loadListStatuses,
            newHasNext: result?.hasNext ?? false,
            newCurrentPage: result?.currentPage ?? 1,
            isLoading: false));
      }
      if (event is SearchEvent) {
        //------------Request
        CompetitionActivityRequestModel request =
            CompetitionActivityRequestModel();
        request.competitionId = state.competitionId;
        request.currentPage = 1;
        request.name = state.searchName;

        if (state.chooseStatus == CompetitionActivityStatus.All) {
          //status
          request.statuses = [];
          request.statuses?.add(CompetitionActivityStatus.Open);
          request.statuses?.add(CompetitionActivityStatus.OnGoing);
          request.statuses?.add(CompetitionActivityStatus.Finished);
          request.statuses?.add(CompetitionActivityStatus.Pending);
          request.statuses?.add(CompetitionActivityStatus.Completed);
        } else {
          request.statuses = [];
          request.statuses?.add(state.chooseStatus);
        }
        if (state.choosePriorityStatus == PriorityStatus.All) {
          request.priority = null;
        } else {
          request.priority = state.choosePriorityStatus;
        }

        //load
        PagingResult<CompetitionActivityModel>? result =
            await service.getListCompetitionActivity(request);

        emit(state.copyWith(
            newListCompetitionActivity: result?.items ?? [],
            newCompetitionId: state.competitionId,
            choosePriorityStatus: state.choosePriorityStatus,
            loadPriorityStatus: state.loadPriorityStatus,
            searchName: state.searchName,
            chooseStatus: state.chooseStatus,
            loadListStatuses: state.loadListStatuses,
            newHasNext: result?.hasNext ?? false,
            newCurrentPage: result?.currentPage ?? 1,
            isLoading: false));
      }
      if (event is LoadingEvent) {
        emit(state.copyWith(
            newListCompetitionActivity: state.listCompetitionActivity,
            newCompetitionId: state.competitionId,
            choosePriorityStatus: state.choosePriorityStatus,
            loadPriorityStatus: state.loadPriorityStatus,
            searchName: state.searchName,
            chooseStatus: state.chooseStatus,
            loadListStatuses: state.loadListStatuses,
            newHasNext: state.hasNext,
            newCurrentPage: state.currentPage,
            isLoading: true));
      }
    });
  }
}
