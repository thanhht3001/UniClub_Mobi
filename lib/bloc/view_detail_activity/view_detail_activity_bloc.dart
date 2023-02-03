import 'package:get_it/get_it.dart';

import '../../models/common/current_user.dart';
import '/models/entities/competition_activity/competition_activity_detail_model.dart';
import '../../models/enums/competition_activity_status.dart';
import '../../services/view_competition_activity_svc/i_view_competition_activity_service.dart';
import '/bloc/view_detail_activity/view_detail_activity_event.dart';
import '../../utils/base_bloc.dart';
import 'view_detail_activity_state.dart';

class ViewDetailActivityBloc
    extends BaseBloc<ViewDetailActivityEvent, ViewDetailActivityState> {
  ICompetitionActivityService service;

  ViewDetailActivityBloc({required this.service})
      : super(ViewDetailActivityState(
            competitionActivityDetail: null,
            status: CompetitionActivityStatus.Open,
            selectedImageIndex: 0,
            isLoading: true)) {
    (on(
      (event, emit) async {
        //receive data
        if (event is ReceiveDataEvent) {
          CompetitionActivityDetailModel? result = await service
              .getCompetitionActivityDetail(event.competitionActivityId);    
          if (result != null) {
            emit(state.copyWith(
                newCompetitionActivityDetail: result,
                newStatus: result.status,
                newSelectedImageIndex: state.selectedImageIndex,
                isLoading: false));
          
          }else{
            listener.add(NavigateToListActivitiesEvent());
            CurrentUser user = GetIt.I.get<CurrentUser>();
            user.clubIdSelected = 0;
            user.clubsBelongToStudent = [];            
          }
        }

        //change status
        if (event is ChangeStatusEvent) {
          emit(state.copyWith(
              newCompetitionActivityDetail: state.competitionActivityDetail!,
              newStatus: event.newStatus, // change
              newSelectedImageIndex: state.selectedImageIndex,
              isLoading: false));
        }

        //update status competition activity
        if (event is UpdateStatusEvent) {
          bool check = await service.updateStatusCompetitionActivity(
              state.status, state.competitionActivityDetail!.id);
          if (check) {
            CompetitionActivityDetailModel? result =
                await service.getCompetitionActivityDetail(
                    state.competitionActivityDetail!.id);
            if (result != null) {
              //
              listener.add(ShowingSnackBarEvent(message: "Update thành công"));
              //
              emit(state.copyWith(
                  newCompetitionActivityDetail: result,
                  newStatus: result.status,
                  newSelectedImageIndex: state.selectedImageIndex,
                  isLoading: false));
            }
          } else {
            listener.add(ShowingSnackBarEvent(message: "Update thất bại"));
          }
        }

        //change image index
        if (event is ChangeImageIndex) {
          emit(state.copyWith(
                  newCompetitionActivityDetail:
                      state.competitionActivityDetail!,
                  newStatus: state.status,
                  newSelectedImageIndex: event.imageIndex,
                  isLoading: false) // change
              );
        }
      },
    ));
  }
}
