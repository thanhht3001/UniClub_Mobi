import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicec_mobi/bloc/club_selection/club_selection_bloc.dart';

import '../../bloc/club_selection/club_selection_event.dart';
import '../../bloc/club_selection/club_selection_state.dart';
import '../../utils/app_color.dart';
import '../../utils/dimens.dart';
import '../../utils/loading.dart';
import '../../utils/router.dart';
import 'widgets/club_card.dart';
import 'widgets/show_clubs.dart';
import 'widgets/welcome_text.dart';

class ClubSelectionPage extends StatefulWidget {
  final ClubSelectionBloc bloc;
  ClubSelectionPage({required this.bloc});
  @override
  State<ClubSelectionPage> createState() => _ClubSelectionPageState();
}

class _ClubSelectionPageState extends State<ClubSelectionPage> {
  ClubSelectionBloc get _bloc => widget.bloc;

  @override
  void initState() {
    //
    _bloc.listenerStream.listen((event) {
      if (event is NavigatorClubPageEvent) {
        Navigator.of(context).pushReplacementNamed(Routes.main);
        //.pop(context);
      }
      //PushName để có trang back về
      if (event is NavigatorClubsViewPageEvent) {
        Navigator.of(context).pushNamed(Routes.clubsView);
      }
    });
    //
    _bloc.add(ClubSelectionEvent());
    _bloc.isLoading = true;

    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
        value: _bloc,
        child: BlocBuilder<ClubSelectionBloc, ClubSelectionState>(
          bloc: _bloc,
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                ),
                title: const Text(
                  "Chọn câu lạc bộ",
                  style: TextStyle(color: Colors.white),
                ),
                automaticallyImplyLeading: false,
                centerTitle: true,
                backgroundColor: AppColors.mainColor,
              ),
              body: (_bloc.isLoading)
                  ? Loading()
                  : (_bloc.state.listClubsBelongToStudent.isEmpty)
                      ? const Center(
                          child: Text("Hiện tại bạn chưa tham gia CLB nào!"),
                        )
                      : Container(
                          constraints: const BoxConstraints.expand(),
                          // decoration: BoxDecoration(
                          //   image: DecorationImage(
                          //     colorFilter: ColorFilter.mode(
                          //         Colors.black.withOpacity(Dimens.size0p6),
                          //         BlendMode.dstATop),
                          //     image:
                          //         const AssetImage("assets/img/onboard-background.png"),
                          //     fit: BoxFit.cover,
                          //   ),
                          // ),
                          child: Padding(
                            padding: EdgeInsets.all(Dimens.size10),
                            child: RefreshIndicator(
                              onRefresh: () {
                                return _refresh(context);
                              },
                              child: SingleChildScrollView(
                                physics: ScrollPhysics(),
                                child: Column(
                                  children: [
                                    WelcomeText(),
                                    //ShowClubsBelongToStudent(),
                                    Column(
                                      children: [
                                        // SizedBox(height: Dimens.size10),
                                        // Text(
                                        //   'Chọn câu lạc bộ của bạn',
                                        //   style: TextStyle(
                                        //     fontWeight: FontWeight.w500,
                                        //     fontSize: 20.0,
                                        //   ),
                                        // ),
                                        SizedBox(
                                          height: Dimens.size10,
                                        ),
                                        BlocBuilder<ClubSelectionBloc,
                                                ClubSelectionState>(
                                            bloc: _bloc,
                                            builder: (context, state) {
                                              return
                                                  // RefreshIndicator(
                                                  //     onRefresh: () {
                                                  //       return _refresh(context);
                                                  //     },
                                                  //     child:
                                                  ListView.builder(
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                itemCount: state
                                                    .listClubsBelongToStudent
                                                    .length,
                                                shrinkWrap: true,
                                                itemBuilder: (context, index) {
                                                  return ClubCard(
                                                    club: state
                                                        .listClubsBelongToStudent
                                                        .elementAt(index),
                                                    member: state
                                                        .listMembersBelongToClubs
                                                        .elementAt(index),
                                                  );
                                                },
                                              )
                                                  //)
                                                  ;
                                            }),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
              floatingActionButton: Padding(
                padding: const EdgeInsets.only(bottom: 60),
                child: FloatingActionButton.extended(
                  onPressed: () {
                    //thêm event qua trang list club
                    // _bloc.add(ClubsViewPageEvent());
                    // bool isLoadPage = await Navigator.of(context)
                    //     .pushNamed(Routes.clubsView) as bool;
                    // if (isLoadPage) {
                    //   _bloc.isLoading = true;
                    //   _bloc.add(RefreshEvent());
                    // }

                    Navigator.pushNamed(context, Routes.clubsView)
                        .then((value) => setState(() {
                              _bloc.add(RefreshEvent());
                            }));
                  },
                  backgroundColor: AppColors.mainColor,
                  label: const Text("Tham gia clb khác"),
                  icon: const Icon(Icons.add),
                  //extendedPadding: EdgeInsets.all(10),
                ),
              ),
            );
          },
        ));
  }

  Future<bool> _refresh(BuildContext context) async {
    print("onRefresh");
    await Future.delayed(Duration(seconds: 0, milliseconds: 2000));
    BlocProvider.of<ClubSelectionBloc>(context).add(RefreshEvent());
    return true;
  }
}
