import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class Routes {
  static String get defaultRoute => '/';
  static String get main => '/main';
  static String get test => '/test';
  static String get competition => '/competition';
  static String get notification => '/notification';
  static String get event => '/event';
  static String get detailCompetition => '/detailCompetition';
  static String get viewDetailCompetitionParticipant =>
      '/viewDetailCompetitionParticipant';
  static String get viewListTeamParticipant => '/viewListTeamParticipant';
  static String get viewDetailTeamParticipant => '/viewDetailTeamParticipant';
  static String get viewListTeamStudent => '/viewListTeamStudent';
  static String get viewDetailTeamStudent => '/viewDetailTeamStudent';

  static String get viewCompetitionRound => '/viewCompetitionRound';
  static String get viewCompetitionRoundResult =>
      '/view-competition-round-result';

  static String get viewListMatch => '/view-list-match';
  static String get viewDetailMatch => '/view-detail-match';

  static String get viewCompetitionMemberTask => '/viewCompetitionMemberTask';
  static String get viewListActivity => '/viewListActivity';
  static String get viewDetailActivity => '/viewDetailActivity';

  static String get viewListMember => '/viewListmember';

  static String get viewListCompetitionOfClub => '/viewListCompetitionOfClub';
  static String get viewListCompetitionOfParticipant =>
      '/viewListCompetitionOfParticipant';
  //
  static String get splash => '/splash';
  static String get club => '/club';
  static String get clubSelection => '/clubSelection';
  static String get clubsView => '/clubsView';
  static String get profile => '/profile';
  static String get myAccount => '/profile/my-account';
  static String get editMyAccount => '/editMyAccount';
  static String get universitySelection => '/universitySelection';
  static String get login => '/login';
  static String get task => '/task';
  static String get clubViewDetail => '/clubViewDetail';
  static String get viewListTeamEachRound => '/viewListTeamEachRound';
  static String get viewResultTeam => '/view-result-team';

  static MaterialPageRoute? getRoute(RouteSettings settings) {
    Widget widget;

    try {
      widget = GetIt.I.get<Widget>(instanceName: settings.name);
    } catch (e) {
      print(e.toString());
      widget = Scaffold(
        appBar: AppBar(),
        body: const Center(
          child: Text('Page not found nè'),
        ),
      );
      return null;
    }
    return MaterialPageRoute(builder: (_) => widget, settings: settings);
  }
}
