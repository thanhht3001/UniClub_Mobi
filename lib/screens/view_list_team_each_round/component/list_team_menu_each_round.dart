import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loadmore/loadmore.dart';
import 'package:unicec_mobi/bloc/view_list_team_in_round/view_list_team_in_round_bloc.dart';
import '../../../bloc/view_list_team_in_round/view_list_team_in_round_event.dart';
import '../../../bloc/view_list_team_in_round/view_list_team_in_round_state.dart';
import '../../../utils/loading.dart';

class ViewListTeamEachRoundMenu extends StatefulWidget {
  const ViewListTeamEachRoundMenu({
    Key? key,
  }) : super(key: key);

  @override
  State<ViewListTeamEachRoundMenu> createState() =>
      _ViewListTeamEachRoundMenuState();
}

class _ViewListTeamEachRoundMenuState extends State<ViewListTeamEachRoundMenu> {
//   @override
  void load(BuildContext context) {
    BlocProvider.of<ViewListTeamInRoundBloc>(context).add(LoadAddMoreEvent());
  }

  //refresh
  void refresh(BuildContext context) {
    BlocProvider.of<ViewListTeamInRoundBloc>(context)
        .add(ViewListTeamInitEvent());
  }

  Future<bool> _loadMore(BuildContext context) async {
    print("onLoadMore");
    await Future.delayed(Duration(seconds: 0, milliseconds: 5000));
    BlocProvider.of<ViewListTeamInRoundBloc>(context).add(IncrementalEvent());
    //lúc này stateModel cũng có r nhưng mà chưa có hàm render lại cái view
    //phải đưa cái hàm này vào trong để add event và có state
    load(context);
    return true;
  }

  Future<bool> _refresh(BuildContext context) async {
    print("onRefresh");
    BlocProvider.of<ViewListTeamInRoundBloc>(context).add(RefreshEvent());
    await Future.delayed(Duration(seconds: 0, milliseconds: 5000));
    refresh(context);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    ViewListTeamInRoundBloc bloc =
        BlocProvider.of<ViewListTeamInRoundBloc>(context);
    return BlocBuilder<ViewListTeamInRoundBloc, ViewListTeamInRoundState>(
      bloc: bloc,
      builder: (context, state) {
        return (state.isLoading &&
                (state.listTeamInRound.isEmpty ||
                    state.listTeamInRound.isNotEmpty))
            ? Loading()
            : (state.listTeamInRound.isEmpty)
                ? Padding(
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
                            'Hiện tại vòng thi chưa có đội tham gia!',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  )
                : RefreshIndicator(
                    onRefresh: () {
                      return _refresh(context);
                    },
                    child: LoadMore(
                      isFinish: !state.hasNext,
                      onLoadMore: () {
                        return _loadMore(context);
                      },
                      whenEmptyLoad: false,
                      delegate: DefaultLoadMoreDelegate(),
                      textBuilder: DefaultLoadMoreTextBuilder.english,
                      child: Column(
                        children: [
                          const SizedBox(height: 20.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: const [
                              SizedBox(
                                width: 40,
                              ),
                              Expanded(
                                  child: Text(
                                "Tên đội",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              )),
                              Expanded(
                                  child: Text(
                                "Số thành viên",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              )),
                              Expanded(
                                  child: Text(
                                "Điểm",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              )),
                              Expanded(
                                  child: Text(
                                "Chi tiết",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              )),
                            ],
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: state.listTeamInRound.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
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
                                  onPressed: () async {
                                    // Navigate to team detail page
                                    bloc.add(LoadInfoRoundEvent(
                                        roundId: state.roundId,
                                        teamId: state
                                            .listTeamInRound[index].teamId));
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(right: 15.0),
                                            child: Text(
                                                state.listTeamInRound[index]
                                                    .teamName,    
                                                style: const TextStyle(
                                                    fontSize: 15)),
                                          )),
                                      Expanded(
                                          child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 0), // 35.0
                                        child: Text(
                                          state.listTeamInRound[index]
                                              .membersInTeam.length
                                              .toString(),
                                          style: const TextStyle(fontSize: 15),
                                        ),
                                      )),
                                      Expanded(
                                        child: Text("${bloc.state.listTeamInRound[index].scores}",
                                            style: const TextStyle(
                                                fontSize: 15,
                                                color: Colors.red),
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
                          ),
                        ],
                      ),
                    ));
      },
    );
  }
}
