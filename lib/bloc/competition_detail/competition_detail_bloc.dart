import 'package:unicec_mobi/models/common/resultCRUD.dart';
import 'package:unicec_mobi/models/entities/competition/competition_detail_model.dart';
import 'package:unicec_mobi/models/entities/participant/participant_model.dart';
import 'package:unicec_mobi/models/enums/competition_scope_status.dart';
import 'package:unicec_mobi/models/enums/competition_status.dart';
import 'package:unicec_mobi/models/enums/team_status.dart';
import 'package:unicec_mobi/services/i_services.dart';
import 'package:unicec_mobi/utils/base_bloc.dart';
import '../../models/entities/competition/competition_model.dart';
import '../../services/competition_detail_svc/i_competition_detail_service.dart';
import 'competition_detail_event.dart';
import 'competition_detail_state.dart';

class CompetitionDetailBloc
    extends BaseBloc<CompetitionDetailEvent, CompetitionDetailState> {
  final ICompetitionDetailService service;
  ITeamService teamService;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool isLoading) {
    _isLoading = isLoading;
  }

  CompetitionDetailBloc({required this.service, required this.teamService})
      : super(CompetitionDetailState(
          competitionDetail: CompetitionDetailModel(
              universityImage: '',
              universityName: '',
              addressName: '',
              competitionEntities: [],
              maxNumber: 0,
              startTimeRegister: DateTime.now(),
              scope: CompetitionScopeStatus.Club,
              clubsInCompetition: [],
              name: '',
              view: 3,
              seedsDeposited: 20,
              numberOfParticipation: 1,
              address: '',
              status: CompetitionStatus.Approve,
              createTime: DateTime.now(),
              majorsInCompetition: [],
              fee: 30.5,
              isSponsor: true,
              id: 1,
              seedsPoint: 2,
              endTimeRegister: DateTime.now(),
              minNumber: 3,
              startTime: DateTime.now(),
              competitionTypeId: 1,
              endTime: DateTime.now(),
              universityId: 1,
              seedsCode: '',
              competitionTypeName: '',
              content: ''),
          isParticipant: false,
          isAttendance: false,
        )) {
    on((event, emit) async {
      if (event is LoadCompetitionDetailEvent) {
        print('LoadCompetitionEvent is running ...');
        _isLoading = true;

        CompetitionDetailModel? competition =
            await service.getById(event.competitionId);

        //-----------check pariticipant
        bool isParticipant = false;
        CompetitionModel? competitionUserJoin =
            await service.getCompetitionStudentJoin(event.competitionId);
        if (competitionUserJoin != null) {
          isParticipant = true;
        }
        //-----------check pariticipant is attendance
        bool isAttendance = false;
        ParticipantModel? participant =
            await service.getParticipant(event.competitionId);
        if (participant != null) {
          isAttendance = participant.attendance;
        }

        emit(state.copyWith(
            competitionDetail: competition,
            isParticipant: isParticipant,
            isAttendance: isAttendance));
        _isLoading = false;
      }

      if (event is ParticipateTheCompetitionEvent) {
        print('ParticipateTheCompetitionEvent is running ...');
        _isLoading = true;
        ResultCRUD result =
            await service.participateCompetition(event.competitionId);
        if (result.check == true) {
          emit(state.copyWith(
              isParticipant: result.check,
              competitionDetail: state.competitionDetail,
              isAttendance: state.isAttendance));
          listener.add(ShowPopUpAnnouncement(message: 'Tham gia thành công'));
        } else {
          listener.add(ShowPopUpAnnouncement(message: result.errorMessage));
        }
        _isLoading = false;
      }

      if (event is AttendanceCompetitionEvent) {
        print('AttendanceCompetitionEvent is running ...');
        _isLoading = true;
        ResultCRUD result =
            await service.attendanceCompetition(event.seedsCode);
        if (result.check == true) {
          //-----------check participant is attendance
          bool isAttendance = false;
          ParticipantModel? participant =
              await service.getParticipant(state.competitionDetail!.id);
          if (participant != null) {
            isAttendance = participant.attendance;
          }

          emit(state.copyWith(
              isParticipant: result.check,
              competitionDetail: state.competitionDetail,
              isAttendance:
                  isAttendance // nếu hàm này Success thì emit state là đã điểm danh -> giao diện sẽ hiện button điểm danh r
              ));
          listener.add(ShowPopUpAnnouncement(message: 'Điểm danh thành công'));
        } else {
          listener.add(ShowPopUpAnnouncement(message: result.errorMessage));
        }
        _isLoading = false;
      }

      if (event is CreateTeamEvent) {
        ResultCRUD result = await teamService.CreateTeam(
            event.competitionId, event.teamName, event.description ?? "");
        await teamService.UpdateTeam(
            result.returnIntData, // teamId
            event.teamName,
            event.description ?? "",
            TeamStatus.IsLocked); // default status when create team 1 member
      }
    });
  }
}
