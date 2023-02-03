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
          // dùng để loading khi từ MyAccount -> về lại đây
          bloc.add(LoadDataEvent());
        }
      } else if (event is ShowingSnackBarEvent) {
        if (event.message.contains("thành công")) {
          AwesomeDialog(
            context: context,
            animType: AnimType.LEFTSLIDE,
            headerAnimationLoop: false,
            dialogType: DialogType.SUCCES,
            showCloseIcon: true,
            title: 'Thành Công',
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
            title: 'Thất bại',
            desc: (event.message.contains("bảo trì"))
                ? "Thất bại, hiện tại Cuộc Thi & Sự Kiện đang bảo trì"
                : (event.message.contains("qua thời gian tạo"))
                    ? "Thất bại, hiện tại đã quá thời gian cho phép thực hiện hành động"
                    : (event.message
                            .contains("Can't out team because team is locked"))
                        ? "Thoát khỏi Đội Thất bại, hiện tại Đội Thi của bạn ở trạng thái Đóng"
                        : (event.message.contains("Team Is Locked you delete"))
                            ? "Xóa Đội Thất bại, hiện tại Đội Thi của bạn ở trạng thái Đóng"
                            : (event.message
                                    .contains("Number of member in team is "))
                                ? "Thất bại, hiện tại số lượng thành viên trong Đội Thi của bạn không thỏa quy định của Cuộc Thi," +
                                    ((max != min)
                                        ? " chỉ cho phép số lượng thành viên trong khoảng từ ${min} cho tới ${max}"
                                        : " số lượng thành viên bằng ${max}")
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

  //nhận competition Id
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
                        heroTag: "Chỉnh sửa thông tin đội",
                        backgroundColor: ArgonColors.warning,
                        onPressed: () async {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  scrollable: true,
                                  title: Container(
                                      child: Text(
                                    'Chỉnh sửa',
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
                                            Text('Tên đội'),
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
                                                return 'Nhập ít nhất 5 ký tự';
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
                                            Text('Miêu tả'),
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
                                                return 'Nhập ít nhất 5 ký tự';
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
                                              child: Text("Xác nhận",
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
                  state.teamDetail?.name ?? "Đang cập nhật...",
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
                                            ? "Mã mời: ${state.teamDetail!.invitedCode}"
                                            : "Chưa có load mã",
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
                                    child: const Text("Khóa nhóm",
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
                                    child: const Text("Mở nhóm",
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
                                "Chi tiết: ",
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
                            : const Text("Chưa có load danh sách Team"),
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
                        //             child: const Text("Khóa nhóm",
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
                                    //navigator đến view_result_team
                                    TeamInCompetitionRequestModel request =
                                        TeamInCompetitionRequestModel(
                                            competitionId: state.competitionId,
                                            teamId: state.teamId);
                                    Navigator.of(context).pushNamed(
                                        Routes.viewResultTeam,
                                        arguments: request);
                                  },
                                  child: const Text("Xem kết quả hiện tại",
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
                        //             child: const Text("Mở nhóm",
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
                                        btnCancelText: "Hủy",
                                        btnOkText: "Xác Nhận",
                                        title: 'Bạn Chắc Chứ',
                                        // padding: const EdgeInsets.all(5.0),
                                        desc: 'Bạn có muốn xóa Đội Thi không ?',
                                        btnCancelOnPress: () {},
                                        btnOkOnPress: () {
                                          bloc.add(DeleteTeamByLeaderEvent());
                                        },
                                      ).show();
                                    },
                                    child: const Text("Xóa Đội Thi",
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
                                        btnCancelText: "Hủy",
                                        btnOkText: "Xác Nhận",
                                        title: 'Bạn Chắc Chứ',
                                        desc:
                                            'Bạn có muốn thoát Đội Thi không ?',
                                        btnCancelOnPress: () {},
                                        btnOkOnPress: () {
                                          bloc.add(MemberOutTeamEvent());
                                        },
                                      ).show();
                                    },
                                    child: const Text("Thoát khỏi Đội Thi",
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
