import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicec_mobi/bloc/view_list_member/view_list_member_event.dart';
import '../../../bloc/view_list_member/view_list_member_bloc.dart';
import '../../../models/entities/member/member_model.dart';
import '../../../utils/router.dart';

class ViewDetailTableMemberMenu extends StatefulWidget {
  final List<MemberModel> listModel;

  ViewDetailTableMemberMenu({required this.listModel});

  @override
  State<ViewDetailTableMemberMenu> createState() =>
      _ViewDetailTableMemberMenuState();
}

class _ViewDetailTableMemberMenuState extends State<ViewDetailTableMemberMenu> {
  List<MemberModel> get listModel => widget.listModel;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    ViewListMemberBloc bloc = BlocProvider.of<ViewListMemberBloc>(context);
    return BlocBuilder(
      bloc: bloc,
      builder: (context, state) {
        return DataTable(
            columnSpacing: 10,
            columns: [
          DataColumn(
              label: Container(
            child: Text('',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          )),
          DataColumn(
              label: Container(
            child: Text('Tên',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          )),
          DataColumn(
              label: Container(
            child: Text('Chức vụ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          )),
          DataColumn(
              label: Container(
            child: Text('Chi tiết',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          )),
        ], rows: getRows(listModel).cast());
      },
    );
  }

  List getRows(List<MemberModel> member) => listModel.map((MemberModel member) {
        final cells = [1, 2, 3, 4];
        Iterable<DataCell> getListData = cells.map<DataCell>((e) {
          if (e == 1) {
            return DataCell(
                Container(
                  child: CircleAvatar(
                      backgroundImage: (member.avatar.isNotEmpty)
                          ? NetworkImage(scale: 50, member.avatar)
                          : NetworkImage(
                              scale: 50, "https://picsum.photos/seed/513/600")),
                ));
          } else if (e == 2) {
            return DataCell(Container(
                // width: MediaQuery.of(context).size.width * 0.2,
                child: Text(
                  member.name,
                  softWrap: false,
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                  style: TextStyle(fontSize: 15),
                )));
          } else if (e == 3) {
            return DataCell(

                Container(
              child: Text(
                member.clubRoleName,
                softWrap: false,
                maxLines: 1,
                overflow: TextOverflow.fade,
                style: TextStyle(fontSize: 15),
              ),
            ));
          } else {
            return DataCell(
                Container(
                  child: SizedBox(child: PopupMenuButton<int>(itemBuilder: (context) {
              return [
                  PopupMenuItem(
                    onTap: () {
                      //chuyển sang trang view thông tin
                      BlocProvider.of<ViewListMemberBloc>(context)
                          .add(ClickToViewInfoEvent(userId: member.studentId));
                    },
                    value: 1,
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.remove_red_eye, size: 18),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text('Xem thông tin'),
                        ),
                      ],
                    ),
                  ),
              ];
            })),
                ));
          }
        });
        return DataRow(cells: getListData.toList());
      }).toList();
}
