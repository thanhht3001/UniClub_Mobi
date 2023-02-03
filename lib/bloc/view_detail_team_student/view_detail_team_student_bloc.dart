import 'package:get_it/get_it.dart';
import '../../models/common/current_user.dart';
import '../../models/entities/participant/view_detail_participant.dart';
import '../../models/entities/team/team_detail_model.dart';
import '../../models/enums/team_status.dart';
import '../../services/team_svc/i_team_service.dart';
import '../../utils/base_bloc.dart';
import 'view_detail_team_student_event.dart';
import 'view_detail_team_student_state.dart';

class ViewDetailTeamStudentBloc
    extends BaseBloc<ViewDetailTeamStudentEvent, ViewDetailTeamStudentState> {
  ITeamService service;
  ViewDetailTeamStudentBloc({required this.service})
      : super(ViewDetailTeamStudentState(
          teamDetail: null,
          competitionId: -1,
          teamId: -1,
          userIdIsLeaderTeam: -1,
          userIdInTeam: -1,
          valueTeamName: '',
          valueTeamDescription: '',
          status: TeamStatus.Available,
          isLoading: true,
        )) {
    on((event, emit) async {
      if (event is ReceiveDataEvent) {
        TeamDetailModel? result =
            await service.GetDetailTeamModel(event.competitionId, event.teamId);
        if (result != null) {
          //
          int userIdIsLeaderTeam = -2;
          int userIdInTeam = -2;
          //Tìm User Id Leader Team
          for (ViewDetailParticipantModel participant in result.participants) {
            //Tìm User Id Leader Team
            if (participant.teamRoleName.compareTo("Leader") == 0) {
              userIdIsLeaderTeam = participant.studentId;
            }
            //Tìm UserId xem là thằng đang vào trang này có trong team kh
            if (participant.studentId == GetIt.I.get<CurrentUser>().id) {
              userIdInTeam = participant.studentId;
            }
          }
          emit(state.copyWith(
              newTeamDetail: result,
              newCompetitionId: event.competitionId,
              newTeamId: event.teamId,
              newUserIdLeaderTeam: userIdIsLeaderTeam,
              newUserIdInTeam: userIdInTeam,
              newValueTeamName: result.name,
              newValueTeamDescription: result.description,
              newStatus: result.status,
              isLoading: false));
        }
      }
      if (event is ClickToViewInfoEvent) {
        listener.add(NavigatorToAccountPageEvent(userId: event.userId));
      }
      if (event is LoadingEvent) {
        emit(state.copyWith(
            newTeamDetail: state.teamDetail,
            newCompetitionId: state.competitionId,
            newTeamId: state.teamId,
            newUserIdLeaderTeam: state.userIdIsLeaderTeam,
            newUserIdInTeam: state.userIdInTeam,
            newValueTeamName: state.valueTeamName,
            newValueTeamDescription: state.valueTeamDescription,
            newStatus: state.status,
            isLoading: true // change
            ));
      }
      if (event is LoadDataEvent) {
        TeamDetailModel? result =
            await service.GetDetailTeamModel(state.competitionId, state.teamId);
        if (result != null) {
          //
          int userIdIsLeaderTeam = -2;
          int userIdInTeam = -2;
          //Tìm User Id Leader Team
          for (ViewDetailParticipantModel participant in result.participants) {
            //Tìm User Id Leader Team
            if (participant.teamRoleName.compareTo("Leader") == 0) {
              userIdIsLeaderTeam = participant.studentId;
            }
            //Tìm UserId xem là thằng đang vào trang này có trong team kh
            if (participant.studentId == GetIt.I.get<CurrentUser>().id) {
              userIdInTeam = participant.studentId;
            }
          }
          emit(state.copyWith(
              newTeamDetail: result,
              newCompetitionId: state.competitionId,
              newTeamId: state.teamId,
              newUserIdLeaderTeam: userIdIsLeaderTeam,
              newUserIdInTeam: userIdInTeam,
              newValueTeamName: result.name,
              newValueTeamDescription: result.description,
              newStatus: result.status,
              isLoading: false));
        }
      }
    });
  }
}
