import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicec_mobi/bloc/view_result_team/view_result_team_bloc.dart';

import '../../../bloc/view_result_team/view_result_team_event.dart';
import '../../../bloc/view_result_team/view_result_team_state.dart';
import '../../../constants/Theme.dart';
import '../../../models/entities/match/teams_in_match_model.dart';
import '../../../models/enums/team_in_match_status.dart';
import '../../../utils/loading.dart';

class ViewResultTeamMenu extends StatefulWidget {
  @override
  State<ViewResultTeamMenu> createState() => _ViewResultTeamMenuState();
}

List<TeamsInMatchModel> teamInMatch = <TeamsInMatchModel>[
  TeamsInMatchModel(
      id: 1,
      matchId: 1,
      matchTitle: "Match này xem cho vui",
      teamId: 1,
      teamName:
          "teamName teamName teamName teamName teamName teamName teamName ",
      scores: 30,
      status: TeamInMatchStatus.Win,
      description: "description"),
  TeamsInMatchModel(
      id: 1,
      matchId: 2,
      matchTitle: "Match này xem cho vui",
      teamId: 1,
      teamName: "teamName",
      scores: 30,
      status: TeamInMatchStatus.Win,
      description: "description"),
  TeamsInMatchModel(
      id: 1,
      matchId: 4,
      matchTitle: "Match này xem cho vui",
      teamId: 1,
      teamName: "teamName",
      scores: 30,
      status: TeamInMatchStatus.Win,
      description: "description"),
  TeamsInMatchModel(
      id: 1,
      matchId: 3,
      matchTitle: "Match này xem cho vui",
      teamId: 1,
      teamName: "teamName",
      scores: 30,
      status: TeamInMatchStatus.Win,
      description: "description"),
  TeamsInMatchModel(
      id: 1,
      matchId: 1,
      matchTitle: "Match này xem cho vui",
      teamId: 1,
      teamName: "teamName",
      scores: 30,
      status: TeamInMatchStatus.Win,
      description: "description"),
  TeamsInMatchModel(
      id: 1,
      matchId: 1,
      matchTitle: "Match này xem cho vui",
      teamId: 1,
      teamName: "teamName",
      scores: 30,
      status: TeamInMatchStatus.Lose,
      description: "description"),
  TeamsInMatchModel(
      id: 1,
      matchId: 1,
      matchTitle: "Match này xem cho vui",
      teamId: 1,
      teamName: "teamName",
      scores: 30,
      status: TeamInMatchStatus.Win,
      description: "description"),
  TeamsInMatchModel(
      id: 1,
      matchId: 1,
      matchTitle: "Match này xem cho vui",
      teamId: 1,
      teamName: "teamName",
      scores: 30,
      status: TeamInMatchStatus.Win,
      description: "description"),
  TeamsInMatchModel(
      id: 1,
      matchId: 3,
      matchTitle: "Match này xem cho vui",
      teamId: 1,
      teamName: "teamName",
      scores: 30,
      status: TeamInMatchStatus.Win,
      description: "description"),
  TeamsInMatchModel(
      id: 1,
      matchId: 3,
      matchTitle: "Match này xem cho vui",
      teamId: 1,
      teamName: "teamName",
      scores: 30,
      status: TeamInMatchStatus.Win,
      description: "description"),
  TeamsInMatchModel(
      id: 1,
      matchId: 3,
      matchTitle: "Match này xem cho vui",
      teamId: 1,
      teamName: "teamName",
      scores: 30,
      status: TeamInMatchStatus.Win,
      description: "description"),
];

class _ViewResultTeamMenuState extends State<ViewResultTeamMenu> {
  @override
  Widget build(BuildContext context) {
    ViewResultTeamBloc _bloc = BlocProvider.of<ViewResultTeamBloc>(context);

    return BlocBuilder<ViewResultTeamBloc, ViewResultTeamState>(
        bloc: _bloc,
        builder: (context, state) {
          return (_bloc.IsLoading)
              ? Loading()
              : (_bloc.state.resultTeamInCompetition?.teamInRounds.isNotEmpty)!
                  ? SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: ArgonColors.success),
                                      color: ArgonColors.success,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Text(
                                    "Xếp hạng: ${_bloc.state.resultTeamInCompetition?.teamInRounds.last.rank}",
                                    style: const TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 32),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: ArgonColors.success),
                                      color: ArgonColors.success,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Text(
                                    "${_bloc.state.resultTeamInCompetition?.teamInRounds.last.scores} điểm",
                                    style: const TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: _bloc.state.resultTeamInCompetition
                                ?.teamInRounds.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, top: 10),
                                child: Column(children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          "${_bloc.state.resultTeamInCompetition?.teamInRounds[index].roundName} - ${_bloc.state.resultTeamInCompetition?.teamInRounds[index].roundTypeName}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: ArgonColors.warning,
                                              fontSize: 18),
                                        ),
                                      ],
                                    ),
                                  ),
                                  ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: _bloc
                                          .state
                                          .resultTeamInCompetition
                                          ?.teamInRounds[index]
                                          .teamInMatches
                                          .length,
                                      itemBuilder: (context, matchIndex) {
                                        return Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            TextButton(
                                              onPressed: () {
                                                // navigator to match detail
                                                int matchId = _bloc
                                                        .state
                                                        .resultTeamInCompetition
                                                        ?.teamInRounds[index]
                                                        .teamInMatches[
                                                            matchIndex]
                                                        .matchId ??
                                                    0;
                                                _bloc.IsLoading = true;
                                                _bloc.add(LoadMatchDetailEvent(
                                                    matchId: matchId));
                                              },
                                              child: Row(
                                                children: [
                                                  const Icon(
                                                    Icons.label,
                                                    size: 23,
                                                    color: Colors.orange,
                                                  ),
                                                  const SizedBox(width: 10.0),
                                                  Expanded(
                                                    child: Text(
                                                      "${_bloc.state.resultTeamInCompetition?.teamInRounds[index].teamInMatches[matchIndex].matchTitle}",
                                                      style: const TextStyle(
                                                          fontSize: 18,
                                                          color:
                                                              Colors.black87),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 30.0),
                                                  if (_bloc
                                                              .state
                                                              .resultTeamInCompetition
                                                              ?.teamInRounds[
                                                                  index]
                                                              .teamInMatches[
                                                                  matchIndex]
                                                              .status ==
                                                          TeamInMatchStatus
                                                              .Win ||
                                                      _bloc
                                                              .state
                                                              .resultTeamInCompetition
                                                              ?.teamInRounds[
                                                                  index]
                                                              .teamInMatches[
                                                                  matchIndex]
                                                              .status ==
                                                          TeamInMatchStatus
                                                              .WinLoseMatch)
                                                    const Expanded(
                                                      child: Text(
                                                        "Thắng",
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color: ArgonColors
                                                                .success),
                                                      ),
                                                    ),
                                                  if (_bloc
                                                          .state
                                                          .resultTeamInCompetition
                                                          ?.teamInRounds[index]
                                                          .teamInMatches[
                                                              matchIndex]
                                                          .status ==
                                                      TeamInMatchStatus.Lose)
                                                    const Expanded(
                                                      child: Text(
                                                        "Thua",
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color: ArgonColors
                                                                .warning),
                                                      ),
                                                    ),
                                                  if (_bloc
                                                          .state
                                                          .resultTeamInCompetition
                                                          ?.teamInRounds[index]
                                                          .teamInMatches[
                                                              matchIndex]
                                                          .status ==
                                                      TeamInMatchStatus.Draw)
                                                    const Expanded(
                                                      child: Text(
                                                        "Hòa",
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color: ArgonColors
                                                                .info),
                                                      ),
                                                    ),
                                                  if (_bloc
                                                          .state
                                                          .resultTeamInCompetition
                                                          ?.teamInRounds[index]
                                                          .teamInMatches[
                                                              matchIndex]
                                                          .status ==
                                                      TeamInMatchStatus.Cancel)
                                                    const Expanded(
                                                      child: Text(
                                                        "Hủy",
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color: ArgonColors
                                                                .muted),
                                                      ),
                                                    ),
                                                  Container(
                                                    alignment:
                                                        Alignment.topRight,
                                                    margin: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 15),
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 3,
                                                        horizontal: 10),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: ArgonColors
                                                                .warning),
                                                        color:
                                                            ArgonColors.warning,
                                                        borderRadius:
                                                            const BorderRadius
                                                                    .all(
                                                                Radius.circular(
                                                                    10))),
                                                    child: Text(
                                                      "${_bloc.state.resultTeamInCompetition?.teamInRounds[index].teamInMatches[matchIndex].scores} điểm",
                                                      style: const TextStyle(
                                                          fontSize: 18,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const Divider(
                                              height: 20.0,
                                              thickness: 1.5,
                                              indent: 32.0,
                                              endIndent: 15.0,
                                            ),
                                          ],
                                        );
                                      }),
                                ]),
                              );
                            },
                          ),
                        ],
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(top: 180.0),
                      child: Column(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      alignment: Alignment.topCenter,
                                      image: AssetImage(
                                          "assets/img/not-found-icon-24.jpg"),
                                      fit: BoxFit.fitWidth))),
                          Image.asset("assets/img/not-found-icon-24.jpg"),
                          Padding(
                            padding: const EdgeInsets.only(top: 25.0),
                            child: Text(
                              'Không có kết quả',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                    );
        });
    //);
  }
}
