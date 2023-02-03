import 'package:equatable/equatable.dart';
// import 'package:unicec_mobi/models/entities/competition/competition_model.dart';

import '../../models/entities/competition/competition_show_model.dart';

class EventState extends Equatable {
  List<CompetitionShowModel>? outStandingEvents;
  List<CompetitionShowModel>? events;

  EventState(
      {this.events, this.outStandingEvents});

  EventState copyWith(
      {List<CompetitionShowModel>? events, List<CompetitionShowModel>? outStandingEvents}) {
    return EventState(events: events, outStandingEvents: outStandingEvents);
  }
  @override
  // TODO: implement props
  List<Object?> get props => [events, outStandingEvents];
}
