import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicec_mobi/constants/Theme.dart';
import 'package:unicec_mobi/screens/view_list_team_student/component/list_team_menu_student.dart';
import '../../../bloc/view_list_team_student/view_list_team_student_bloc.dart';
import '../../../bloc/view_list_team_student/view_list_team_student_state.dart';
import '';

class BodyEachRound extends StatefulWidget {
  BodyEachRound({Key? key}) : super(key: key);

  @override
  State<BodyEachRound> createState() => _BodyEachRoundState();
}

class _BodyEachRoundState extends State<BodyEachRound> {
//   @override
  final _formKeyInvitedCode = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ViewListTeamStudentBloc bloc =
        BlocProvider.of<ViewListTeamStudentBloc>(context);
    return BlocBuilder<ViewListTeamStudentBloc, ViewListTeamStudentState>(
        bloc: bloc,
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(children: [
              Container(
                padding: const EdgeInsets.only(left: 20, top: 10, bottom: 20),
                child: Wrap(
                  children: const [
                    Text(
                      "Lưu ý*: ",
                      style: TextStyle(color: ArgonColors.error, fontSize: 20),
                    ),
                    Text(
                      "Hãy tham gia cuộc thi để có đội thi của riêng bạn!",
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    )
                  ],
                ),
              ),
              if (state.listTeam.isNotEmpty)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    SizedBox(
                      width: 40,
                    ),
                    Expanded(
                        child: Text(
                      "Tên đội",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    )),
                    Expanded(
                        child: Text(
                      "Số thành viên",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    )),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        child: Text(
                      "Trạng thái",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    )),
                    Expanded(
                        child: Text(
                      "Thứ hạng",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    )),
                  ],
                ),
              ViewListTeamStudentMenu(),
            ]),
          );
        });
  }
}
