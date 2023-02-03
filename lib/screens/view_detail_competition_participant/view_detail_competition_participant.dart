// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_html/flutter_html.dart';
// import 'package:get_it/get_it.dart';
// import 'package:unicec_mobi/models/common/current_user.dart';
// import 'package:unicec_mobi/models/enums/competition_scope_status.dart';
//
// import '../../bloc/competition/competition_bloc.dart';
// import '../../bloc/competition/competition_state.dart';
// import '../../constants/Theme.dart';
// import '../../utils/app_color.dart';
// import '../../utils/loading.dart';
// import '../../utils/log.dart';
// import '../../utils/router.dart';
// import '../size_config.dart';
// import '../widgets/drawer.dart';
//
// class DetailCompetitionPage extends StatefulWidget {
//   final CompetitionBloc bloc;
//
//   DetailCompetitionPage({required this.bloc});
//
//   @override
//   _DetailCompetitionPageState createState() => _DetailCompetitionPageState();
// }
//
// class _DetailCompetitionPageState extends State<DetailCompetitionPage> {
//   CompetitionBloc get _bloc => widget.bloc;
//
//   void initState() {
//     super.initState();
//   }
//
//   String switchScope() {
//     if (_bloc.state.competitionDetail?.scope != null) {
//       CompetitionScopeStatus? scope = _bloc.state.competitionDetail?.scope;
//       switch (scope) {
//         case CompetitionScopeStatus.InterUniversity:
//           return 'Trong Trường';
//         case CompetitionScopeStatus.University:
//           return 'Liên Trường';
//         case CompetitionScopeStatus.Club:
//           return 'Câu lạc bộ';
//         default:
//           return '';
//       }
//     }
//
//     return '';
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     print('detailCompetitionPage - isloading: ${_bloc.isLoading}');
//     var universityName = GetIt.I.get<CurrentUser>().universityName;
//     var sponsors = _bloc.state.competitionDetail?.competitionEntities
//         .where((element) => element.entityTypeId == 2) ??
//         [];
//
//     return BlocBuilder<CompetitionBloc, CompetitionState>(
//         bloc: _bloc,
//         builder: (context, state) {
//           return (_bloc.isLoading)
//               ? Loading()
//               : Scaffold(
//               extendBodyBehindAppBar: true,
//               appBar: AppBar(
//                 leading: IconButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   icon: Icon(Icons.arrow_back_ios, color: Colors.black),
//                 ),
//                 title: const Text("Chi tiết",
//                     style: TextStyle(color: Colors.black, fontSize: 23)),
//                 automaticallyImplyLeading: false,
//                 centerTitle: true,
//                 backgroundColor: AppColors.backgroundPageColor,
//               ),
//               drawer: ArgonDrawer(currentPage: "Competition Detail"),
//               body: Stack(children: <Widget>[
//                 SafeArea(
//                   child: ListView(children: [
//                     Padding(
//                       padding: const EdgeInsets.only(left: 0.0, right: 0.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.stretch,
//                         children: [
//                           Stack(children: <Widget>[
//                             Container(
//                               decoration: BoxDecoration(
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Colors.grey.withOpacity(0.1),
//                                     spreadRadius: 1,
//                                     blurRadius: 7,
//                                     offset: Offset(
//                                         0, 3), // changes position of shadow
//                                   ),
//                                 ],
//                               ),
//                               child: Card(
//                                   semanticContainer: true,
//                                   clipBehavior: Clip.antiAliasWithSaveLayer,
//                                   elevation: .0,
//                                   shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.all(
//                                           Radius.circular(5.0))),
//                                   child: Padding(
//                                     padding: const EdgeInsets.only(
//                                         top: 0,
//                                         bottom: 10.0,
//                                         left: 10.0,
//                                         right: 10.0),
//                                     child: Row(
//                                       children: [
//                                         Expanded(
//                                           child: Column(
//                                             children: [
//                                               //Image(image: Image.network("https://img.freepik.com/premium-photo/astronaut-outer-open-space-planet-earth-stars-provide-background-erforming-space-planet-earth-sunrise-sunset-our-home-iss-elements-this-image-furnished-by-nasa_150455-16829.jpg?w=2000"))
//                                               SizedBox(height: 10.0),
//                                               Row(
//                                                 children: [
//                                                   (_bloc.state.competitionDetail
//                                                       ?.clubsInCompetition
//                                                       .where((element) =>
//                                                   element
//                                                       .isOwner ==
//                                                       true)
//                                                       .first
//                                                       .image
//                                                       .isNotEmpty) !=
//                                                       null
//                                                       ? Padding(
//                                                     padding:
//                                                     const EdgeInsets
//                                                         .fromLTRB(
//                                                         6.0,
//                                                         2.0,
//                                                         10.0,
//                                                         2.0),
//                                                     child: Container(
//                                                         width: 48,
//                                                         height: 48,
//                                                         child: CircleAvatar(
//                                                             backgroundImage:
//                                                             NetworkImage(
//                                                                 '${_bloc.state.competitionDetail?.clubsInCompetition.where((element) => element.isOwner == true).first.image}'))),
//                                                   )
//                                                       : const SizedBox
//                                                       .shrink(),
//                                                   Text(
//                                                     "${_bloc.state.competitionDetail?.clubsInCompetition.where((element) => element.isOwner == true).first.name}",
//                                                     style: TextStyle(
//                                                         fontSize: 18,
//                                                         fontWeight:
//                                                         FontWeight
//                                                             .bold),
//                                                   ),
//                                                   Expanded(
//                                                       child: SizedBox(
//                                                           width:
//                                                           getProportionateScreenWidth(
//                                                               10))),
//                                                   Container(
//                                                     margin: const EdgeInsets
//                                                         .all(15.0),
//                                                     padding:
//                                                     const EdgeInsets
//                                                         .all(3.0),
//                                                     decoration: BoxDecoration(
//                                                         border: Border.all(
//                                                             color: Colors
//                                                                 .green),
//                                                         color: Colors.green,
//                                                         borderRadius:
//                                                         BorderRadius
//                                                             .all(Radius
//                                                             .circular(
//                                                             10))),
//                                                     child: Text(
//                                                         (_bloc.state.competitionDetail
//                                                             ?.fee) !=
//                                                             null &&
//                                                             (_bloc
//                                                                 .state
//                                                                 .competitionDetail
//                                                                 ?.fee)! >
//                                                                 0
//                                                             ? '${_bloc.state.competitionDetail?.fee} VNĐ'
//                                                             : "Không thu phí",
//                                                         style:
//                                                         const TextStyle(
//                                                           color:
//                                                           Colors.white,
//                                                           fontSize: 18,
//                                                         )),
//                                                   ),
//                                                 ],
//                                               ),
//                                               const SizedBox(height: 10.0),
//                                               Padding(
//                                                 padding:
//                                                 const EdgeInsets.only(
//                                                     left: 10,
//                                                     right: 10),
//                                                 child: Align(
//                                                   child: Text(
//                                                       "${_bloc.state.competitionDetail?.name}",
//                                                       style:
//                                                       const TextStyle(
//                                                           color: Color
//                                                               .fromRGBO(
//                                                               50,
//                                                               50,
//                                                               93,
//                                                               1),
//                                                           fontSize:
//                                                           28.0)),
//                                                 ),
//                                               ),
//                                               SizedBox(height: 5.0),
//                                               Padding(
//                                                 padding:
//                                                 const EdgeInsets.only(
//                                                     right: 10,
//                                                     left: 10),
//                                                 child: Row(
//                                                   children: [
//                                                     Text(
//                                                         "@${_bloc.state.competitionDetail?.competitionTypeName}",
//                                                         style: const TextStyle(
//                                                             color:
//                                                             ArgonColors
//                                                                 .warning,
//                                                             fontSize: 18)),
//                                                     const SizedBox(
//                                                       width: 20,
//                                                     ),
//                                                     const Text(
//                                                         "@" + "Nhạc cụ",
//                                                         style: TextStyle(
//                                                             color:
//                                                             ArgonColors
//                                                                 .warning,
//                                                             fontSize: 18)),
//                                                   ],
//                                                 ),
//                                               ),
//                                               const SizedBox(height: 10.0),
//                                               (_bloc.state.competitionDetail
//                                                   ?.competitionEntities
//                                                   .where((element) =>
//                                               element
//                                                   .entityTypeId ==
//                                                   1)
//                                                   .first
//                                                   .imageUrl !=
//                                                   null)
//                                                   ? Image.network(
//                                                   '${_bloc.state.competitionDetail?.competitionEntities.where((element) => element.entityTypeId == 1).first.imageUrl}')
//                                                   : const SizedBox.shrink(),
//                                               const SizedBox(height: 5.0),
//                                               (_bloc.state.competitionDetail
//                                                   ?.majorsInCompetition !=
//                                                   null &&
//                                                   (_bloc
//                                                       .state
//                                                       .competitionDetail
//                                                       ?.majorsInCompetition
//                                                       .length)! >
//                                                       0)
//                                                   ? Row(
//                                                 children: [
//                                                   SizedBox(
//                                                     height: 100.0,
//                                                     child: ListView
//                                                         .builder(
//                                                         scrollDirection:
//                                                         Axis
//                                                             .horizontal,
//                                                         shrinkWrap:
//                                                         true,
//                                                         itemCount: _bloc
//                                                             .state
//                                                             .competitionDetail
//                                                             ?.majorsInCompetition
//                                                             .length,
//                                                         itemBuilder:
//                                                             (context,
//                                                             index) {
//                                                           return Container(
//                                                             margin:
//                                                             const EdgeInsets.all(15.0),
//                                                             padding:
//                                                             const EdgeInsets.all(3.0),
//                                                             decoration: BoxDecoration(
//                                                                 border: Border.all(color: Colors.orangeAccent),
//                                                                 color: Colors.orangeAccent,
//                                                                 borderRadius: BorderRadius.all(Radius.circular(10))),
//                                                             child: Text(
//                                                                 '${state.competitionDetail?.majorsInCompetition[index].name}',
//                                                                 style: const TextStyle(
//                                                                   color: Colors.white,
//                                                                   fontSize: 18,
//                                                                 )),
//                                                           );
//                                                         }),
//                                                   )
//                                                 ],
//                                               )
//                                                   : Container(
//                                                 padding: EdgeInsets
//                                                     .symmetric(
//                                                     vertical:
//                                                     10.0),
//                                                 alignment: Alignment
//                                                     .centerLeft,
//                                                 child: const Text(
//                                                   'Toàn bộ các ngành',
//                                                   style: TextStyle(
//                                                       color: Colors
//                                                           .orange,
//                                                       fontSize: 20.0),
//                                                   textAlign:
//                                                   TextAlign.left,
//                                                 ),
//                                               ),
//                                               Padding(
//                                                 padding:
//                                                 const EdgeInsets.only(
//                                                     left: 10.0,
//                                                     right: 10.0),
//                                                 child: Row(
//                                                   children: [
//                                                     Icon(
//                                                         Icons
//                                                             .calendar_today_outlined,
//                                                         size: 23,
//                                                         color:
//                                                         Colors.orange),
//                                                     SizedBox(width: 10.0),
//                                                     Text(
//                                                       "${_bloc.state.competitionDetail?.startTime}",
//                                                       style: TextStyle(
//                                                           fontSize: 18),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                               SizedBox(height: 10.0),
//                                               Padding(
//                                                 padding:
//                                                 const EdgeInsets.only(
//                                                     left: 10.0,
//                                                     right: 10.0),
//                                                 child: Row(
//                                                   children: [
//                                                     Icon(
//                                                       Icons
//                                                           .add_location_rounded,
//                                                       size: 23,
//                                                       color: Colors.orange,
//                                                     ),
//                                                     SizedBox(width: 10.0),
//                                                     Expanded(
//                                                         child: Text(
//                                                           "${_bloc.state.competitionDetail?.addressName} - ${_bloc.state.competitionDetail?.address}",
//                                                           style: TextStyle(
//                                                               fontSize: 18),
//                                                         )),
//                                                   ],
//                                                 ),
//                                               ),
//                                               SizedBox(height: 10.0),
//                                               Padding(
//                                                 padding:
//                                                 const EdgeInsets.only(
//                                                     left: 10,
//                                                     right: 10),
//                                                 child: Row(
//                                                   children: [
//                                                     Icon(
//                                                       Icons
//                                                           .account_balance_sharp,
//                                                       size: 23,
//                                                       color: Colors.orange,
//                                                     ),
//                                                     SizedBox(width: 10.0),
//                                                     Expanded(
//                                                         child: Text(
//                                                           switchScope(),
//                                                           style: TextStyle(
//                                                               fontSize: 18),
//                                                         )),
//                                                   ],
//                                                 ),
//                                               ),
//                                               Divider(
//                                                 height: 40.0,
//                                                 thickness: 1.5,
//                                                 indent: 32.0,
//                                                 endIndent: 32.0,
//                                               ),
//                                               Padding(
//                                                 padding:
//                                                 const EdgeInsets.only(
//                                                     left: 10.0,
//                                                     right: 10),
//                                                 child: Row(
//                                                   children: [
//                                                     Expanded(
//                                                         child: Html(
//                                                           data: _bloc
//                                                               .state
//                                                               .competitionDetail
//                                                               ?.content,
//                                                           tagsList: Html.tags,
//                                                           style: {
//                                                             "p": Style(
//                                                                 fontSize:
//                                                                 const FontSize(
//                                                                     18.0)),
//                                                             "em": Style(
//                                                                 fontStyle:
//                                                                 FontStyle
//                                                                     .italic),
//                                                             "strong": Style(
//                                                                 fontWeight:
//                                                                 FontWeight
//                                                                     .bold),
//                                                             "a": Style(
//                                                                 textDecoration:
//                                                                 TextDecoration
//                                                                     .underline,
//                                                                 color: Colors
//                                                                     .blueAccent),
//                                                             // "ul": Wrap()
//                                                             "li": Style(
//                                                                 fontSize:
//                                                                 const FontSize(
//                                                                     15.0))
//                                                           },
//                                                           // onLinkTap: (url, _, _){
//                                                           //   print('Open with url: $url ...');
//                                                           // },
//                                                           onCssParseError:
//                                                               (css, messages) {
//                                                             Log.error(
//                                                                 'css that errored: $css');
//                                                             Log.error(
//                                                                 'error messages: ');
//                                                             messages.forEach(
//                                                                     (element) {
//                                                                   Log.error(
//                                                                       '$element');
//                                                                 });
//                                                           },
//                                                         )),
//                                                   ],
//                                                 ),
//                                               ),
//                                               SizedBox(height: 10.0),
//                                               Padding(
//                                                 padding:
//                                                 const EdgeInsets.only(
//                                                     left: 10.0,
//                                                     right: 10.0),
//                                                 child: Row(
//                                                   children: const [
//                                                     Expanded(
//                                                       child: Text(
//                                                         "Các câu lạc bộ tham gia tổ chức",
//                                                         style: TextStyle(
//                                                             fontSize: 18,
//                                                             fontWeight:
//                                                             FontWeight
//                                                                 .bold),
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                               (_bloc
//                                                   .state
//                                                   .competitionDetail
//                                                   ?.clubsInCompetition
//                                                   .length)! >
//                                                   0
//                                                   ? Padding(
//                                                 padding:
//                                                 const EdgeInsets
//                                                     .symmetric(
//                                                     horizontal:
//                                                     10.0),
//                                                 child: Row(
//                                                   children: [
//                                                     SizedBox(
//                                                       height: 100.0,
//                                                       child: ListView
//                                                           .builder(
//                                                           scrollDirection:
//                                                           Axis
//                                                               .horizontal,
//                                                           shrinkWrap:
//                                                           true,
//                                                           itemCount: _bloc
//                                                               .state
//                                                               .competitionDetail
//                                                               ?.clubsInCompetition
//                                                               .length,
//                                                           itemBuilder:
//                                                               (context,
//                                                               index) {
//                                                             return Container(
//                                                                 width: 48,
//                                                                 height: 48,
//                                                                 child: ((_bloc.state.competitionDetail?.clubsInCompetition[index].image)! != '')
//                                                                     ? CircleAvatar(backgroundImage: NetworkImage("${_bloc.state.competitionDetail?.clubsInCompetition[index].image}"))
//                                                                     : Text(
//                                                                   '${_bloc.state.competitionDetail?.clubsInCompetition[index].name}',
//                                                                   style: const TextStyle(fontSize: 15.0),
//                                                                 ));
//                                                           }),
//                                                     )
//                                                   ],
//                                                 ),
//                                               )
//                                                   : Text(
//                                                   'Đồng tổ chức bởi các CLB trường $universityName'),
//                                               Padding(
//                                                 padding:
//                                                 const EdgeInsets.only(
//                                                     left: 10.0,
//                                                     right: 10.0),
//                                                 child: Row(
//                                                   children: const [
//                                                     Expanded(
//                                                       child: Text(
//                                                         "Ban giám khảo",
//                                                         style: TextStyle(
//                                                             fontSize: 18,
//                                                             fontWeight:
//                                                             FontWeight
//                                                                 .bold),
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                               ((_bloc
//                                                   .state
//                                                   .competitionDetail
//                                                   ?.competitionEntities
//                                                   .length)! >
//                                                   0)
//                                                   ? Padding(
//                                                 padding:
//                                                 const EdgeInsets
//                                                     .only(
//                                                     left: 10.0,
//                                                     right: 10.0),
//                                                 child: Row(
//                                                   children: [
//                                                     SizedBox(
//                                                       height: 100.0,
//                                                       child: ListView
//                                                           .builder(
//                                                           scrollDirection:
//                                                           Axis
//                                                               .horizontal,
//                                                           shrinkWrap:
//                                                           true,
//                                                           itemCount: _bloc
//                                                               .state
//                                                               .competitionDetail
//                                                               ?.clubsInCompetition
//                                                               .length,
//                                                           itemBuilder:
//                                                               (context,
//                                                               index) {
//                                                             return Container(
//                                                                 width: 48,
//                                                                 height: 48,
//                                                                 child: ((_bloc.state.competitionDetail?.clubsInCompetition[index].image)! != '')
//                                                                     ? CircleAvatar(backgroundImage: NetworkImage("${_bloc.state.competitionDetail?.clubsInCompetition[index].image}"))
//                                                                     : Text(
//                                                                   '${_bloc.state.competitionDetail?.clubsInCompetition[index].name}',
//                                                                   style: const TextStyle(fontSize: 15.0),
//                                                                 ));
//                                                           }),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               )
//                                                   : Text(
//                                                   'Ban tổ chức cuộc thi trường $universityName'),
//                                               Padding(
//                                                 padding:
//                                                 const EdgeInsets.only(
//                                                     left: 10.0,
//                                                     right: 10.0,
//                                                     top: 10),
//                                                 child: Row(
//                                                   children: [
//                                                     Expanded(
//                                                       child: Text(
//                                                         "Các đơn vị tài trợ",
//                                                         style: TextStyle(
//                                                             fontSize: 18,
//                                                             fontWeight:
//                                                             FontWeight
//                                                                 .bold),
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                               (sponsors.length > 0)
//                                                   ? Padding(
//                                                 padding:
//                                                 const EdgeInsets
//                                                     .only(
//                                                     left: 10.0,
//                                                     right: 10.0),
//                                                 child: Row(children: [
//                                                   SizedBox(
//                                                     height: 100.0,
//                                                     child: ListView
//                                                         .builder(
//                                                         scrollDirection:
//                                                         Axis
//                                                             .horizontal,
//                                                         shrinkWrap:
//                                                         true,
//                                                         itemCount:
//                                                         sponsors
//                                                             .length,
//                                                         itemBuilder:
//                                                             (context,
//                                                             index) {
//                                                           return Container(
//                                                               width:
//                                                               100.0,
//                                                               height:
//                                                               100.0,
//                                                               padding: const EdgeInsets.fromLTRB(
//                                                                   6.0,
//                                                                   2.0,
//                                                                   10.0,
//                                                                   2.0),
//                                                               child:
//                                                               CircleAvatar(backgroundImage: NetworkImage("${sponsors.elementAt(index).imageUrl}")));
//                                                         }),
//                                                   ),
//                                                 ]),
//                                               )
//                                                   : Text(
//                                                   'Ban tổ chức trường $universityName'),
//                                               Padding(
//                                                 padding:
//                                                 const EdgeInsets.only(
//                                                     bottom: 8.0),
//                                                 child: Row(
//                                                   mainAxisAlignment:
//                                                   MainAxisAlignment
//                                                       .spaceAround,
//                                                   children: [
//                                                     Container(
//                                                       // width: 0,
//                                                       height: 36,
//                                                       child: RaisedButton(
//                                                           textColor:
//                                                           ArgonColors
//                                                               .primary,
//                                                           color: ArgonColors
//                                                               .secondary,
//                                                           onPressed: () {
//                                                             //chuyển sang trang list team
//                                                             Navigator.of(
//                                                                 context)
//                                                                 .pushNamed(
//                                                                 Routes
//                                                                     .viewListTeamStudent,
//                                                                 arguments:
//                                                                 state.selectedCompetitionId);
//                                                           },
//                                                           shape: RoundedRectangleBorder(
//                                                               borderRadius:
//                                                               BorderRadius
//                                                                   .circular(
//                                                                   4)),
//                                                           child: Padding(
//                                                               padding: EdgeInsets.only(
//                                                                   bottom:
//                                                                   10,
//                                                                   top: 10,
//                                                                   left: 14,
//                                                                   right:
//                                                                   14),
//                                                               child: Row(
//                                                                 mainAxisAlignment:
//                                                                 MainAxisAlignment
//                                                                     .spaceAround,
//                                                                 children: [
//                                                                   Icon(
//                                                                       Icons
//                                                                           .description,
//                                                                       size:
//                                                                       13),
//                                                                   SizedBox(
//                                                                     width:
//                                                                     5,
//                                                                   ),
//                                                                   Text(
//                                                                       "Các đội tham gia",
//                                                                       style: TextStyle(
//                                                                           fontWeight: FontWeight.w600,
//                                                                           fontSize: 15))
//                                                                 ],
//                                                               ))),
//                                                     ),
//                                                     Container(
//                                                       // width: 0,
//                                                       height: 36,
//                                                       child: RaisedButton(
//                                                           textColor:
//                                                           ArgonColors
//                                                               .primary,
//                                                           color: ArgonColors
//                                                               .secondary,
//                                                           onPressed: () {
//                                                             Navigator.pushNamed(
//                                                                 context,
//                                                                 '/viewListActivity');
//                                                           },
//                                                           shape: RoundedRectangleBorder(
//                                                               borderRadius:
//                                                               BorderRadius
//                                                                   .circular(
//                                                                   4)),
//                                                           child: Padding(
//                                                               padding: EdgeInsets
//                                                                   .only(
//                                                                   bottom:
//                                                                   10,
//                                                                   top:
//                                                                   10,
//                                                                   left:
//                                                                   8,
//                                                                   right:
//                                                                   8),
//                                                               child: Row(
//                                                                 mainAxisAlignment:
//                                                                 MainAxisAlignment
//                                                                     .spaceAround,
//                                                                 children: [
//                                                                   Icon(
//                                                                       Icons
//                                                                           .description,
//                                                                       size:
//                                                                       13),
//                                                                   SizedBox(
//                                                                     width:
//                                                                     5,
//                                                                   ),
//                                                                   Text(
//                                                                       "Danh sách vòng thi",
//                                                                       style: TextStyle(
//                                                                           fontWeight: FontWeight.w600,
//                                                                           fontSize: 15))
//                                                                 ],
//                                                               ))),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                               Container(
//                                                 margin:
//                                                 const EdgeInsets.all(
//                                                     15.0),
//                                                 padding:
//                                                 const EdgeInsets.all(
//                                                     3.0),
//                                                 decoration: BoxDecoration(
//                                                     border: Border.all(
//                                                         color: Colors.red),
//                                                     color: Colors.red,
//                                                     borderRadius:
//                                                     BorderRadius.all(
//                                                         Radius.circular(
//                                                             10))),
//                                                 child: Text(
//                                                     "Hạn cuối đăng ký: ${_bloc.state.competitionDetail?.endTimeRegister}",
//                                                     style: TextStyle(
//                                                       color: Colors.white,
//                                                       fontSize: 18,
//                                                     )),
//                                               ),
//                                               Padding(
//                                                 padding:
//                                                 const EdgeInsets.only(
//                                                     right: 10,
//                                                     left: 10),
//                                                 child: Row(
//                                                   children: [
//                                                     Text("",
//                                                         style: TextStyle(
//                                                             color:
//                                                             ArgonColors
//                                                                 .warning,
//                                                             fontSize: 18)),
//                                                     Expanded(
//                                                         child: SizedBox(
//                                                           width: 20,
//                                                         )),
//                                                     Text(
//                                                         "${_bloc.state.competitionDetail?.view} lượt xem",
//                                                         style: TextStyle(
//                                                             color:
//                                                             Colors.grey,
//                                                             fontSize: 15)),
//                                                   ],
//                                                 ),
//                                               ),
//                                               Padding(
//                                                 padding:
//                                                 const EdgeInsets.only(
//                                                     top: 16),
//                                                 child: Container(
//                                                   width: double.infinity,
//                                                   margin:
//                                                   new EdgeInsets.only(
//                                                       right: 15,
//                                                       left: 15,
//                                                       bottom: 15),
//                                                   child: FlatButton(
//                                                     textColor:
//                                                     ArgonColors.white,
//                                                     color: ArgonColors.warning,
//                                                     onPressed: () {
//                                                       // Respond to button press
//                                                       showDialog(
//                                                           context: context,
//                                                           builder: (BuildContext context) {
//                                                             return AlertDialog(
//                                                               shape: RoundedRectangleBorder(
//                                                                   borderRadius: BorderRadius.all(
//                                                                       Radius.circular(10))),
//                                                               scrollable: true,
//                                                               title: Container(
//                                                                   child: Text(
//                                                                     'Nhập mã điểm danh',
//                                                                     style: TextStyle(fontSize: 20),
//                                                                     textAlign: TextAlign.center,
//                                                                   )),
//                                                               content: Padding(
//                                                                   padding: const EdgeInsets.only(
//                                                                     top: 8,
//                                                                   ),
//                                                                   child: Form(
//                                                                     // key: _formKeyInvitedCode,
//                                                                     child: TextFormField(
//                                                                         decoration: InputDecoration(
//                                                                           prefixIcon:
//                                                                           Icon(Icons.description),
//                                                                           border: OutlineInputBorder(
//                                                                               borderRadius:
//                                                                               BorderRadius.circular(
//                                                                                   10)),
//                                                                         ),
//                                                                         maxLength: 20,
//                                                                         minLines: 1,
//                                                                         maxLines: 2,
//                                                                         validator: (value) {
//                                                                           if (value!.length < 10) {
//                                                                             return 'Nhập ít nhất 10 ký tự';
//                                                                           }
//                                                                           return null;
//                                                                         },
//                                                                         onChanged: (value) {
//                                                                           // if (_formKeyInvitedCode
//                                                                           //     .currentState!
//                                                                           //     .validate()) {
//                                                                           //   bloc.add(
//                                                                           //       ChangeInvitedCodeValueEvent(
//                                                                           //           newInvitedCodeValue:
//                                                                           //           value));
//                                                                           // }
//                                                                         }),
//                                                                   )),
//                                                               actions: [
//                                                                 Container(
//                                                                   width: double.infinity,
//                                                                   margin: new EdgeInsets.only(
//                                                                       right: 15, left: 15, bottom: 15),
//                                                                   child: FlatButton(
//                                                                     textColor: ArgonColors.white,
//                                                                     color: ArgonColors.warning,
//                                                                     onPressed: () {
//                                                                       // if (_formKeyInvitedCode.currentState!
//                                                                       //     .validate()) {
//                                                                       //   bloc.add(JoinTeamEvent());
//                                                                       //   Navigator.of(context).pop();
//                                                                       // }
//                                                                     },
//                                                                     shape: RoundedRectangleBorder(
//                                                                       borderRadius:
//                                                                       BorderRadius.circular(5.0),
//                                                                     ),
//                                                                     child: Padding(
//                                                                         padding: EdgeInsets.only(
//                                                                             left: 16.0,
//                                                                             right: 16.0,
//                                                                             top: 12,
//                                                                             bottom: 12),
//                                                                         child: Text("Tham gia",
//                                                                             style: TextStyle(
//                                                                                 fontWeight: FontWeight.w600,
//                                                                                 fontSize: 15.0))),
//                                                                   ),
//                                                                 ),
//                                                               ],
//                                                             );
//                                                           });
//                                                     },
//                                                     shape:
//                                                     RoundedRectangleBorder(
//                                                       borderRadius:
//                                                       BorderRadius
//                                                           .circular(
//                                                           4.0),
//                                                     ),
//                                                     child: Padding(
//                                                         padding:
//                                                         EdgeInsets.only(
//                                                             left: 16.0,
//                                                             right: 16.0,
//                                                             top: 12,
//                                                             bottom: 12),
//                                                         child: Text(
//                                                             "Điểm danh",
//                                                             style: TextStyle(
//                                                                 fontWeight:
//                                                                 FontWeight
//                                                                     .w600,
//                                                                 fontSize:
//                                                                 18.0))),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   )),
//                             ),
//                           ]),
//                         ],
//                       ),
//                     ),
//                   ]),
//                 )
//               ]));
//         });
//   }
// }
