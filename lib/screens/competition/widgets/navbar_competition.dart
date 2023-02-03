import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../../../bloc/competition/competition_bloc.dart';
import '../../../bloc/competition/competition_event.dart';
import '../../../bloc/competition/competition_state.dart';
import '../../../constants/theme.dart';
import '../../../models/enums/competition_scope_status.dart';
import '../../../utils/app_color.dart';

class NavbarCompetition extends StatefulWidget implements PreferredSizeWidget {
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

  NavbarCompetition({
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

class _NavbarCompetitionOfParticipantState extends State<NavbarCompetition> {
  var _controller = TextEditingController();

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool categories =
        widget.categoryOne.isNotEmpty && widget.categoryTwo.isNotEmpty;

    final CompetitionBloc bloc = BlocProvider.of<CompetitionBloc>(context);

    return BlocBuilder<CompetitionBloc, CompetitionState>(
        bloc: bloc,
        builder: (context, state) {
          return Container(
              decoration: BoxDecoration(
                  color:
                      !widget.transparent ? widget.bgColor : Colors.transparent,
                  //AppColors.mainColor,
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
                  padding:
                      const EdgeInsets.only(left: 16.0, right: 16.0, top: 10),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
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
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8.0),
                                                      child:
                                                          Text('Liên Trường', style: TextStyle(color: Colors.orange[900]),),
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
                                                CompetitionScopeStatus
                                                    .University)
                                            ? Container(
                                                child: Row(
                                                  children: <Widget>[
                                                    // Icon(Icons.school,
                                                    //     size: 18),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8.0),
                                                      child:
                                                          Text('Trong Trường', style: TextStyle(color: Colors.orange[900]),),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : Row(
                                                children: <Widget>[
                                                  // Icon(Icons.school, size: 18),
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
                                          bloc.add(ResetFilterEvent());
                                          //làm cho đoạn search bị xóa đi
                                          _controller.text = "";
                                        },
                                        value: 3,
                                        child: Row(
                                          children: <Widget>[
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
                                            Text(widget.categoryTwo,
                                                style: TextStyle(
                                                    color: ArgonColors.warning,
                                                    fontSize: 16.0))
                                          ]),
                                        )
                                      : Container(
                                          child: Row(children: [
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


// class NavbarCompetition extends StatefulWidget implements PreferredSizeWidget {
//   final String title;
//   final String categoryOne;
//   final String categoryTwo;
//   final bool searchBar;
//   final bool backButton;
//   final bool transparent;
//   final bool rightOptions;
//   final List<String>? tags;
//   final Function? getCurrentPage;
//   final bool isOnSearch;
//   final TextEditingController? searchController;
//   final Function? searchOnChanged;
//   final bool searchAutofocus;
//   final bool noShadow;
//   final Color bgColor;
//   final CompetitionBloc bloc;
//   // final CompetitionState state;

//   NavbarCompetition(
//       {this.title = "Competition",
//       this.categoryOne = "",
//       this.categoryTwo = "",
//       this.tags,
//       this.transparent = false,
//       this.rightOptions = true,
//       this.getCurrentPage,
//       this.searchController,
//       this.isOnSearch = false,
//       this.searchOnChanged,
//       this.searchAutofocus = false,
//       this.backButton = false,
//       this.noShadow = false,
//       this.bgColor = ArgonColors.white,
//       this.searchBar = false,
//       required this.bloc,
//       // required this.state
//       required Key key
//       }) : super(key:key);

//   final double _prefferedHeight = 180.0;

//   @override
//   _NavbarCompetitionState createState() => _NavbarCompetitionState();

//   @override
//   Size get preferredSize => Size.fromHeight(_prefferedHeight);
// }

// class _NavbarCompetitionState extends State<NavbarCompetition> {
//   late String activeTag;
//   CompetitionBloc get _bloc => widget.bloc;
//   // CompetitionBloc get _bloc => widget.bloc;
//   // CompetitionState get _state => widget.state;
  
//   var _controller = TextEditingController();

//   void initState() {
//     if (widget.tags != null && widget.tags?.length != 0) {
//       activeTag = widget.tags![0];
//     }
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // CompetitionBloc bloc = BlocProvider.of<CompetitionBloc>(context);
//     final bool categories =
//         widget.categoryOne.isNotEmpty && widget.categoryTwo.isNotEmpty;
//     // final bool tagsExist =
//     //     widget.tags == null ? false : (widget.tags?.length == 0 ? false : true);
//     String searchString = _bloc.state.requestModel?.name ?? '';
//     if (searchString != '') {
//       _controller = TextEditingController(text: searchString);
//     }

//     return Container(
//         // height: widget.searchBar
//         //     ? (!categories
//         //         ? (tagsExist ? 211.0 : 178.0)
//         //         : (tagsExist ? 262.0 : 210.0))
//         //     : (!categories
//         //         ? (tagsExist ? 162.0 : 102.0)
//         //         : (tagsExist ? 200.0 : 150.0)),
//         decoration: BoxDecoration(
//             color: !widget.transparent ? widget.bgColor : Colors.transparent,
//             boxShadow: [
//               BoxShadow(
//                   color: !widget.transparent && !widget.noShadow
//                       ? ArgonColors.initial
//                       : Colors.transparent,
//                   spreadRadius: -10,
//                   blurRadius: 12,
//                   offset: Offset(0, 5))
//             ]),
//         child: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.only(left: 16.0, right: 16.0),
//             child: Column(
//               children: [
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     IconButton(
//                         icon: Icon(
//                             !widget.backButton
//                                 ? Icons.menu
//                                 : Icons.arrow_back_ios,
//                             color: !widget.transparent
//                                 ? (widget.bgColor == ArgonColors.white
//                                     ? ArgonColors.initial
//                                     : ArgonColors.white)
//                                 : ArgonColors.white,
//                             size: 24.0),
//                         onPressed: () {
//                           if (!widget.backButton)
//                             Scaffold.of(context).openDrawer();
//                           else
//                             Navigator.pop(context);
//                         }),
//                     Text(widget.title,
//                         style: TextStyle(
//                             color: !widget.transparent
//                                 ? (widget.bgColor == ArgonColors.white
//                                     ? ArgonColors.initial
//                                     : ArgonColors.white)
//                                 : ArgonColors.white,
//                             fontWeight: FontWeight.w600,
//                             fontSize: 18.0)),
//                   ],
//                 ),

//                 if (widget.searchBar)
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Expanded(
//                         // child: Input(
//                         //     placeholder: "Tìm Kiếm Cuộc Thi",
//                         //     controller: widget.searchController,
//                         //     onChanged: widget.searchOnChanged,
//                         //     // autofocus: widget.searchAutofocus,
//                         //     // suffixIcon:
//                         //     //     Icon(Icons.zoom_in, color: ArgonColors.muted, size: 10),
//                         //     onTap: () {
//                         //       Log.info('OnTap search bar: ');
//                         //       // Navigator.pushNamed(context, '/pro');
//                         //     },
//                         //     prefixIcon: Icon(Icons.design_services_sharp)),
//                         child: TextFormField(
//                             controller: _controller,
//                             onFieldSubmitted: (value) {
//                               print('hello onFieldSubmitted');
//                             },
//                             autofocus: false,
//                             decoration: InputDecoration(
//                               suffixIcon: IconButton(
//                                   onPressed: _controller.clear,
//                                   icon: const Icon(Icons.clear)),
//                               labelText: 'Tìm Kiếm Cuộc Thi',
//                               focusedBorder: const OutlineInputBorder(
//                                 borderSide: BorderSide(
//                                   color: Colors.grey,
//                                 ),                                
//                               ),
//                               enabledBorder: OutlineInputBorder(
//                                 borderSide:
//                                     BorderSide(color: Colors.grey, width: 1.0),
//                               ),
//                             )),
//                       ),
//                       PopupMenuButton<int>(
//                           icon: Icon(Icons.filter_alt_outlined),
//                           itemBuilder: (context) {
//                             return [
//                               PopupMenuItem(
//                                 onTap: () {},
//                                 value: 1,
//                                 child: Row(
//                                   children: <Widget>[
//                                     Icon(Icons.access_time_sharp, size: 18),
//                                     Padding(
//                                       padding: const EdgeInsets.only(left: 8.0),
//                                       child: Text('Ngày gần nhất'),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               PopupMenuItem(
//                                 onTap: () {},
//                                 value: 2,
//                                 child: Row(
//                                   children: <Widget>[
//                                     Icon(Icons.delete, size: 18),
//                                     Padding(
//                                       padding: const EdgeInsets.only(left: 8.0),
//                                       child: Text('Mới nhất'),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ];
//                           }),
//                     ],
//                   ),

//                 SizedBox(
//                   height: 22.0,
//                 ),

//                 if (categories)
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       GestureDetector(
//                         onTap: () {
//                           //Navigator.pushNamed(context, '/pro');
//                         },
//                         child: Row(
//                           children: [
//                             Icon(Icons.camera,
//                                 color: ArgonColors.initial, size: 22.0),
//                             SizedBox(width: 10),
//                             Text(widget.categoryOne,
//                                 style: TextStyle(
//                                     color: ArgonColors.initial,
//                                     fontSize: 16.0)),
//                           ],
//                         ),
//                       ),
//                       Container(
//                         color: ArgonColors.initial,
//                         height: 25,
//                         width: 1,
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           //Navigator.pushNamed(context, '/pro');
//                         },
//                         child: Row(
//                           children: [
//                             Icon(Icons.school,
//                                 color: ArgonColors.initial, size: 22.0),
//                             SizedBox(width: 10),
//                             Text(widget.categoryTwo,
//                                 style: TextStyle(
//                                     color: ArgonColors.initial,
//                                     fontSize: 16.0)),
//                           ],
//                         ),
//                       )
//                     ],
//                   ),               
//               ],
//             ),
//           ),
//         ));
//   }
// }
