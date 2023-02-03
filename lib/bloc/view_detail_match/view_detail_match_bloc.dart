import 'package:unicec_mobi/bloc/view_detail_match/view_detail_match_event.dart';
import 'package:unicec_mobi/bloc/view_detail_match/view_detail_match_state.dart';
import 'package:unicec_mobi/models/entities/match/match_model.dart';
import 'package:unicec_mobi/utils/base_bloc.dart';

import '../../models/entities/match/teams_in_match_model.dart';
import '../../models/enums/match_status.dart';
import '../../services/match_svc/i_match_service.dart';

class ViewDetailMatchBloc
    extends BaseBloc<ViewDetailMatchEvent, ViewDetailMatchState> {
  IMatchService service;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool isLoading) {
    _isLoading = isLoading;
  }

  ViewDetailMatchBloc({required this.service})
      : super(ViewDetailMatchState(
            match: MatchModel(
                id: 0,
                address: "",
                createTime: DateTime.now(),
                endTime: DateTime.now(),
                roundTypeId: 0,
                roundTypeName: '',
                description: "",
                isLoseMatch: null,
                numberOfTeam: 0,
                roundId: 0,
                roundName: "",
                startTime: DateTime.now(),
                status: MatchStatus.Ready,
                title: ""),
            teamsInMatch: [])) {
    (on((event, emit) async {
      if (event is LoadData) {
        _isLoading = true;
        //load team in match
        List<TeamsInMatchModel>? teamsInMatch =
            await service.getTeamsInMatch(event.match.id);
        emit(state.copyWith(
            match: event.match, teamsInMatch: teamsInMatch ?? []));
        _isLoading = false;
      }
    }));
  }
}
