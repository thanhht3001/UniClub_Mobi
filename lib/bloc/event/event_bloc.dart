import 'package:unicec_mobi/bloc/competition/competition_event.dart';
import 'package:unicec_mobi/models/common/paging_result.dart';
import 'package:unicec_mobi/models/entities/competition/competition_request_model.dart';
import 'package:unicec_mobi/models/enums/competition_status.dart';
import 'package:unicec_mobi/services/i_services.dart';
import 'package:unicec_mobi/utils/base_bloc.dart';

import '../../models/common/paging_result.dart';
import '../../models/entities/competition/competition_show_model.dart';
import 'event_event.dart';
import 'event_state.dart';

// import '../../models/entities/competition/competition_in_majors_model.dart';

class EventBloc extends BaseBloc<EventEvent, EventState> {
  final ICompetitionService service;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  EventBloc({required this.service})
      : super(EventState(
            events: <CompetitionShowModel>[],
            outStandingEvents: <CompetitionShowModel>[])) {
    on((event, emit) async {
      if (event is LoadOutStandingEvent) {
        print('LoadOutStandingEvent is running ...');
        _isLoading = true;
        List<int> statuses = [];
        statuses.add(CompetitionStatus.Publish.index);
        statuses
            .add(CompetitionStatus.Approve.index); // maybe will delete later
        CompetitionRequestModel request = CompetitionRequestModel(
            viewMost: true, statuses: statuses); // add more params if you want
        PagingResult<CompetitionShowModel>? result =
            await service.showCompetition(request, 1);
        emit(state.copyWith(outStandingEvents: result?.items));
        _isLoading = false;
      }

      if (event is LoadEvent) {
        print('LoadEvent is running ...');
        _isLoading = true;
        List<int> statuses = [];
        statuses.add(CompetitionStatus.Publish.index);
        statuses
            .add(CompetitionStatus.Approve.index); // maybe will delete later
        CompetitionRequestModel request = CompetitionRequestModel(
            statuses: statuses); // add more params if you want
        PagingResult<CompetitionShowModel>? result =
            await service.showCompetition(request, 1);
        emit(state.copyWith(events: result?.items));
        _isLoading = false;
      }
    });
  }
}
