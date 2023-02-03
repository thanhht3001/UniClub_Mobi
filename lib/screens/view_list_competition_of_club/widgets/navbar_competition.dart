import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../bloc/view_list_competition_of_club/view_list_competition_of_club_bloc.dart';
import '../../../bloc/view_list_competition_of_club/view_list_competition_of_club_event.dart';
import '../../../bloc/view_list_competition_of_club/view_list_competition_of_club_state.dart';
import '../../../constants/theme.dart';
import '../../../models/enums/competition_scope_status.dart';

class NavbarCompetitionOfClub extends StatefulWidget
    implements PreferredSizeWidget {
  final String title;
  final String categoryOne;
  final String categoryTwo;
  //final String categoryThree;
  final bool searchBar;
  final bool backButton;
  final bool transparent;
  final bool rightOptions;
  final List<String>? tags;
  final Function? getCurrentPage;
  final bool isOnSearch;
  final TextEditingController? searchController;
  final Function? searchOnChanged;
  final bool searchAutofocus;
  final bool noShadow;
  final Color bgColor;

  NavbarCompetitionOfClub({
    this.title = "Competition",
    this.categoryOne = "",
    this.categoryTwo = "",
    //this.categoryThree = "",
    this.tags,
    this.transparent = false,
    this.rightOptions = true,
    this.getCurrentPage,
    this.searchController,
    this.isOnSearch = false,
    this.searchOnChanged,
    this.searchAutofocus = false,
    this.backButton = false,
    this.noShadow = false,
    this.bgColor = ArgonColors.white,
    this.searchBar = false,
  });

  final double _prefferedHeight = 180.0;

  @override
  _NavbarCompetitionOfClubState createState() =>
      _NavbarCompetitionOfClubState();

  @override
  Size get preferredSize => Size.fromHeight(_prefferedHeight);
}

class _NavbarCompetitionOfClubState extends State<NavbarCompetitionOfClub> {
  var _controller = TextEditingController();

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool categories =
        widget.categoryOne.isNotEmpty && widget.categoryTwo.isNotEmpty;

    final ViewListCompetitionOfClubBloc bloc =
        BlocProvider.of<ViewListCompetitionOfClubBloc>(context);

    return BlocBuilder<ViewListCompetitionOfClubBloc,
            ViewListCompetitionOfClubState>(
        bloc: bloc,
        builder: (context, state) {
          return Container(
              decoration: BoxDecoration(
                  color:
                      !widget.transparent ? widget.bgColor : Colors.transparent,
                  boxShadow: [
                    BoxShadow(
                        color: !widget.transparent && !widget.noShadow
                            ? ArgonColors.initial
                            : Colors.transparent,
                        spreadRadius: -10,
                        blurRadius: 12,
                        offset: Offset(0, 5))
                  ]),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                              icon: Icon(Icons.arrow_back_ios,
                                  color: !widget.transparent
                                      ? (widget.bgColor == ArgonColors.white
                                          ? ArgonColors.initial
                                          : ArgonColors.white)
                                      : ArgonColors.white,
                                  size: 24.0),
                              onPressed: () {
                                Navigator.pop(context);
                              }),
                          Text(widget.title,
                              style: TextStyle(
                                  color: !widget.transparent
                                      ? (widget.bgColor == ArgonColors.white
                                          ? ArgonColors.initial
                                          : ArgonColors.white)
                                      : ArgonColors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20.0)),
                        ],
                      ),
                      if (widget.searchBar)
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: TextFormField(
                                      controller: _controller,
                                      onFieldSubmitted: (value) {
                                        bloc.add(ChangeSearchNameEvent(
                                            searchName: value));
                                      },
                                      autofocus: false,
                                      decoration: InputDecoration(
                                        suffixIcon: IconButton(
                                            onPressed: () {
                                              _controller.clear;
                                              _controller.text = "";
                                              //sửa lại cái
                                              bloc.add(ChangeSearchNameEvent(
                                                  searchName: null));
                                            },
                                            icon: const Icon(Icons.clear)),
                                        labelText: (state.isEvent == false)
                                            ? 'Tìm kiếm theo tên Cuộc Thi'
                                            : 'Tìm kiếm theo tên Sự Kiện',
                                        focusedBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
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
                                    child: Icon(Icons.search),
                                  ),
                                ),
                              ]),
                        ),
                      SizedBox(
                        height: 22.0,
                      ),
                      if (categories)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  bloc.add(LoadingEvent());
                                  //
                                  bloc.add(ChangeValueEvent(isEvent: false));
                                },
                                child: Row(children: [
                                  (state.isEvent == false)
                                      ? Container(
                                          child: Row(children: [
                                            Text(widget.categoryOne,
                                                style: TextStyle(
                                                    color: ArgonColors
                                                        .warning,
                                                    fontSize: 16.0))
                                          ]),
                                        )
                                      : Container(
                                          child: Row(children: [
                                            Text(widget.categoryOne,
                                                style: TextStyle(
                                                    color: ArgonColors.initial,
                                                    fontSize: 16.0))
                                          ]),
                                        ),
                                ])),
                            Container(
                              color: ArgonColors.initial,
                              height: 25,
                              width: 1,
                            ),
                            GestureDetector(
                              onTap: () {
                                bloc.add(LoadingEvent());
                                bloc.add(ChangeValueEvent(isEvent: true));
                              },
                              child: Row(
                                children: [
                                  ((state.isEvent == true))
                                      ? Container(
                                          child: Row(children: [
                                            // Icon(Icons.school,
                                            //     color: ArgonColors.inputSuccess,
                                            //     size: 22.0),
                                            Text(widget.categoryTwo,
                                                style: TextStyle(
                                                    color: ArgonColors
                                                        .warning,
                                                    fontSize: 16.0))
                                          ]),
                                        )
                                      : Container(
                                          child: Row(children: [
                                            // Icon(Icons.school,
                                            //     color: ArgonColors.initial,
                                            //     size: 22.0),
                                            Text(widget.categoryTwo,
                                                style: TextStyle(
                                                    color: ArgonColors.initial,
                                                    fontSize: 16.0))
                                          ]),
                                        ),
                                ],
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ));
        });
  }
}
