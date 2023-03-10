import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:unicec_mobi/models/entities/team/team_in_competition_request_model.dart';
import '../../bloc/view_detail_team_participant/view_detail_team_participant_bloc.dart';
import '../../bloc/view_detail_team_participant/view_detail_team_participant_event.dart';
import '../../bloc/view_detail_team_participant/view_detail_team_participant_state.dart';
import '../../constants/Theme.dart';
import '../../models/common/current_user.dart';
import '../../models/entities/team/sending_data_model.dart';
import '../../models/enums/team_status.dart';
import '../../utils/app_color.dart';
import '../../utils/loading.dart';
import '../../utils/router.dart';
import 'component/view_detail_table.dart';

class ViewDetailTeamParticipantPage extends StatefulWidget {
  //bloc
  final ViewDetailTeamParticipantBloc bloc;
  ViewDetailTeamParticipantPage({required this.bloc});
  @override
  State<StatefulWidget> createState() => _ViewDetailTeamParticipantPageState();
}

class _ViewDetailTeamParticipantPageState
    extends State<ViewDetailTeamParticipantPage>
    with AutomaticKeepAliveClientMixin {
  //bloc
  ViewDetailTeamParticipantBloc get bloc => widget.bloc;
  //
  final _formKeyTeamDetailName = GlobalKey<FormState>();

  final _formKeyTeamDetailDescription = GlobalKey<FormState>();

  var _controllerTeamDetailName = TextEditingController();

  var _controllerTeamDetailDescription = TextEditingController();

  //
  int max = 0;
  int min = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    bloc.listenerStream.listen((event) async {
      if (event is BackPreviousPageEvent) {
        Navigator.of(context).pop(true);
      } else if (event is NavigatorToAccountPageEvent) {
        bool returnData = await Navigator.of(context)
            .pushNamed(Routes.myAccount, arguments: event.userId) as bool;
        if (returnData) {
          bloc.add(LoadingEvent());
          // d??ng ????? loading khi t??? MyAccount -> v??? l???i ????y
          bloc.add(LoadDataEvent());
        }
      } else if (event is ShowingSnackBarEvent) {
        if (event.message.contains("th??nh c??ng")) {
          AwesomeDialog(
            context: context,
            animType: AnimType.LEFTSLIDE,
            headerAnimationLoop: false,
            dialogType: DialogType.SUCCES,
            showCloseIcon: true,
            title: 'Th??nh C??ng',
            desc: event.message,
            btnOkOnPress: () {
              Navigator.of(context).pop;
            },
            btnOkIcon: Icons.check_circle,
            onDissmissCallback: (type) {
              debugPrint('Dialog Dissmiss from callback $type');
            },
          ).show();
        } else {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.ERROR,
            animType: AnimType.RIGHSLIDE,
            headerAnimationLoop: true,
            title: 'Th???t b???i',
            desc: (event.message.contains("b???o tr??"))
                ? "Th???t b???i, hi???n t???i Cu???c Thi & S??? Ki???n ??ang b???o tr??"
                : (event.message.contains("qua th???i gian t???o"))
                    ? "Th???t b???i, hi???n t???i ???? qu?? th???i gian cho ph??p th???c hi???n h??nh ?????ng"
                    : (event.message
                            .contains("Can't out team because team is locked"))
                        ? "Tho??t kh???i ?????i Th???t b???i, hi???n t???i ?????i Thi c???a b???n ??? tr???ng th??i ????ng"
                        : (event.message.contains("Team Is Locked you delete"))
                            ? "X??a ?????i Th???t b???i, hi???n t???i ?????i Thi c???a b???n ??? tr???ng th??i ????ng"
                            : (event.message
                                    .contains("Number of member in team is "))
                                ? "Th???t b???i, hi???n t???i s??? l?????ng th??nh vi??n trong ?????i Thi c???a b???n kh??ng th???a quy ?????nh c???a Cu???c Thi," +
                                    ((max != min)
                                        ? " ch??? cho ph??p s??? l?????ng th??nh vi??n trong kho???ng t??? ${min} cho t???i ${max}"
                                        : " s??? l?????ng th??nh vi??n b???ng ${max}")
                                : event.message,
            btnOkOnPress: () {
              Navigator.of(context).pop;
            },
            btnOkIcon: Icons.cancel,
            btnOkColor: Colors.red,
          ).show();
        }
        // ScaffoldMessenger.of(context)
        //     .showSnackBar(SnackBar(content: Text(event.message)));
      }
    });
  }

  //nh???n competition Id
  void didChangeDependencies() {
    RouteSettings settings = ModalRoute.of(context)!.settings;
    if (settings.arguments != null) {
      SendingDataModel data = settings.arguments as SendingDataModel;
      if (data != null) {
        bloc.add(ReceiveDataEvent(
            teamId: data.teamId,
            competitionId: data.competitionId,
            max: data.max,
            min: data.min));
        max = data.max ?? 0;
        min = data.min ?? 0;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: BlocBuilder<ViewDetailTeamParticipantBloc,
          ViewDetailTeamParticipantState>(
        bloc: bloc,
        builder: (context, state) {
          return Scaffold(
              floatingActionButton: (state.userIdIsLeaderTeam ==
                      GetIt.I.get<CurrentUser>().id)
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: FloatingActionButton(
                        heroTag: "Ch???nh s???a th??ng tin ?????i",
                        backgroundColor: ArgonColors.warning,
                        onPressed: () async {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  scrollable: true,
                                  title: Container(
                                      child: Text(
                                    'Chi??nh s????a',
                                    style: TextStyle(fontSize: 20),
                                    textAlign: TextAlign.center,
                                  )),
                                  content: Padding(
                                    padding: const EdgeInsets.only(
                                      top: 8,
                                    ),
                                    child: Column(children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10.0),
                                        child: Row(
                                          children: [
                                            Text('T??n ?????i'),
                                          ],
                                        ),
                                      ),
                                      Form(
                                        key: _formKeyTeamDetailName,
                                        child: TextFormField(
                                            initialValue: state.valueTeamName,
                                            decoration: InputDecoration(
                                              prefixIcon: Icon(Icons.label),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                            ),
                                            //maxLength: 50,
                                            minLines: 1,
                                            maxLines: 3,
                                            validator: (value) {
                                              //
                                              //value = value!.trim();
                                              //
                                              if (value!.trim().length < 5) {
                                                return 'Nh???p ??t nh???t 5 k?? t???';
                                              }
                                              return null;
                                            },
                                            onChanged: (value) {
                                              if (_formKeyTeamDetailName
                                                  .currentState!
                                                  .validate()) {
                                                bloc.add(
                                                    ChangeTeamNameValueEvent(
                                                        newNameValue:
                                                            value.trim()));
                                              }
                                            }),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10.0),
                                        child: Row(
                                          children: [
                                            Text('Mi??u t???'),
                                          ],
                                        ),
                                      ),
                                      Form(
                                        key: _formKeyTeamDetailDescription,
                                        child: TextFormField(
                                            initialValue: state
                                                .valueTeamDescription
                                                .trim(),
                                            decoration: InputDecoration(
                                              prefixIcon:
                                                  Icon(Icons.description),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                            ),
                                            //maxLength: 100,
                                            minLines: 1,
                                            maxLines: 5,
                                            validator: (value) {
                                              //
                                              //value = value!.trim();
                                              if (value!.trim().length < 5) {
                                                return 'Nh???p ??t nh???t 5 k?? t???';
                                              }
                                              return null;
                                            },
                                            onChanged: (value) {
                                              if (_formKeyTeamDetailDescription
                                                  .currentState!
                                                  .validate()) {
                                                bloc.add(
                                                    ChangeTeamDescriptionValueEvent(
                                                        newDescriptionValue:
                                                            value.trim()));
                                              }
                                            }),
                                      )
                                    ]),
                                  ),
                                  actions: [
                                    Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: Center(
                                        child: FlatButton(
                                          textColor: ArgonColors.white,
                                          color: ArgonColors.warning,
                                          onPressed: () {
                                            if (_formKeyTeamDetailDescription
                                                .currentState!
                                                .validate()) {
                                              if (_formKeyTeamDetailName
                                                  .currentState!
                                                  .validate()) {
                                                bloc.add(LoadingEvent());
                                                bloc.add(
                                                    UpdateTeamNameAndDescriptionEvent());
                                                Navigator.of(context).pop();
                                              }
                                            }
                                          },
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4.0),
                                          ),
                                          child: const Padding(
                                              padding: EdgeInsets.only(
                                                  left: 16.0,
                                                  right: 16.0,
                                                  top: 12,
                                                  bottom: 12),
                                              child: Text("Xa??c nh????n",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 15.0))),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              });
                        },
                        tooltip: 'Increment',
                        child: const Icon(Icons.edit),
                      ),
                    )
                  : const Padding(
                      padding: EdgeInsets.only(bottom: 20),
                    ),
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                ),
                title: Text(
                  state.teamDetail?.name ?? "??ang c???p nh???t...",
                  style: const TextStyle(color: Colors.white),
                ),
                automaticallyImplyLeading: false,
                centerTitle: true,
                backgroundColor: AppColors.mainColor,
              ),
              body: (state.isLoading)
                  ? Loading()
                  : SingleChildScrollView(
                      child: Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            (GetIt.I.get<CurrentUser>().id ==
                                        state.userIdIsLeaderTeam &&
                                    (max != 1))
                                ? Container(
                                    margin: const EdgeInsets.only(
                                        left: 15, top: 20),
                                    padding: const EdgeInsets.all(5.0),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: ArgonColors.success),
                                        color: ArgonColors.success,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10))),
                                    child: SelectableText(
                                        (state.teamDetail != null)
                                            ? "M?? m???i: ${state.teamDetail!.invitedCode}"
                                            : "Ch??a c?? load m??",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                        )),
                                  )
                                : const SizedBox(
                                    width: 10,
                                  ),
                            if (state.status == TeamStatus.Available &&
                                GetIt.I.get<CurrentUser>().id ==
                                    state.userIdIsLeaderTeam)
                              Container(
                                width: 150,
                                height: 35,
                                margin:
                                    const EdgeInsets.only(right: 10, top: 20),
                                padding: const EdgeInsets.all(5.0),
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: ArgonColors.warning),
                                    color: ArgonColors.warning,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10))),
                                child: FlatButton(
                                    textColor: ArgonColors.white,
                                    onPressed: () {
                                      bloc.add(UpdateStatusTeam(
                                          status: TeamStatus.IsLocked));
                                    },
                                    child: const Text("Kh??a nh??m",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15.0))),
                              ),
                            if (state.status == TeamStatus.IsLocked &&
                                GetIt.I.get<CurrentUser>().id ==
                                    state.userIdIsLeaderTeam)
                              Container(
                                width: 150,
                                height: 35,
                                margin:
                                    const EdgeInsets.only(right: 10, top: 20),
                                padding: const EdgeInsets.all(5.0),
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: ArgonColors.warning),
                                    color: ArgonColors.warning,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10))),
                                child: FlatButton(
                                    textColor: ArgonColors.white,
                                    onPressed: () {
                                      bloc.add(UpdateStatusTeam(
                                          status: TeamStatus.Available));
                                    },
                                    child: const Text("M??? nh??m",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15.0))),
                              ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0, left: 15),
                          child: Row(
                            children: [
                              const Text(
                                "Chi ti???t: ",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: Text(
                                state.teamDetail?.description ?? "",
                                style: const TextStyle(fontSize: 18),
                              )),
                            ],
                          ),
                        ),
                        (state.teamDetail?.participants != null)
                            ? ViewDetailTableMenu(
                                listModel: state.teamDetail!.participants)
                            : const Text("Ch??a c?? load danh s??ch Team"),
                        const SizedBox(
                          height: 30,
                        ),
                        // if (state.status == TeamStatus.Available &&
                        //     GetIt.I.get<CurrentUser>().id ==
                        //         state.userIdIsLeaderTeam)
                        //   Row(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: [
                        //       Container(
                        //         width: 170,
                        //         decoration: BoxDecoration(
                        //             border:
                        //                 Border.all(color: ArgonColors.warning),
                        //             color: ArgonColors.warning,
                        //             borderRadius:
                        //                 const BorderRadius.all(Radius.circular(30))),
                        //         child: FlatButton(
                        //             textColor: ArgonColors.white,
                        //             onPressed: () {
                        //               bloc.add(UpdateStatusTeam(
                        //                   status: TeamStatus.IsLocked));
                        //             },
                        //             child: const Text("Kh??a nh??m",
                        //                 style: TextStyle(
                        //                     fontWeight: FontWeight.w600,
                        //                     fontSize: 15.0))),
                        //       ),
                        //     ],
                        //   ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 200,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: ArgonColors.warning),
                                  color: ArgonColors.warning,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10))),
                              child: FlatButton(
                                  textColor: ArgonColors.white,
                                  onPressed: () {
                                    //navigator ?????n view_result_team
                                    TeamInCompetitionRequestModel request =
                                        TeamInCompetitionRequestModel(
                                            competitionId: state.competitionId,
                                            teamId: state.teamId);
                                    Navigator.of(context).pushNamed(
                                        Routes.viewResultTeam,
                                        arguments: request);
                                  },
                                  child: const Text("Xem k???t qu??? hi???n t???i",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15.0))),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        // if (state.status == TeamStatus.IsLocked &&
                        //     GetIt.I.get<CurrentUser>().id ==
                        //         state.userIdIsLeaderTeam)
                        //   Row(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: [
                        //       Container(
                        //          width: 200,
                        //         decoration: BoxDecoration(
                        //             border:
                        //                 Border.all(color: ArgonColors.warning),
                        //             color: ArgonColors.warning,
                        //             borderRadius:
                        //                 const BorderRadius.all(Radius.circular(30))),
                        //         child: FlatButton(
                        //             textColor: ArgonColors.white,
                        //             onPressed: () {
                        //               bloc.add(UpdateStatusTeam(
                        //                   status: TeamStatus.Available));
                        //             },
                        //             child: const Text("M??? nh??m",
                        //                 style: TextStyle(
                        //                     fontWeight: FontWeight.w600,
                        //                     fontSize: 15.0))),
                        //       ),
                        //     ],
                        //   ),
                        const SizedBox(height: 20),
                        if (state.userIdIsLeaderTeam ==
                            GetIt.I.get<CurrentUser>().id)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 200,
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: ArgonColors.warning),
                                    color: ArgonColors.warning,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10))),
                                child: FlatButton(
                                    textColor: ArgonColors.white,
                                    onPressed: () {
                                      AwesomeDialog(
                                        context: context,
                                        keyboardAware: true,
                                        dismissOnBackKeyPress: false,
                                        dialogType: DialogType.WARNING,
                                        animType: AnimType.BOTTOMSLIDE,
                                        btnCancelText: "H???y",
                                        btnOkText: "X??c Nh???n",
                                        title: 'B???n Ch???c Ch???',
                                        // padding: const EdgeInsets.all(5.0),
                                        desc: 'B???n c?? mu???n x??a ?????i Thi kh??ng ?',
                                        btnCancelOnPress: () {},
                                        btnOkOnPress: () {
                                          bloc.add(DeleteTeamByLeaderEvent());
                                        },
                                      ).show();
                                    },
                                    child: const Text("X??a ?????i Thi",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15.0))),
                              ),
                            ],
                          ),
                        if (state.userIdInTeam ==
                                GetIt.I.get<CurrentUser>().id &&
                            state.userIdInTeam != state.userIdIsLeaderTeam)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 200,
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: ArgonColors.warning),
                                    color: ArgonColors.warning,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10))),
                                child: FlatButton(
                                    textColor: ArgonColors.white,
                                    onPressed: () {
                                      AwesomeDialog(
                                        context: context,
                                        keyboardAware: true,
                                        dismissOnBackKeyPress: false,
                                        dialogType: DialogType.WARNING,
                                        animType: AnimType.BOTTOMSLIDE,
                                        btnCancelText: "H???y",
                                        btnOkText: "X??c Nh???n",
                                        title: 'B???n Ch???c Ch???',
                                        desc:
                                            'B???n c?? mu???n tho??t ?????i Thi kh??ng ?',
                                        btnCancelOnPress: () {},
                                        btnOkOnPress: () {
                                          bloc.add(MemberOutTeamEvent());
                                        },
                                      ).show();
                                    },
                                    child: const Text("Tho??t kh???i ?????i Thi",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15.0))),
                              ),
                            ],
                          ),
                        const SizedBox(height: 20),
                      ]),
                    ));
        },
      ),
    );
  }
}
