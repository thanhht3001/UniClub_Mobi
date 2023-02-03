import 'package:unicec_mobi/bloc/view_list_match/view_list_match_event.dart';
import 'package:unicec_mobi/bloc/view_list_match/view_list_match_state.dart';
import 'package:unicec_mobi/models/common/paging_result.dart';

import '../../models/entities/match/match_model.dart';
import '../../services/match_svc/i_match_service.dart';
import '../../utils/base_bloc.dart';

class ViewListMatchBloc extends BaseBloc<ViewListMatchEvent, ViewListMatchState>{
  IMatchService service;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool isLoading){
    _isLoading = isLoading;
  }

  ViewListMatchBloc({required this.service}) 
    : super(ViewListMatchState(
      matches: []
    )){
      (on((event, emit) async {
        if(event is LoadMatchesByRoundEvent){
          _isLoading = true;
          PagingResult<MatchModel>? matches = await service.getMatchesByRound(event.roundId);
          emit(state.copyWith(matches: matches?.items, round: event.round ?? state.round));
          _isLoading = false;
        }
      }));
    }

}