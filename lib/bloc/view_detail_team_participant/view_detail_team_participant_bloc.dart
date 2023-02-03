import 'package:get_it/get_it.dart';

import '../../models/common/current_user.dart';
import '../../models/common/resultCRUD.dart';
import '../../models/entities/participant/view_detail_participant.dart';
import '../../models/entities/team/team_detail_model.dart';
import '../../models/enums/team_status.dart';
import '../../services/team_svc/i_team_service.dart';
import '../../utils/base_bloc.dart';
import 'view_detail_team_participant_event.dart';
import 'view_detail_team_participant_state.dart';

class ViewDetailTeamParticipantBloc extends BaseBloc<
    ViewDetailTeamParticipantEvent, ViewDetailTeamParticipantState> {
  ITeamService service;
  ViewDetailTeamParticipantBloc({required this.service})
      : super(ViewDetailTeamParticipantState(
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
          int userIdIsLeaderTeam = -1;
          int userIdInTeam = -1;
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
      if (event is ChangeTeamNameValueEvent) {
        emit(state.copyWith(
            newTeamDetail: state.teamDetail,
            newTeamId: state.teamId,
            newCompetitionId: state.competitionId,
            newUserIdLeaderTeam: state.userIdIsLeaderTeam,
            newUserIdInTeam: state.userIdInTeam,
            newValueTeamName: event.newNameValue, // change
            newValueTeamDescription: state.valueTeamDescription,
            newStatus: state.status,
            isLoading: false));
      }
      if (event is ChangeTeamDescriptionValueEvent) {
        emit(state.copyWith(
            newTeamDetail: state.teamDetail,
            newTeamId: state.teamId,
            newCompetitionId: state.competitionId,
            newUserIdLeaderTeam: state.userIdIsLeaderTeam,
            newUserIdInTeam: state.userIdInTeam,
            newValueTeamName: state.valueTeamName,
            newValueTeamDescription: event.newDescriptionValue, // change
            newStatus: state.status,
            isLoading: false));
      }
      if (event is UpdateTeamNameAndDescriptionEvent) {
        ResultCRUD result = await service.UpdateTeam(state.teamId,
            state.valueTeamName, state.valueTeamDescription, state.status);
        if (result.check) {
          TeamDetailModel? result = await service.GetDetailTeamModel(
              state.competitionId, state.teamId);
          if (result != null) {
            emit(state.copyWith(
                newTeamDetail: result,
                newCompetitionId: state.competitionId,
                newTeamId: state.teamId,
                newUserIdLeaderTeam: state.userIdIsLeaderTeam,
                newUserIdInTeam: state.userIdInTeam,
                newValueTeamName: result.name,
                newValueTeamDescription: result.description,
                newStatus: result.status,
                isLoading: false));
            listener.add(ShowingSnackBarEvent(
                message: "Cập nhật thông tin Đội thành công!"));
          }
        } else {
          listener.add(ShowingSnackBarEvent(message: result.errorMessage));
        }
      }
      if (event is UpdateStatusTeam) {
        ResultCRUD result = await service.UpdateTeam(state.teamId,
            state.valueTeamName, state.valueTeamDescription, event.status);
        if (result.check) {
          TeamDetailModel? result = await service.GetDetailTeamModel(
              state.competitionId, state.teamId);
          if (result != null) {
            emit(state.copyWith(
                newTeamDetail: result,
                newCompetitionId: state.competitionId,
                newTeamId: state.teamId,
                newUserIdLeaderTeam: state.userIdIsLeaderTeam,
                newUserIdInTeam: state.userIdInTeam,
                newValueTeamName: result.name,
                newValueTeamDescription: result.description,
                newStatus: result.status,
                isLoading: false));

            listener.add(ShowingSnackBarEvent(
                message: "Cập nhật trạng thái Đội thành công!"));
          }
        } else {
          listener.add(ShowingSnackBarEvent(message: result.errorMessage));
        }
      }
      if (event is MemberOutTeamEvent) {
        ResultCRUD check = await service.MemberOutTeam(state.teamDetail!.id);
        if (check.check) {
          TeamDetailModel? result = await service.GetDetailTeamModel(
              state.competitionId, state.teamId);
          if (result != null) {
            //
            int userIdIsLeaderTeam = -1;
            int userIdInTeam = -1;
            //Tìm User Id Leader Team
            for (ViewDetailParticipantModel participant
                in result.participants) {
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
            listener.add(
                ShowingSnackBarEvent(message: "Thoát khỏi nhóm thành công"));
          }
        } else {
          listener.add(ShowingSnackBarEvent(message: check.errorMessage));
        }
      }
      if (event is DeleteTeamByLeaderEvent) {
        ResultCRUD check = await service.DeleteTeam(state.teamDetail!.id);
        if (check.check) {
          listener.add(BackPreviousPageEvent());
          //listener.add(ShowingSnackBarEvent(message: "Xóa nhóm thành công"));
        } else {
          listener.add(ShowingSnackBarEvent(message: check.errorMessage));
        }
      }
      if (event is DeleteMemberByTeamLeaderEvent) {
        ResultCRUD check = await service.DeleteMemberByTeamLeader(
            state.teamDetail!.id, event.participantId);
        if (check.check) {
          TeamDetailModel? result = await service.GetDetailTeamModel(
              state.competitionId, state.teamId);
          if (result != null) {
            //
            int userIdIsLeaderTeam = -1;
            int userIdInTeam = -1;
            //Tìm User Id Leader Team
            for (ViewDetailParticipantModel participant
                in result.participants) {
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
            listener.add(ShowingSnackBarEvent(
                message: "Xóa thành viên khỏi nhóm thành công"));
          }
        } else {
          listener.add(ShowingSnackBarEvent(message: check.errorMessage));
        }
      }
      if (event is UpdateMemberRoleEvent) {
        ResultCRUD resultUpdate =
            await service.UpdateRoleToLeader(event.participantInTeamId);
        if (resultUpdate.check) {
          TeamDetailModel? result = await service.GetDetailTeamModel(
              state.competitionId, state.teamId);
          if (result != null) {
            //
            int userIdIsLeaderTeam = -1;
            int userIdInTeam = -1;
            //Tìm User Id Leader Team
            for (ViewDetailParticipantModel participant
                in result.participants) {
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
            listener.add(ShowingSnackBarEvent(message: "Cập nhật thành công"));
          }
        } else {
          listener
              .add(ShowingSnackBarEvent(message: resultUpdate.errorMessage));
        }
      }
      if (event is ClickToViewInfoEvent) {
        listener.add(NavigatorToAccountPageEvent(userId: event.userId));
      }
      if (event is LoadingEvent) {
        emit(state.copyWith(
            newTeamDetail: state.teamDetail,
            newTeamId: state.teamId,
            newCompetitionId: state.competitionId,
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
          int userIdIsLeaderTeam = -1;
          int userIdInTeam = -1;
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
