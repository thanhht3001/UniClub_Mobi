import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loadmore/loadmore.dart';
import '../../../bloc/view_list_team_participant/view_list_team_participant_bloc.dart';
import '../../../bloc/view_list_team_participant/view_list_team_participant_event.dart';
import '../../../bloc/view_list_team_participant/view_list_team_participant_state.dart';
import '../../../models/entities/team/sending_data_model.dart';
import '../../../utils/loading.dart';
import '../../../utils/router.dart';

class ViewListTeamMenu extends StatefulWidget {
  const ViewListTeamMenu({
    Key? key,
  }) : super(key: key);

  @override
  State<ViewListTeamMenu> createState() => _ViewListTeamMenuState();
}

class _ViewListTeamMenuState extends State<ViewListTeamMenu> {
//   @override
  void load(BuildContext context) {
    BlocProvider.of<ViewListTeamParticipantBloc>(context)
        .add(LoadAddMoreEvent());
  }

  //refresh
  void refresh(BuildContext context) {
    BlocProvider.of<ViewListTeamParticipantBloc>(context)
        .add(ViewListTeamInitEvent());
  }

  @override
  Widget build(BuildContext context) {
    ViewListTeamParticipantBloc bloc =
        BlocProvider.of<ViewListTeamParticipantBloc>(context);
    return BlocBuilder<ViewListTeamParticipantBloc,
        ViewListTeamParticipantState>(
      bloc: bloc,
      builder: (context, state) {
        return (state.isLoading &&
                (state.listTeam.isEmpty || state.listTeam.isNotEmpty))
            ? Loading()
            : (state.listTeam.isEmpty)
                ? Padding(
                    padding: const EdgeInsets.only(top: 50.0),
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
                            'Hiện tại cuộc thi chưa có team nào!',
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
                //     child:
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              primary: Colors.black87,
                              padding: const EdgeInsets.all(20),
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
                                status: state.listTeam[index].status,
                                max: state.maxNumber,
                                min: state.minNumber,
                              );
                              bool returnData = await Navigator.of(context)
                                  .pushNamed(Routes.viewDetailTeamParticipant,
                                      arguments: data) as bool;
                              if (returnData) {
                                bloc.add(LoadingEvent());
                                bloc.add(ResetFilterEvent());
                              }
                            },
                            child: Row(
                              children: [
                                Expanded(
                                    child: Text(state.listTeam[index].name,
                                        style: const TextStyle(fontSize: 15))),
                                Expanded(
                                    child: Padding(
                                  padding: const EdgeInsets.only(left: 35.0),
                                  child: Text(
                                      state.listTeam[index].numberOfMemberInTeam
                                          .toString(),
                                      style: const TextStyle(fontSize: 15)),
                                )),
                                const SizedBox(
                                  width: 40,
                                ),
                                if (state.listTeam[index].status.toString() ==
                                    "TeamStatus.Available")
                                  Expanded(
                                      child: Row(
                                    children: [
                                      Text("Mở",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.green))
                                    ],
                                  ))
                                else
                                  Expanded(
                                      child: Text("Đóng",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.red))),
                                const Icon(
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
    BlocProvider.of<ViewListTeamParticipantBloc>(context)
        .add(IncrementalEvent());
    //lúc này stateModel cũng có r nhưng mà chưa có hàm render lại cái view
    //phải đưa cái hàm này vào trong để add event và có state
    load(context);
    return true;
  }

  Future<bool> _refresh(BuildContext context) async {
    print("onRefresh");
    BlocProvider.of<ViewListTeamParticipantBloc>(context).add(RefreshEvent());
    await Future.delayed(Duration(seconds: 0, milliseconds: 5000));
    refresh(context);
    return true;
  }
}
