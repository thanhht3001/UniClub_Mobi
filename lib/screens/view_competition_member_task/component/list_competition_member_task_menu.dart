import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:loadmore/loadmore.dart';
import 'package:unicec_mobi/constants/Theme.dart';
import '../../../utils/loading.dart';
import '../../../utils/utils.dart';
import '/bloc/view_competition_member_task/view_competition_member_task_event.dart';
import '/models/common/current_user.dart';
import '../../../bloc/view_competition_member_task/view_competition_member_task_bloc.dart';
import '../../../bloc/view_competition_member_task/view_competition_member_task_state.dart';
import '../../../models/enums/competition_status.dart';
import '../../../utils/router.dart';

class ViewCompetitionMemberTaskMenu extends StatefulWidget {
  const ViewCompetitionMemberTaskMenu({
    Key? key,
  }) : super(key: key);

  @override
  State<ViewCompetitionMemberTaskMenu> createState() =>
      _ViewCompetitionMemberTaskMenuState();
}

class _ViewCompetitionMemberTaskMenuState
    extends State<ViewCompetitionMemberTaskMenu> {
  var _controller = TextEditingController();
  //load
  void load(BuildContext context) {
    BlocProvider.of<ViewCompetitionMemberTaskBloc>(context)
        .add(LoadAddMoreEvent());
  }

  //refresh
  void refresh(BuildContext context) {
    BlocProvider.of<ViewCompetitionMemberTaskBloc>(context).add(InitEvent());
  }

  @override
  Widget build(BuildContext context) {
    //bloc
    ViewCompetitionMemberTaskBloc bloc =
        BlocProvider.of<ViewCompetitionMemberTaskBloc>(context);
    return BlocBuilder<ViewCompetitionMemberTaskBloc,
            ViewCompetitionMemberTaskState>(
        bloc: bloc,
        builder: (context, state) {
          return (GetIt.I.get<CurrentUser>().clubIdSelected == 0)
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
                          'M???i b???n ch???n CLB ????? hi???n th??? danh s??ch c??ng vi???c',
                          style: TextStyle(fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                )
              : Container(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: RefreshIndicator(
                    onRefresh: () {
                      return _refresh(context);
                    },
                    child: SingleChildScrollView(
                      physics: ScrollPhysics(),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 20, left: 20, top: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: TextFormField(
                                      controller: _controller,
                                      onFieldSubmitted: (value) {
                                        bloc.add(LoadingEvent());
                                        bloc.add(ChangeSearchNameEvent(
                                            searchName: value));
                                      },
                                      autofocus: false,
                                      decoration: InputDecoration(
                                        suffixIcon: IconButton(
                                            onPressed: () {
                                              _controller.clear;
                                              _controller.text = "";
                                              //s???a l???i c??i
                                              bloc.add(ChangeSearchNameEvent(
                                                  searchName: null));
                                            },
                                            icon: const Icon(Icons.clear)),
                                        labelText: 'T??m theo t??n',
                                        focusedBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        enabledBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.grey, width: 1.0),
                                        ),
                                      )),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: GestureDetector(
                                    onTap: () {
                                      bloc.add(LoadingEvent());
                                      bloc.add(SearchEvent());
                                    },
                                    child: const Icon(Icons.search),
                                  ),
                                ),
                                PopupMenuButton<int>(
                                    icon: const Icon(Icons.filter_alt_outlined),
                                    itemBuilder: (context) {
                                      return [
                                        PopupMenuItem(
                                          onTap: () {
                                            bloc.add(LoadingEvent());
                                            //add bi???n li??n tr?????ng
                                            bloc.add(ChangeValueEvent(
                                                isEvent: false));
                                          },
                                          value: 1,
                                          child: (state.isEvent == false)
                                              ? Container(
                                                  child: Row(
                                                    children: const <Widget>[
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 8.0),
                                                        child: Text(
                                                          'Cu???c Thi',
                                                          style: TextStyle(
                                                              color: ArgonColors
                                                                  .warning),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : Row(
                                                  children: const <Widget>[
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 8.0),
                                                      child: Text('Cu???c Thi'),
                                                    ),
                                                  ],
                                                ),
                                        ),
                                        PopupMenuItem(
                                          onTap: () {
                                            bloc.add(LoadingEvent());
                                            bloc.add(ChangeValueEvent(
                                                isEvent: true));
                                          },
                                          value: 2,
                                          child: (state.isEvent)
                                              ? Container(
                                                  child: Row(
                                                    children: const <Widget>[
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 8.0),
                                                        child: Text(
                                                          'S??? Ki???n',
                                                          style: TextStyle(
                                                              color: ArgonColors
                                                                  .warning),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : Row(
                                                  children: const <Widget>[
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 8.0),
                                                      child: Text('S??? Ki???n'),
                                                    ),
                                                  ],
                                                ),
                                        ),
                                      ];
                                    }),
                              ],
                            ),
                          ),
                          (state.isLoading &&
                                  (state.listCompetition.isEmpty ||
                                      state.listCompetition.isNotEmpty))
                              ? Loading()
                              : (state.listCompetition.isNotEmpty)
                                  ?
                                  //  RefreshIndicator(
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
                                      textBuilder:
                                          DefaultLoadMoreTextBuilder.english,
                                      child: ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: state.listCompetition.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                right: 20,
                                                left: 20,
                                                top: 20,
                                                bottom: 10),
                                            child: TextButton(
                                              style: TextButton.styleFrom(
                                                primary: Colors.black87,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10.0,
                                                        horizontal: 15.0),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                                backgroundColor:
                                                    const Color.fromARGB(
                                                        255, 235, 237, 241),
                                              ),
                                              onPressed: () async {
                                                //chuy???n sang trang detail
                                                bool returnData = await Navigator
                                                        .of(context)
                                                    .pushNamed(
                                                        Routes.viewListActivity,
                                                        arguments: state
                                                            .listCompetition[
                                                                index]
                                                            .id) as bool;
                                                if (returnData) {
                                                  bloc.add(LoadingEvent());
                                                  bloc.add(SearchEvent());
                                                }
                                              },
                                              child: Column(
                                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets
                                                                .only(
                                                            right: 12.0), // 8.0
                                                        // top: 0), // 10.0
                                                        child: SvgPicture.asset(
                                                          "assets/icons/trophy.svg",
                                                          color: ArgonColors
                                                              .warning,
                                                          width: 22,
                                                        ),
                                                        // Text(
                                                        //     state
                                                        //         .listCompetition[
                                                        //             index]
                                                        //         .id
                                                        //         .toString(),
                                                        //     style: TextStyle(
                                                        //         fontSize: 20,
                                                        //         color: Colors
                                                        //             .red)),
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                            state
                                                                .listCompetition[
                                                                    index]
                                                                .name,
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        18)),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 10),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      // const Padding(
                                                      //   padding: EdgeInsets.only(
                                                      //       left: 16.0, right: 8),
                                                      //   child: Text("|",
                                                      //       style: TextStyle(
                                                      //           fontSize: 18,
                                                      //           color: Colors
                                                      //               .blueGrey)),
                                                      // ),
                                                      Text(
                                                          Utils.convertDateTime(
                                                              state
                                                                  .listCompetition[
                                                                      index]
                                                                  .createTime),
                                                          style: const TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color:
                                                                  Colors.grey)),
                                                      const Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    8.0),
                                                        child: Text("|",
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                color: Colors
                                                                    .blueGrey)),
                                                      ),
                                                      if (state
                                                              .listCompetition[
                                                                  index]
                                                              .status ==
                                                          CompetitionStatus
                                                              .Draft)
                                                        const Text(
                                                          "B???n th???o",
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                      if (state
                                                              .listCompetition[
                                                                  index]
                                                              .status ==
                                                          CompetitionStatus
                                                              .PendingReview)
                                                        const Text(
                                                          "Ch??? ???????c duy???t",
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                      if (state
                                                              .listCompetition[
                                                                  index]
                                                              .status ==
                                                          CompetitionStatus.End)
                                                        const Text(
                                                          "K???t th??c",
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                      if (state
                                                              .listCompetition[
                                                                  index]
                                                              .status ==
                                                          CompetitionStatus
                                                              .Approve)
                                                        const Text(
                                                          "???? X??t Duy???t",
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                      if (state
                                                              .listCompetition[
                                                                  index]
                                                              .status ==
                                                          CompetitionStatus
                                                              .Register)
                                                        const Text(
                                                          "M??? ????ng k??",
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              color:
                                                                  Colors.green),
                                                        ),
                                                      if (state
                                                              .listCompetition[
                                                                  index]
                                                              .status ==
                                                          CompetitionStatus
                                                              .Upcoming)
                                                        const Text(
                                                          "S???p di???n ra",
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              color: Colors
                                                                  .orange),
                                                        ),
                                                      if (state
                                                              .listCompetition[
                                                                  index]
                                                              .status ==
                                                          CompetitionStatus
                                                              .Start)
                                                        const Text(
                                                          "Khai m???c",
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              color: Colors
                                                                  .redAccent),
                                                        ),
                                                      if (state
                                                              .listCompetition[
                                                                  index]
                                                              .status ==
                                                          CompetitionStatus
                                                              .OnGoing)
                                                        const Text(
                                                          "??ang di???n ra",
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              color:
                                                                  Colors.amber),
                                                        ),
                                                      if (state
                                                              .listCompetition[
                                                                  index]
                                                              .status ==
                                                          CompetitionStatus
                                                              .Publish)
                                                        const Text(
                                                          "C??ng b???",
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              color: Colors
                                                                  .purple),
                                                        ),
                                                      if (state
                                                              .listCompetition[
                                                                  index]
                                                              .status ==
                                                          CompetitionStatus
                                                              .Pending)
                                                        const Text(
                                                          "Ch???",
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              color: Colors
                                                                  .deepOrangeAccent),
                                                        ),
                                                      if (state
                                                              .listCompetition[
                                                                  index]
                                                              .status ==
                                                          CompetitionStatus
                                                              .Finish)
                                                        const Text(
                                                          "Ho??n th??nh",
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              color:
                                                                  Colors.green),
                                                        ),
                                                      if (state
                                                              .listCompetition[
                                                                  index]
                                                              .status ==
                                                          CompetitionStatus
                                                              .Complete)
                                                        const Text(
                                                          " ???? ????ng ",
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                      if (state
                                                              .listCompetition[
                                                                  index]
                                                              .status ==
                                                          CompetitionStatus
                                                              .Cancel)
                                                        const Text(
                                                          "H???y",
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              color:
                                                                  Colors.red),
                                                        ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    )
                                  //)
                                  :
                                  //Expanded(
                                  // Padding
                                  // padding: EdgeInsets.only(top: (MediaQuery.of(context).size.height - 500) / 2),
                                  //child:
                                  Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                            decoration: const BoxDecoration(
                                                image: DecorationImage(
                                                    alignment:
                                                        Alignment.topCenter,
                                                    image: AssetImage(
                                                        "assets/img/not-found-icon-24.jpg"),
                                                    fit: BoxFit.fitWidth))),
                                        Image.asset(
                                            "assets/img/not-found-icon-24.jpg"),
                                        const Padding(
                                          padding: EdgeInsets.only(top: 25.0),
                                          child: Text(
                                            'Hi???n t???i b???n kh??ng c?? ho???t ?????ng n??o!',
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ),
                                      ],
                                    ),
                          //)
                        ],
                      ),
                    ),
                  ),
                );
        });
  }

  Future<bool> _loadMore(BuildContext context) async {
    print("onLoadMore");
    await Future.delayed(Duration(seconds: 0, milliseconds: 5000));
    BlocProvider.of<ViewCompetitionMemberTaskBloc>(context)
        .add(IncrementalEvent());
    //l??c n??y stateModel c??ng c?? r nh??ng m?? ch??a c?? h??m render l???i c??i view
    //ph???i ????a c??i h??m n??y v??o trong ????? add event v?? c?? state
    load(context);
    return true;
  }

  Future<bool> _refresh(BuildContext context) async {
    print("onRefresh");
    BlocProvider.of<ViewCompetitionMemberTaskBloc>(context).add(RefreshEvent());
    await Future.delayed(Duration(seconds: 0, milliseconds: 5000));
    refresh(context);
    return true;
  }
}
