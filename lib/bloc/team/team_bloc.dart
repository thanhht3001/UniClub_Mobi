import 'package:unicec_mobi/bloc/team/team_event.dart';
import 'package:unicec_mobi/bloc/team/team_state.dart';
import 'package:unicec_mobi/models/entities/team/team_model.dart';
import 'package:unicec_mobi/models/enums/team_status.dart';
import 'package:unicec_mobi/services/i_services.dart';
import 'package:unicec_mobi/utils/base_bloc.dart';

class TeamBloc extends BaseBloc<TeamEvent, TeamState> {
  final ITeamService service;

  TeamBloc({required this.service})
      : super(TeamState(
            team: TeamModel(
                id: 0,
                competitionId: 0,
                name: '',
                description: '',
                invitedCode: '',
                numberOfMemberInTeam: 0,
                status: TeamStatus.Available))) {
    on((event, emit) => {if (event is LoadTeamEvent) {}});
  }
}
