import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loadmore/loadmore.dart';
import '../../../bloc/view_list_team_student/view_list_team_student_bloc.dart';
import '../../../bloc/view_list_team_student/view_list_team_student_event.dart';
import '../../../bloc/view_list_team_student/view_list_team_student_state.dart';
import '../../../models/entities/team/sending_data_model.dart';
import '../../../utils/loading.dart';
import '../../../utils/router.dart';
import '/models/entities/team/team_model.dart';
import '../../../models/enums/team_status.dart';

class ViewListTeamStudentMenu extends StatefulWidget {
  const ViewListTeamStudentMenu({
    Key? key,
  }) : super(key: key);

  @override
  State<ViewListTeamStudentMenu> createState() =>
      _ViewListTeamStudentMenuMenuState();
}

class _ViewListTeamStudentMenuMenuState extends State<ViewListTeamStudentMenu> {
//   @override
  void load(BuildContext context) {
    BlocProvider.of<ViewListTeamStudentBloc>(context).add(LoadAddMoreEvent());
  }

  //refresh
  void refresh(BuildContext context) {
    BlocProvider.of<ViewListTeamStudentBloc>(context)
        .add(ViewListTeamInitEvent());
  }

  @override
  Widget build(BuildContext context) {
    ViewListTeamStudentBloc bloc =
        BlocProvider.of<ViewListTeamStudentBloc>(context);
    return BlocBuilder<ViewListTeamStudentBloc, ViewListTeamStudentState>(
      bloc: bloc,
      builder: (context, state) {
        return (state.isLoading &&
                (state.listTeam.isEmpty || state.listTeam.isNotEmpty))
            ? Loading()
            : (state.listTeam.isEmpty)
                ? Padding(
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
                            'Hiện tại cuộc thi chưa có đội tham gia!',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  )
                :
                // RefreshIndicator(
                //     onRefresh: () {
                //       return _refresh(context);
                //     },
                //child:
                LoadMore(
                    isFinish: !state.hasNext,
                    onLoadMore: () {
                      return _loadMore(context);
                    },
                    whenEmptyLoad: false,
                    delegate: DefaultLoadMoreDelegate(),
                    textBuilder: DefaultLoadMoreTextBuilder.english,
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.listTeam.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              primary: Colors.black87,
                              padding: EdgeInsets.all(20),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              backgroundColor:
                                  Color.fromARGB(255, 235, 237, 241),
                            ),
                            onPressed: () async {
                              //chuyển sang trang detail
                              SendingDataModel data = SendingDataModel(
                                  competitionId: state.competitionId,
                                  teamId: state.listTeam[index].id,
                                  teamName: state.listTeam[index].name,
                                  teamDescription:
                                      state.listTeam[index].description,
                                  status: state.listTeam[index].status);
                              bool returnData = await Navigator.of(context)
                                  .pushNamed(Routes.viewDetailTeamStudent,
                                      arguments: data) as bool;
                              if (returnData) {
                                bloc.add(LoadingEvent());
                                //này là thực hiện lại hàm để load lại
                                bloc.add(ReceiveDataEvent(
                                    competitionId: state.competitionId));
                              }
                            },
                            child: Row(
                              children: [
                                Expanded(
                                    child: Text(state.listTeam[index].name,
                                        style: TextStyle(fontSize: 15))),
                                Expanded(
                                    child: Padding(
                                  padding: const EdgeInsets.only(left: 35.0),
                                  child: Text(
                                      state.listTeam[index].numberOfMemberInTeam
                                          .toString(),
                                      style: TextStyle(fontSize: 15)),
                                )),
                                SizedBox(
                                  width: 30,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                if (state.listTeam[index].status.toString() ==
                                    "TeamStatus.Available")
                                  Expanded(
                                      child: Text("Mở",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.green)))
                                else
                                  Expanded(
                                      child: Text("Đóng",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.red))),
                                Icon(
                                  Icons.arrow_forward_ios,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
        //);
      },
    );
  }

  Future<bool> _loadMore(BuildContext context) async {
    print("onLoadMore");
    await Future.delayed(Duration(seconds: 0, milliseconds: 5000));
    BlocProvider.of<ViewListTeamStudentBloc>(context).add(IncrementalEvent());
    //lúc này stateModel cũng có r nhưng mà chưa có hàm render lại cái view
    //phải đưa cái hàm này vào trong để add event và có state
    load(context);
    return true;
  }

  Future<bool> _refresh(BuildContext context) async {
    print("onRefresh");
    BlocProvider.of<ViewListTeamStudentBloc>(context).add(RefreshEvent());
    await Future.delayed(Duration(seconds: 0, milliseconds: 5000));
    refresh(context);
    return true;
  }
}
