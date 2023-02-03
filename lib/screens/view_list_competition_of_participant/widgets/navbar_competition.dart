import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicec_mobi/models/enums/competition_scope_status.dart';
import '../../../bloc/view_list_competition_participant/view_list_competition_participant_bloc.dart';
import '../../../bloc/view_list_competition_participant/view_list_competition_participant_event.dart';
import '../../../bloc/view_list_competition_participant/view_list_competition_participant_state.dart';
import '../../../constants/theme.dart';

class NavbarCompetitionOfParticipant extends StatefulWidget
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

  NavbarCompetitionOfParticipant({
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
  _NavbarCompetitionOfParticipantState createState() =>
      _NavbarCompetitionOfParticipantState();

  @override
  Size get preferredSize => Size.fromHeight(_prefferedHeight);
}

class _NavbarCompetitionOfParticipantState
    extends State<NavbarCompetitionOfParticipant> {
  // late String activeTag;

  var _controller = TextEditingController();

  void initState() {
    // if (widget.tags != null && widget.tags?.length != 0) {
    //   activeTag = widget.tags![0];
    // }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool categories =
        widget.categoryOne.isNotEmpty && widget.categoryTwo.isNotEmpty;
    // &&
    // widget.categoryThree.isNotEmpty;

    final ViewListCompetitionParticipantBloc bloc =
        BlocProvider.of<ViewListCompetitionParticipantBloc>(context);

    return BlocBuilder<ViewListCompetitionParticipantBloc,
            ViewListCompetitionParticipantState>(
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
                  padding: const EdgeInsets.only(top: 5,left: 16.0, right: 16.0),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              // padding: const EdgeInsets.only(left: 5, right: 5),
                              child: Expanded(
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
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 10),
                              child: GestureDetector(
                                onTap: () {
                                  bloc.add(LoadingEvent());
                                  bloc.add(SearchEvent());
                                },
                                child: Icon(Icons.search),
                              ),
                            ),
                            PopupMenuButton<int>(
                                icon: Icon(Icons.filter_alt_outlined),
                                itemBuilder: (context) {
                                  return [
                                    PopupMenuItem(
                                      onTap: () {
                                        bloc.add(LoadingEvent());
                                        //add biến liên trường
                                        bloc.add(ChangeCompetitionScopeEvent(
                                            scope: CompetitionScopeStatus
                                                .InterUniversity));
                                      },
                                      value: 1,
                                      child: (state.scope ==
                                              CompetitionScopeStatus
                                                  .InterUniversity)
                                          ? Container(
                                              child: Row(
                                                children: <Widget>[
                                                  //Icon(Icons.camera, size: 18),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0),
                                                    child: Text('Liên Trường', style: TextStyle(color: Colors.orange[900]),),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : Row(
                                              children: <Widget>[
                                                //Icon(Icons.camera, size: 18),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: Text('Liên Trường'),
                                                ),
                                              ],
                                            ),
                                    ),
                                    PopupMenuItem(
                                      onTap: () {
                                        bloc.add(LoadingEvent());
                                        //add biến trong trường
                                        bloc.add(ChangeCompetitionScopeEvent(
                                            scope: CompetitionScopeStatus
                                                .University));
                                      },
                                      value: 2,
                                      child: (state.scope ==
                                              CompetitionScopeStatus.University)
                                          ? Container(
                                              child: Row(
                                                children: <Widget>[
                                                  //Icon(Icons.school, size: 18),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0),
                                                    child: Text('Trong Trường', style: TextStyle(color: Colors.orange[900]),),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : Row(
                                              children: <Widget>[
                                                //Icon(Icons.school, size: 18),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: Text('Trong Trường'),
                                                ),
                                              ],
                                            ),
                                    ),
                                    PopupMenuItem(
                                      onTap: () {
                                        bloc.add(LoadingEvent());
                                        //add biến trong trường
                                        bloc.add(ChangeCompetitionScopeEvent(
                                            scope:
                                                CompetitionScopeStatus.Club));
                                      },
                                      value: 3,
                                      child: (state.scope ==
                                              CompetitionScopeStatus.Club)
                                          ? Container(
                                              child: Row(
                                                children: <Widget>[
                                                  //Icon(Icons.group, size: 18),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0),
                                                    child: Text('Câu Lạc Bộ', style: TextStyle(color: Colors.orange[900]),),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : Row(
                                              children: <Widget>[
                                                //Icon(Icons.group, size: 18),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: Text('Câu Lạc Bộ'),
                                                ),
                                              ],
                                            ),
                                    ),
                                    PopupMenuItem(
                                      onTap: () {
                                        bloc.add(LoadingEvent());
                                        bloc.add(ResetFilterEvent());
                                        //làm cho đoạn search bị xóa đi
                                        _controller.text = "";
                                      },
                                      value: 4,
                                      child: Row(
                                        children: <Widget>[
                                          //Icon(Icons.access_time_sharp,
                                          //    size: 18),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Text('làm mới Filter'),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ];
                                }),
                          ],
                        ),
                      SizedBox(
                        height: 22.0,
                      ),
                      if (categories)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // GestureDetector(
                            //     onTap: () {
                            //       bloc.add(ChangeCompetitionScopeEvent(
                            //           scope: CompetitionScopeStatus
                            //               .InterUniversity));
                            //     },
                            //     child: Row(children: [
                            //       (state.scope ==
                            //               CompetitionScopeStatus
                            //                   .InterUniversity)
                            //           ? Container(
                            //               child: Row(children: [
                            //                 Icon(Icons.camera,
                            //                     color: ArgonColors.inputSuccess,
                            //                     size: 22.0),
                            //                 Text(widget.categoryOne,
                            //                     style: TextStyle(
                            //                         color: ArgonColors
                            //                             .inputSuccess,
                            //                         fontSize: 16.0))
                            //               ]),
                            //             )
                            //           : Container(
                            //               child: Row(children: [
                            //                 Icon(Icons.camera,
                            //                     color: ArgonColors.initial,
                            //                     size: 22.0),
                            //                 Text(widget.categoryOne,
                            //                     style: TextStyle(
                            //                         color: ArgonColors.initial,
                            //                         fontSize: 16.0))
                            //               ]),
                            //             ),
                            //     ])),
                            // GestureDetector(
                            //   onTap: () {
                            //     bloc.add(ChangeCompetitionScopeEvent(
                            //         scope: CompetitionScopeStatus.University));
                            //   },
                            //   child: Row(
                            //     children: [
                            //       (state.scope ==
                            //               CompetitionScopeStatus.University)
                            //           ? Container(
                            //               child: Row(children: [
                            //                 Icon(Icons.school,
                            //                     color: ArgonColors.inputSuccess,
                            //                     size: 22.0),
                            //                 Text(widget.categoryTwo,
                            //                     style: TextStyle(
                            //                         color: ArgonColors
                            //                             .inputSuccess,
                            //                         fontSize: 16.0))
                            //               ]),
                            //             )
                            //           : Container(
                            //               child: Row(children: [
                            //                 Icon(Icons.school,
                            //                     color: ArgonColors.initial,
                            //                     size: 22.0),
                            //                 Text(widget.categoryTwo,
                            //                     style: TextStyle(
                            //                         color: ArgonColors.initial,
                            //                         fontSize: 16.0))
                            //               ]),
                            //             ),
                            //     ],
                            //   ),
                            // ),
                            // GestureDetector(
                            //   onTap: () {
                            //     bloc.add(ChangeCompetitionScopeEvent(
                            //         scope: CompetitionScopeStatus.Club));
                            //   },
                            //   child: Row(
                            //     children: [
                            //       (state.scope == CompetitionScopeStatus.Club)
                            //           ? Container(
                            //               child: Row(children: [
                            //                 Icon(Icons.group,
                            //                     color: ArgonColors.inputSuccess,
                            //                     size: 22.0),
                            //                 Text(widget.categoryThree,
                            //                     style: TextStyle(
                            //                         color: ArgonColors
                            //                             .inputSuccess,
                            //                         fontSize: 16.0))
                            //               ]),
                            //             )
                            //           : Container(
                            //               child: Row(children: [
                            //                 Icon(Icons.group,
                            //                     color: ArgonColors.initial,
                            //                     size: 22.0),
                            //                 Text(widget.categoryThree,
                            //                     style: TextStyle(
                            //                         color: ArgonColors.initial,
                            //                         fontSize: 16.0))
                            //               ]),
                            //             ),
                            //     ],
                            //   ),
                            // )

                            GestureDetector(
                                onTap: () {
                                  bloc.add(LoadingEvent());
                                  bloc.add(ChangeValueEvent(isEvent: false));
                                },
                                child: Row(children: [
                                  (state.isEvent == false)
                                      ? Container(
                                          child: Row(children: [
                                            // Icon(Icons.camera,
                                            //     color: ArgonColors.inputSuccess,
                                            //     size: 22.0),
                                            Text(widget.categoryOne,
                                                style: TextStyle(
                                                    color: ArgonColors
                                                        .warning,
                                                    fontSize: 16.0))
                                          ]),
                                        )
                                      : Container(
                                          child: Row(children: [
                                            // Icon(Icons.camera,
                                            //     color: ArgonColors.initial,
                                            //     size: 22.0),
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
