import 'package:unicec_mobi/models/common/paging_result.dart';
import 'package:unicec_mobi/models/entities/competition_round/competition_round_model.dart';
import 'package:unicec_mobi/models/entities/team/team_in_round_model.dart';
import 'package:unicec_mobi/utils/base_bloc.dart';
import '../../models/entities/team/team_in_competition_model.dart';
import '../../services/competition_round_svc/i_competition_round_service.dart';
import '../../utils/log.dart';
import 'competition_round_event.dart';
import 'competition_round_state.dart';

class CompetitionRoundBloc
    extends BaseBloc<CompetitionRoundEvent, CompetitionRoundState> {
  final ICompetitionRoundService service;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool isLoading) {
    _isLoading = isLoading;
  }

  CompetitionRoundBloc({required this.service})
      : super(CompetitionRoundState(competitionRounds: [], teamsInRoundResult: [])) {
    on((event, emit) async {
      if (event is LoadRoundsByCompetition) {
        _isLoading = true;
        PagingResult<CompetitionRoundModel>? competitionRounds =
            await service.loadRoundsByCompetition(event.competitionId);
        emit(state.copyWith(
            competitionRoundModel: competitionRounds?.items ?? []));
        _isLoading = false;
        Log.info('isLoading: $_isLoading');
      }

      if(event is LoadResultARoundInCompetition){
        _isLoading = true;
        PagingResult<TeamInRoundModel>? teamsInRoundResult = await service.loadRoundResultById(event.roundId);
        emit(state.copyWith(teamsInRoundResult: teamsInRoundResult?.items));
        _isLoading = false;
      }

      if(event is LoadResultTeamsInCompetition){
        _isLoading = true;
        List<ResultTeamsInCompetitionModel>? teamsInCompetitionResult = await service.loadTeamResultByCompetition(event.competitionId);
        emit(state.copyWith(teamsInCompetitionResult: teamsInCompetitionResult));
        _isLoading = false;
      }
    });
  }
}
