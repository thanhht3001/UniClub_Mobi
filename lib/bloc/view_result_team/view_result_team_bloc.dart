import 'package:unicec_mobi/bloc/view_result_team/view_result_team_event.dart';
import 'package:unicec_mobi/bloc/view_result_team/view_result_team_state.dart';
import 'package:unicec_mobi/models/entities/match/match_model.dart';
import 'package:unicec_mobi/models/entities/team/team_in_competition_model.dart';
import 'package:unicec_mobi/services/i_services.dart';
import 'package:unicec_mobi/utils/base_bloc.dart';

import '../../services/match_svc/i_match_service.dart';

class ViewResultTeamBloc
    extends BaseBloc<ViewResultTeamEvent, ViewResultTeamState> {
  final ITeamService service;
  final IMatchService matchService;
  bool _isLoading = false;

  bool get IsLoading => _isLoading;

  set IsLoading(bool isLoading) {
    _isLoading = isLoading;
  }

  ViewResultTeamBloc({required this.service, required this.matchService})
      : super(ViewResultTeamState(
            match: null,
            resultTeamInCompetition: ResultTeamInCompetitionModel(
                competitionId: 0,
                competitionName: "",
                membersInTeam: [],
                teamId: 0,
                teamInRounds: [],
                teamName: ""))) {
    on((event, emit) async {
      if (event is LoadData) {
        print('ResultTeamInCompetition LoadData event is loading ... !!!');
        _isLoading = true;

        ResultTeamInCompetitionModel? resultTeamInCompetition =
            await service.GetTotalResultTeamInCompetition(
                event.competitionId, event.teamId);
        emit(state.copyWith(resultTeamInCompetition: resultTeamInCompetition));
        print('!!!!!!!!!!!!!!!!!!!!!!! resultTeamInCompetition: $resultTeamInCompetition');
        print('!!!!!!!!!!!!!!!!!!!!!!! teamInRounds: ${resultTeamInCompetition?.teamInRounds}');

        _isLoading = false;
      }

      if (event is LoadMatchDetailEvent) {
        print(
            'ResultTeamInCompetition LoadMatchDetail event is loading ... !!!');
        _isLoading = true;

        MatchModel? match = await matchService.getMatchById(event.matchId);
        emit(state.copyWith(
            resultTeamInCompetition: state.resultTeamInCompetition,
            match: match));    

        listener.add(NavigateToMatchDetailEvent());

        _isLoading = false;
      }
    });
  }
}
