import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicec_mobi/bloc/view_list_match/view_list_match_bloc.dart';
import 'package:unicec_mobi/constants/Theme.dart';

import '../../../bloc/view_list_match/view_list_match_state.dart';
import '../../../models/enums/competition_round_status.dart';

import '../../../models/enums/match_status.dart';
import '../../../utils/app_color.dart';
import '../../../utils/loading.dart';
import '../../../utils/router.dart';
import '../../../utils/utils.dart';

class ListMatchMenu extends StatefulWidget {
  // const ListMatchMenu({
  //   Key? key,
  // }) : super(key: key);

  @override
  State<ListMatchMenu> createState() => _ListMatchMenuState();
}

class _ListMatchMenuState extends State<ListMatchMenu> {
  String getStatus(MatchStatus status) {
    switch (status) {
      case MatchStatus.Ready:
        return 'Chuẩn bị';
      case MatchStatus.OnGoing:
        return 'Đang diễn ra';
      case MatchStatus.Finish:
        return 'Hoàn thành';
      default:
        return 'Hủy';
    }
  }

  @override
  Widget build(BuildContext context) {
    ViewListMatchBloc bloc = BlocProvider.of<ViewListMatchBloc>(context);

    return BlocBuilder<ViewListMatchBloc, ViewListMatchState>(
        bloc: bloc,
        builder: (context, state) {
          return (bloc.isLoading)
              ? Loading()
              : Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      alignment: Alignment.bottomRight,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            FlatButton(
                              textColor: ArgonColors.white,
                              color: AppColors.mainColor,
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Container(
                                        child: AlertDialog(
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10.0))),
                                          scrollable: true,
                                          title: Container(
                                              child: const Text(
                                            'Chi tiết',
                                            style: TextStyle(fontSize: 20),
                                            textAlign: TextAlign.center,
                                          )),
                                          content: Padding(
                                            padding: const EdgeInsets.only(
                                              top: 8,
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Wrap(
                                                  children: [
                                                    const Text(
                                                      "Tên:",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8.0),
                                                      child: Text(
                                                        bloc.state.round
                                                                ?.title ??
                                                            "",
                                                        style: const TextStyle(
                                                            fontSize: 18),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8.0, bottom: 8),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const Text(
                                                        "Thời gian bắt đầu:",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Container(
                                                        margin: const EdgeInsets
                                                                .only(
                                                            top: 8.0,
                                                            bottom: 8,
                                                            left: 8),
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 3.0),
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: Colors
                                                                    .orangeAccent),
                                                            color: Colors
                                                                .orangeAccent,
                                                            borderRadius:
                                                                const BorderRadius
                                                                        .all(
                                                                    Radius.circular(
                                                                        10))),
                                                        child: Text(
                                                            (bloc.state.round
                                                                        ?.startTime !=
                                                                    null)
                                                                ? Utils.formatDateTime(
                                                                    (bloc
                                                                        .state
                                                                        .round
                                                                        ?.startTime)!)
                                                                : "",
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 18,
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 8),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const Text(
                                                        "Thời gian kết thúc:",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Container(
                                                        margin: const EdgeInsets
                                                                .only(
                                                            top: 8.0,
                                                            bottom: 8,
                                                            left: 8),
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 3.0),
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: Colors
                                                                    .orangeAccent),
                                                            color: Colors
                                                                .orangeAccent,
                                                            borderRadius:
                                                                const BorderRadius
                                                                        .all(
                                                                    Radius.circular(
                                                                        10))),
                                                        child: Text(
                                                            (bloc.state.round
                                                                        ?.endTime !=
                                                                    null)
                                                                ? Utils.formatDateTime(
                                                                    (bloc
                                                                        .state
                                                                        .round
                                                                        ?.endTime)!)
                                                                : "",
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 18,
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 8),
                                                  child: Wrap(
                                                    children: [
                                                      const Text(
                                                        "Nội dung:",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 8.0),
                                                        child: Text(
                                                          bloc.state.round
                                                                  ?.description ??
                                                              "",
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 18),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                // Padding(
                                                //   padding: const EdgeInsets.only(
                                                //       top: 8.0, bottom: 8),
                                                //   child: Wrap(
                                                //     children: [
                                                //       const Text(
                                                //         "Điểm:",
                                                //         style: TextStyle(
                                                //             fontWeight: FontWeight.bold),
                                                //       ),
                                                //       Padding(
                                                //         padding:
                                                //             const EdgeInsets.only(left: 8.0),
                                                //         child: Text(
                                                //             _competitionRounds[index]
                                                //                 .seedsPoint
                                                //                 .toString(),
                                                //             style: const TextStyle(
                                                //                 fontSize: 18)),
                                                //       ),
                                                //     ],
                                                //   ),
                                                // ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 8, top: 8),
                                                  child: Row(
                                                    children: [
                                                      const Text(
                                                        "Trạng thái:",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 8.0),
                                                          child: Row(
                                                            children: [
                                                              if (bloc
                                                                          .state
                                                                          .round
                                                                          ?.status !=
                                                                      null &&
                                                                  (bloc
                                                                          .state
                                                                          .round
                                                                          ?.status) ==
                                                                      CompetitionRoundStatus
                                                                          .Active)
                                                                Container(
                                                                  margin:
                                                                      const EdgeInsets
                                                                          .only(
                                                                    top: 8.0,
                                                                    bottom: 8,
                                                                    left: 8,
                                                                  ),
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          5.0),
                                                                  decoration: BoxDecoration(
                                                                      border: Border.all(
                                                                          color: Colors
                                                                              .green),
                                                                      color: Colors
                                                                          .green,
                                                                      borderRadius: const BorderRadius
                                                                              .all(
                                                                          Radius.circular(
                                                                              10))),
                                                                  child: const Text(
                                                                      "Sắp diên ra",
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            18,
                                                                      )),
                                                                )
                                                              else if (bloc
                                                                          .state
                                                                          .round
                                                                          ?.status !=
                                                                      null &&
                                                                  (bloc
                                                                          .state
                                                                          .round
                                                                          ?.status) ==
                                                                      CompetitionRoundStatus
                                                                          .Cancel)
                                                                Container(
                                                                  margin: const EdgeInsets
                                                                          .only(
                                                                      top: 8.0,
                                                                      bottom: 8,
                                                                      left: 8),
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          5.0),
                                                                  decoration: BoxDecoration(
                                                                      border: Border.all(
                                                                          color: Colors
                                                                              .red),
                                                                      color: Colors
                                                                          .red,
                                                                      borderRadius: const BorderRadius
                                                                              .all(
                                                                          Radius.circular(
                                                                              10))),
                                                                  child: const Text(
                                                                      "Đã hủy",
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            18,
                                                                      )),
                                                                )
                                                              else if (bloc
                                                                          .state
                                                                          .round
                                                                          ?.status !=
                                                                      null &&
                                                                  (bloc
                                                                          .state
                                                                          .round
                                                                          ?.status) ==
                                                                      CompetitionRoundStatus
                                                                          .Happening)
                                                                Container(
                                                                  margin: const EdgeInsets
                                                                          .only(
                                                                      top: 8.0,
                                                                      bottom: 8,
                                                                      left: 8),
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          5.0),
                                                                  decoration: BoxDecoration(
                                                                      border: Border.all(
                                                                          color: Colors
                                                                              .yellowAccent),
                                                                      color: Colors
                                                                          .yellowAccent,
                                                                      borderRadius: const BorderRadius
                                                                              .all(
                                                                          Radius.circular(
                                                                              10))),
                                                                  child: const Text(
                                                                      "Đang diễn ra",
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            18,
                                                                      )),
                                                                )
                                                              else if (bloc
                                                                          .state
                                                                          .round
                                                                          ?.status !=
                                                                      null &&
                                                                  (bloc
                                                                          .state
                                                                          .round
                                                                          ?.status) ==
                                                                      CompetitionRoundStatus
                                                                          .Finished)
                                                                Container(
                                                                  margin: const EdgeInsets
                                                                          .only(
                                                                      top: 8.0,
                                                                      bottom: 8,
                                                                      left: 8),
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          5.0),
                                                                  decoration: BoxDecoration(
                                                                      border: Border.all(
                                                                          color: Colors
                                                                              .grey),
                                                                      color: Colors
                                                                          .grey,
                                                                      borderRadius: const BorderRadius
                                                                              .all(
                                                                          Radius.circular(
                                                                              10))),
                                                                  child: const Text(
                                                                      "Kết thúc",
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            18,
                                                                      )),
                                                                )
                                                            ],
                                                          )),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          actions: [
                                            Container(
                                              width: double.infinity,
                                              margin: const EdgeInsets.only(
                                                  right: 15,
                                                  left: 15,
                                                  bottom: 15),
                                              child: (bloc.state.round
                                                              ?.status !=
                                                          null &&
                                                      (bloc.state.round
                                                              ?.status) ==
                                                          CompetitionRoundStatus
                                                              .Finished)
                                                  ? FlatButton(
                                                      textColor:
                                                          ArgonColors.white,
                                                      color:
                                                          AppColors.mainColor,
                                                      onPressed: () {
                                                        Navigator.pushNamed(
                                                            context,
                                                            Routes
                                                                .viewCompetitionRoundResult,
                                                            arguments: {
                                                              'competitionRoundId':
                                                                  bloc.state
                                                                      .round?.id
                                                            });
                                                      },
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0),
                                                      ),
                                                      child: const Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 16.0,
                                                                  right: 16.0,
                                                                  top: 12,
                                                                  bottom: 12),
                                                          child: Text(
                                                              "Kết quả vòng thi",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize:
                                                                      18.0))),
                                                    )
                                                  : FlatButton(
                                                      textColor:
                                                          ArgonColors.white,
                                                      color:
                                                          AppColors.mainColor,
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0),
                                                      ),
                                                      child: const Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 16.0,
                                                                  right: 16.0,
                                                                  top: 12,
                                                                  bottom: 12),
                                                          child: Text("Đóng",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize:
                                                                      18.0))),
                                                    ),
                                            ),
                                          ],
                                        ),
                                      );
                                    });
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              child: const Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text("Chi tiết vòng thi",
                                      style: TextStyle(fontSize: 18.0))),
                            ),
                            FlatButton(
                              textColor: ArgonColors.white,
                              color: AppColors.mainColor,
                              onPressed: () {
                                // navigator to view_list_team_each_round
                                Navigator.of(context).pushNamed(
                                    Routes.viewListTeamEachRound,
                                    arguments: state.round!.id);
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              child: const Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text("DS các đội thi",
                                      style: TextStyle(fontSize: 18.0))),
                            ),
                          ]),
                    ),
                    (bloc.state.matches != null)
                        ? ListView.builder(
                            itemCount: state.matches?.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 20),
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    primary: Colors.black87,
                                    padding: const EdgeInsets.all(20),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    backgroundColor: const Color.fromARGB(
                                        255, 235, 237, 241),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pushNamed(
                                        Routes.viewDetailMatch,
                                        arguments: state.matches?[index]);
                                  },
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 20.0, left: 10),
                                        child: Text("${index + 1}",
                                            style:
                                                const TextStyle(fontSize: 18)),
                                      ),
                                      Expanded(
                                        child: Text(
                                          "${state.matches?[index].title}",
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.normal,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 0),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Text(
                                                    (state.matches?[index]
                                                                .status !=
                                                            null)
                                                        ? getStatus((state
                                                            .matches?[index]
                                                            .status)!)
                                                        : '',
                                                    style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color: ArgonColors
                                                            .warning),
                                                    textAlign:
                                                        TextAlign.center),
                                              ]),
                                        ),
                                      ),
                                      const Icon(
                                        Icons.arrow_forward_ios,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          )
                        : Padding(
                            padding: const EdgeInsets.only(top: 180.0),
                            child: Column(
                              children: [
                                Container(
                                    decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            alignment: Alignment.topCenter,
                                            image: AssetImage(
                                                "assets/img/not-found-icon-24.jpg"),
                                            fit: BoxFit.fitWidth))),
                                Image.asset("assets/img/not-found-icon-24.jpg"),
                                const Padding(
                                  padding: EdgeInsets.only(top: 25.0),
                                  child: Text(
                                    'Không có trận đấu nào trong vòng thi',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ],
                );
        });
    // return BlocBuilder<ViewCompetitionMemberTaskBloc,
    //     ViewCompetitionMemberTaskState>(
    //     bloc: bloc,
    //     builder: (context, state) {
    //       return (GetIt.I.get<CurrentUser>().clubIdSelected == 0)
    //           ? Padding(
    //         padding: const EdgeInsets.only(top: 180.0),
    //         child: Column(
    //           children: [
    //             Container(
    //                 decoration: const BoxDecoration(
    //                     image: DecorationImage(
    //                         alignment: Alignment.topCenter,
    //                         image: AssetImage(
    //                             "assets/img/not-found-icon-24.jpg"),
    //                         fit: BoxFit.fitWidth))),
    //             Image.asset("assets/img/not-found-icon-24.jpg"),
    //             const Padding(
    //               padding: EdgeInsets.only(top: 25.0),
    //               child: Text(
    //                 'Mời bạn chọn CLB để hiển thị danh sách công việc',
    //                 style: TextStyle(fontSize: 20),
    //                 textAlign: TextAlign.center,
    //               ),
    //             ),
    //           ],
    //         ),
    //       )
    //           : Container(
    //         child: Column(
    //           children: [
    //             (state.isLoading &&
    //                 (state.listCompetition.isEmpty ||
    //                     state.listCompetition.isNotEmpty))
    //                 ? Loading()
    //                 : (state.listCompetition.isNotEmpty)
    //                 ? RefreshIndicator(
    //               onRefresh: () {
    //                 return _refresh(context);
    //               },
    //               child: ListView.builder(
    //                 shrinkWrap: true,
    //                 itemCount: state.listCompetition.length,
    //                 itemBuilder: (context, index) {
    //
    //                 },
    //               ),
    //             )
    //                 : Expanded(
    //               // Padding
    //               // padding: EdgeInsets.only(top: (MediaQuery.of(context).size.height - 500) / 2),
    //               child: Column(
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 children: [
    //                   Container(
    //                       decoration: const BoxDecoration(
    //                           image: DecorationImage(
    //                               alignment:
    //                               Alignment.topCenter,
    //                               image: AssetImage(
    //                                   "assets/img/not-found-icon-24.jpg"),
    //                               fit: BoxFit.fitWidth))),
    //                   Image.asset(
    //                       "assets/img/not-found-icon-24.jpg"),
    //                   const Padding(
    //                     padding: EdgeInsets.only(top: 25.0),
    //                     child: Text(
    //                       'Hiện tại bạn không có hoạt động nào!',
    //                       style: TextStyle(fontSize: 20),
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             )
    //           ],
    //         ),
    //       );
    //     });
  }

// Future<bool> _loadMore(BuildContext context) async {
//   print("onLoadMore");
//   await Future.delayed(Duration(seconds: 0, milliseconds: 5000));
//   BlocProvider.of<ViewCompetitionMemberTaskBloc>(context)
//       .add(IncrementalEvent());
//   //lúc này stateModel cũng có r nhưng mà chưa có hàm render lại cái view
//   //phải đưa cái hàm này vào trong để add event và có state
//   load(context);
//   return true;
// }

// Future<bool> _refresh(BuildContext context) async {
//   print("onRefresh");
//   BlocProvider.of<ViewCompetitionMemberTaskBloc>(context).add(RefreshEvent());
//   await Future.delayed(Duration(seconds: 0, milliseconds: 5000));
//   refresh(context);
//   return true;
// }
}
