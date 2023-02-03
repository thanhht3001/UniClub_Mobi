import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicec_mobi/models/entities/match/match_model.dart';
import 'package:unicec_mobi/models/enums/match_status.dart';
import 'package:unicec_mobi/models/enums/team_in_match_status.dart';

import '../../../bloc/view_detail_match/view_detail_match_bloc.dart';
import '../../../bloc/view_detail_match/view_detail_match_state.dart';
import '../../../constants/Theme.dart';
import '../../../models/entities/match/match_model.dart';
import '../../../models/entities/match/teams_in_match_model.dart';
import '../../../utils/loading.dart';
import '../../../utils/utils.dart';

class ViewDetailMatchMenu extends StatefulWidget {
  @override
  State<ViewDetailMatchMenu> createState() => _ViewDetailMatchMenuState();
}

// List<MatchModel> match = <MatchModel>[
//   MatchModel(
//       id: 1,
//       roundId: 1,
//       roundName: "Round 1",
//       roundTypeName: "Loại trực tiếp",
//       isLoseMatch: true,
//       address: "Sân 2, DT741, xã tân tiến, huyện Đồng Phú, tỉnh Bình Dương",
//       title: "Ttitle này để check thô icacs bạn ơi",
//       description:
//           "description này cũng để check thôi à description này cũng để check thôi à description này cũng để check thôi à",
//       createTime: DateTime.now(),
//       startTime: DateTime.now(),
//       endTime: DateTime.now(),
//       numberOfTeam: 5,
//       status: MatchStatus.Cancel),
// ];

List<TeamsInMatchModel> teamInMatch = <TeamsInMatchModel>[
  TeamsInMatchModel(
      id: 1,
      matchId: 1,
      matchTitle: "",
      teamId: 1,
      teamName: "teamName",
      scores: 30,
      status: TeamInMatchStatus.Win,
      description: "description"),
  TeamsInMatchModel(
      id: 1,
      matchId: 1,
      matchTitle: "",
      teamId: 1,
      teamName: "teamName2",
      scores: 30,
      status: TeamInMatchStatus.Win,
      description: "description"),
  TeamsInMatchModel(
      id: 1,
      matchId: 1,
      matchTitle: "",
      teamId: 1,
      teamName: "teamName",
      scores: 30,
      status: TeamInMatchStatus.Win,
      description: "description"),
  TeamsInMatchModel(
      id: 1,
      matchId: 1,
      matchTitle: "",
      teamId: 1,
      teamName: "teamName",
      scores: 30,
      status: TeamInMatchStatus.Win,
      description: "description"),
  TeamsInMatchModel(
      id: 1,
      matchId: 1,
      matchTitle: "",
      teamId: 1,
      teamName: "teamName",
      scores: 30,
      status: TeamInMatchStatus.Win,
      description: "description"),
];

List<Widget> ListTeamInMatch(List<TeamsInMatchModel>? teamInMatch) {
  List<Widget> result = [];
  if (teamInMatch != null) {
    result = teamInMatch
        .map<Widget>((e) => Container(
              margin: const EdgeInsets.only(right: 10, top: 10, bottom: 10),
              padding: const EdgeInsets.all(3.0),
              decoration: BoxDecoration(
                  border: Border.all(color: ArgonColors.success),
                  color: ArgonColors.success,
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: Text(
                e.teamName,
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
            ))
        .toList();
  }
  return result;
}

String getStatus(TeamInMatchStatus status) {
  switch (status) {
    case TeamInMatchStatus.Win:
      return 'Thắng';
    case TeamInMatchStatus.WinLoseMatch:
      return 'Thắng nhánh thua';
    case TeamInMatchStatus.Lose:
      return 'Thua';
    case TeamInMatchStatus.Draw:
      return 'Hòa';
    default:
      return 'Hủy';
  }
}

List<Widget> ListTeamInMatchResult(
    List<TeamsInMatchModel>? teamInMatchResult, int roundTypeId) {
  int count = 1;
  List<Widget> result = [];
  if (teamInMatchResult != null) {
    result = teamInMatchResult
        .map<Widget>((e) => Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
              child: Wrap(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.label,
                        size: 23,
                        color: Colors.orange,
                      ),
                      const SizedBox(width: 10.0),
                      Text("${count++}", style: const TextStyle(fontSize: 18)),
                      const SizedBox(width: 10.0),
                      Expanded(
                        child: Text(
                          e.teamName,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                      if (roundTypeId == 2) ...[
                        Container(
                          margin: const EdgeInsets.only(left: 15, right: 5),
                          padding: const EdgeInsets.symmetric(
                              vertical: 3, horizontal: 10),
                          decoration: BoxDecoration(
                              border: Border.all(color: ArgonColors.warning),
                              color: ArgonColors.warning,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                          child: Text(
                            "${e.scores} điểm",
                            style: const TextStyle(
                                fontSize: 18, color: Colors.white),
                          ),
                        )
                      ],
                      if (roundTypeId != 2) ...[
                        Container(
                          margin: const EdgeInsets.only(left: 5, right: 15),
                          padding: const EdgeInsets.symmetric(
                              vertical: 3, horizontal: 10),
                          width: 68.0,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: (e.status == TeamInMatchStatus.Lose)
                                      ? ArgonColors.warning
                                      : ArgonColors.success),
                              color: (e.status == TeamInMatchStatus.Lose)
                                  ? ArgonColors.warning
                                  : ArgonColors.success,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                          child: Text(
                            getStatus(e.status),
                            style: const TextStyle(
                                fontSize: 18, color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ],
                  ),
                ],
              ),
            ))
        .toList();
  }
  return result;
}

class _ViewDetailMatchMenuState extends State<ViewDetailMatchMenu> {
  @override
  Widget build(BuildContext context) {
    ViewDetailMatchBloc bloc = BlocProvider.of<ViewDetailMatchBloc>(context);
    return BlocBuilder<ViewDetailMatchBloc, ViewDetailMatchState>(
      bloc: bloc,
      builder: (context, state) {
        return bloc.isLoading
            ? Loading()
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                              bottom: 10, top: 20, left: 20),
                          padding: const EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.amber),
                              color: Colors.amber,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                          child: Text(
                            (state.match.status == MatchStatus.Cancel)
                                ? 'Hủy'
                                : (state.match.status == MatchStatus.Finish)
                                    ? 'Hoàn Thành'
                                    : (state.match.status ==
                                            MatchStatus.IsDeleted)
                                        ? 'Xóa'
                                        : (state.match.status ==
                                                MatchStatus.OnGoing)
                                            ? 'Đang Diễn Ra'
                                            : (state.match.status ==
                                                    MatchStatus.Ready)
                                                ? 'Chuẩn Bị'
                                                : 'Khác',
                            style: const TextStyle(
                                fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 10),
                      child: Align(
                        child: Text(state.match.title,
                            style: const TextStyle(
                                color: Color.fromRGBO(50, 50, 93, 1),
                                fontSize: 28.0)),
                      ),
                    ),
                    //MatchType
                    //-----------------------------------Các đội thi
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20.0, right: 20, top: 15),
                      child: Row(
                        children: [
                          Row(
                            children: const [
                              Text(
                                'Các đội tham gia',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 18),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.supervised_user_circle_outlined,
                            size: 23,
                            color: Colors.orange,
                          ),
                          const SizedBox(width: 10.0),
                          Expanded(
                            child: (state.teamsInMatch.isNotEmpty)
                                ? Wrap(
                                    alignment: WrapAlignment.start,
                                    direction: Axis.horizontal,
                                    children:
                                        ListTeamInMatch(state.teamsInMatch))
                                : const Text('Chưa có đội thi được thêm vào'),
                          )
                        ],
                      ),
                    ),
                    const Divider(
                      height: 30.0,
                      thickness: 1.5,
                      indent: 32.0,
                      endIndent: 32.0,
                    ),
                    //-----------------------------------Kết quả vòng đấu
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20),
                      child: Row(
                        children: [
                          Row(
                            children: const [
                              Text(
                                'Kết quả vòng đấu',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 18),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    (state.teamsInMatch.isNotEmpty)
                        ? Wrap(
                            alignment: WrapAlignment.start,
                            direction: Axis.horizontal,
                            children: ListTeamInMatchResult(
                                state.teamsInMatch, state.match.roundTypeId))
                        : const Text('Chưa có kết quả của trận thi đấu'),
                    const Divider(
                      height: 30.0,
                      thickness: 1.5,
                      indent: 32.0,
                      endIndent: 32.0,
                    ),
                    //------------------------------------Address
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20),
                      child: Row(
                        children: [
                          Row(
                            children: const [
                              Text(
                                'Địa điểm thi đấu',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 18),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 10),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 23,
                            color: Colors.orange,
                          ),
                          SizedBox(width: 10.0),
                          Expanded(
                              child: Text(
                            state.match.address,
                            style: TextStyle(fontSize: 18),
                          )),
                        ],
                      ),
                    ),
                    const Divider(
                      height: 30.0,
                      thickness: 1.5,
                      indent: 32.0,
                      endIndent: 32.0,
                    ),
                    //------------------------------------Thể thức thi đấu
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20),
                      child: Row(
                        children: [
                          Row(
                            children: const [
                              Text(
                                'Thể thức thi đấu',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 18),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 10),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.adjust_sharp,
                            size: 23,
                            color: Colors.orange,
                          ),
                          const SizedBox(width: 10.0),
                          Expanded(
                              child: Text(
                            state.match.roundTypeName,
                            style: TextStyle(fontSize: 18),
                          )),
                        ],
                      ),
                    ),
                    const Divider(
                      height: 30.0,
                      thickness: 1.5,
                      indent: 32.0,
                      endIndent: 32.0,
                    ),
                    //------------------------------------Mô tả
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20),
                      child: Row(
                        children: [
                          Row(
                            children: const [
                              Text(
                                'Mô tả',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 18),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 10),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.description,
                            size: 23,
                            color: Colors.orange,
                          ),
                          SizedBox(width: 10.0),
                          Expanded(
                              child: Text(
                            state.match.description,
                            style: TextStyle(fontSize: 18),
                          )),
                        ],
                      ),
                    ),
                    const Divider(
                      height: 30.0,
                      thickness: 1.5,
                      indent: 32.0,
                      endIndent: 32.0,
                    ),
                    //Startitme
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20),
                      child: Row(
                        children: [
                          Row(
                            children: const [
                              Text(
                                'Thời gian bắt đầu',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 18),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 10),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.calendar_today,
                            size: 23,
                            color: Colors.orange,
                          ),
                          const SizedBox(width: 10.0),
                          Expanded(
                              child: Text(
                            Utils.convertDateTime(state.match.startTime),
                            style: const TextStyle(fontSize: 18),
                          )),
                        ],
                      ),
                    ),
                    Divider(
                      height: 30.0,
                      thickness: 1.5,
                      indent: 32.0,
                      endIndent: 32.0,
                    ),
                    //Endtime
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20),
                      child: Row(
                        children: [
                          Row(
                            children: const [
                              Text(
                                'Thời gian kết thúc',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 18),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 10),
                      child: Row(
                        children: [
                          Icon(
                            Icons.calendar_today_outlined,
                            size: 23,
                            color: Colors.orange,
                          ),
                          SizedBox(width: 10.0),
                          Expanded(
                              child: Text(
                            Utils.convertDateTime(state.match.endTime),
                            style: TextStyle(fontSize: 18),
                          )),
                        ],
                      ),
                    ),
                    Divider(
                      height: 30.0,
                      thickness: 1.5,
                      indent: 32.0,
                      endIndent: 32.0,
                    ),
                  ],
                ),
              );
      },
    );

    //   },
    //}
    //);
  }
}
