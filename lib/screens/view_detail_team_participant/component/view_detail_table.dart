import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../../bloc/view_detail_team_participant/view_detail_team_participant_bloc.dart';
import '../../../bloc/view_detail_team_participant/view_detail_team_participant_event.dart';
import '../../../models/common/current_user.dart';
import '../../../models/entities/participant/view_detail_participant.dart';
import '../../../utils/loading.dart';
import '../../../utils/router.dart';

class ViewDetailTableMenu extends StatefulWidget {
  final List<ViewDetailParticipantModel> listModel;

  ViewDetailTableMenu({required this.listModel});

  @override
  State<ViewDetailTableMenu> createState() => _ViewDetailTableMenuState();
}

class _ViewDetailTableMenuState extends State<ViewDetailTableMenu> {
  List<ViewDetailParticipantModel> get listModel => widget.listModel;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    ViewDetailTeamParticipantBloc bloc =
        BlocProvider.of<ViewDetailTeamParticipantBloc>(context);
    return BlocBuilder(
      bloc: bloc,
      builder: (context, state) {
        return DataTable(
            columnSpacing: 10,
            horizontalMargin: 9,
            columns: [
              DataColumn(
                  label: Container(
                child: Text('',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              )),
              DataColumn(
                  label: Container(
                child: Text('Tên',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              )),
              DataColumn(
                  label: Text('MSSV',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Container(
                child: Text('Chi tiết',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              )),
            ],
            rows: getRows(listModel).cast());
      },
    );
  }

  Future<void> _showDeleteDialog(
      int participantId, ViewDetailTeamParticipantBloc bloc) {
    // return showDialog<void>(
    //   context: context,
    //   barrierDismissible: false, // user must tap button!
    //   builder: (context) {
    // return AlertDialog(
    //   title: Text('Cảnh báo'),
    //   content: SingleChildScrollView(
    //     child: Column(
    //       children: <Widget>[
    //         Text('Bạn có chắc chắn muốn xóa?'),
    //       ],
    //     ),
    //   ),
    //   actions: <Widget>[
    //     TextButton(
    //       child: Text('Đồng ý'),
    //       onPressed: () {
    //         bloc.add(DeleteMemberByTeamLeaderEvent(
    //             participantId: participantId));
    //         Navigator.of(context).pop();
    //       },
    //     ),
    //     TextButton(
    //       child: Text('Hủy'),
    //       onPressed: () {
    //         Navigator.of(context).pop();
    //       },
    //     ),
    //   ],
    // );

    return AwesomeDialog(
      context: context,
      keyboardAware: true,
      dismissOnBackKeyPress: false,
      dialogType: DialogType.WARNING,
      animType: AnimType.BOTTOMSLIDE,
      btnCancelText: "Hủy",
      btnOkText: "Xác Nhận",
      title: 'Bạn Chắc Chứ',
      // padding: const EdgeInsets.all(5.0),
      desc: 'Bạn có muốn xóa thành viên này trong Đội Thi không ?',
      btnCancelOnPress: () {
        Navigator.of(context).pop();
      },
      btnOkOnPress: () {
        bloc.add(DeleteMemberByTeamLeaderEvent(participantId: participantId));
      },
    ).show();
    //},
    //);
  }

  List getRows(List<ViewDetailParticipantModel> member) =>
      listModel.map((ViewDetailParticipantModel member) {
        final cells = [1, 2, 3, 4];
        Iterable<DataCell> getListData = cells.map<DataCell>((e) {
          if (e == 1) {
            return DataCell(Row(children: [
              CircleAvatar(
                  backgroundImage: (member.studentAvatar.isNotEmpty)
                      ? NetworkImage(scale: 50, member.studentAvatar)
                      : NetworkImage(
                      scale: 50, "https://picsum.photos/seed/513/600")),
              if (member.teamRoleName.compareTo("Leader") == 0)
                Icon(
                  Icons.star,
                  color: Colors.red,
                )
            ]));
          } else if (e == 2) {
            return DataCell(Container(
                width: MediaQuery.of(context).size.width * 0.4,
                child: Text(
                  member.studentName,
                  softWrap: false,
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                  style: TextStyle(fontSize: 15),
                )));
          } else if (e == 3) {
            return DataCell(Text(
              member.studentCode,
              style: TextStyle(fontSize: 15),
            ));
          } else {
            return
              //show cho bản thân mình
              (GetIt.I.get<CurrentUser>().id == member.studentId)
                  ? DataCell(SizedBox(
                  child: PopupMenuButton<int>(itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        onTap: () {
                          BlocProvider.of<ViewDetailTeamParticipantBloc>(
                              context)
                              .add(ClickToViewInfoEvent(
                              userId: member.studentId));
                        },
                        value: 2,
                        child: Row(
                          children: <Widget>[
                            //Icon(Icons.remove_red_eye, size: 18),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text('Xem thông tin'),
                            ),
                          ],
                        ),
                      ),
                    ];
                  })))
                  : (BlocProvider.of<ViewDetailTeamParticipantBloc>(context)
                  .state
                  .userIdInTeam ==
                  -1)
                  ? DataCell(SizedBox(
                  child: PopupMenuButton<int>(itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        onTap: () {
                          BlocProvider.of<
                              ViewDetailTeamParticipantBloc>(
                              context)
                              .add(ClickToViewInfoEvent(
                              userId: member.studentId));
                        },
                        value: 2,
                        child: Row(
                          children: <Widget>[
                            //Icon(Icons.remove_red_eye, size: 18),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text('Xem thông tin'),
                            ),
                          ],
                        ),
                      ),
                    ];
                  })))
                  :
              //trường hợp cho mình chỉ thấy những thằng còn lại
              (GetIt.I.get<CurrentUser>().id != member.studentId &&
                  BlocProvider.of<ViewDetailTeamParticipantBloc>(
                      context)
                      .state
                      .userIdInTeam !=
                      -1 &&
                  member.teamRoleName.compareTo("Leader") != 0)
                  ? DataCell(SizedBox(child:
              PopupMenuButton<int>(itemBuilder: (context) {
                return [
                  if (BlocProvider.of<
                      ViewDetailTeamParticipantBloc>(
                      context)
                      .state
                      .userIdIsLeaderTeam ==
                      GetIt.I.get<CurrentUser>().id)
                    PopupMenuItem(
                      onTap: () {
                        BlocProvider.of<
                            ViewDetailTeamParticipantBloc>(
                            context)
                            .add(UpdateMemberRoleEvent(
                            participantInTeamId: member
                                .participantInTeamId));
                      },
                      value: 1,
                      child: Row(
                        children: <Widget>[
                          // Icon(Icons.access_time_sharp,
                          //     size: 18),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 8.0),
                            child: Text('Chọn làm đội trưởng'),
                          ),
                        ],
                      ),
                    ),
                  PopupMenuItem(
                    onTap: () {
                      BlocProvider.of<
                          ViewDetailTeamParticipantBloc>(
                          context)
                          .add(ClickToViewInfoEvent(
                          userId: member.studentId));
                    },
                    value: 2,
                    child: Row(
                      children: <Widget>[
                        //Icon(Icons.remove_red_eye, size: 18),
                        Padding(
                          padding:
                          const EdgeInsets.only(left: 8.0),
                          child: Text('Xem thông tin'),
                        ),
                      ],
                    ),
                  ),
                  if (BlocProvider.of<
                      ViewDetailTeamParticipantBloc>(
                      context)
                      .state
                      .userIdIsLeaderTeam ==
                      GetIt.I.get<CurrentUser>().id)
                    PopupMenuItem(
                        onTap: () {},
                        value: 3,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary:
                            Colors.black.withOpacity(0.05),
                            onPrimary: Colors.black,
                          ),
                          onPressed: () {
                            _showDeleteDialog(
                                member.participantId,
                                BlocProvider.of<
                                    ViewDetailTeamParticipantBloc>(
                                    context));
                          },
                          child: Row(
                            children: <Widget>[
                              Text('Xóa thành viên'),
                            ],
                          ),
                        ))
                ];
              })))
                  : DataCell(SizedBox(child:
              PopupMenuButton<int>(itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    onTap: () {
                      BlocProvider.of<
                          ViewDetailTeamParticipantBloc>(
                          context)
                          .add(ClickToViewInfoEvent(
                          userId: member.studentId));
                    },
                    value: 2,
                    child: Row(
                      children: <Widget>[
                        //Icon(Icons.remove_red_eye, size: 18),
                        Padding(
                          padding:
                          const EdgeInsets.only(left: 8.0),
                          child: Text('Xem thông tin'),
                        ),
                      ],
                    ),
                  ),
                ];
              })));
          }
        });
        return DataRow(cells: getListData.toList());
      }).toList();
}
