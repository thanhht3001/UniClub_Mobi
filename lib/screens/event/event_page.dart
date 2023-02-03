// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:unicec_mobi/screens/event/widgets/navbar_event.dart';
// import '../../bloc/event/event_bloc.dart';
// import '../../bloc/event/event_event.dart';
// import '../../bloc/event/event_state.dart';
// import '../../constants/theme.dart';
// import '../../utils/loading.dart';
// import '../../utils/router.dart';
// import '../competition/widgets/section_title.dart';
// import '../competition/widgets/suggest_competition.dart';
// import '../size_config.dart';
// import '../widgets/card-small.dart';
// import '../widgets/drawer.dart';
// //widgets

// class EventPage extends StatefulWidget {
//   final EventBloc bloc;

//   EventPage({required this.bloc});

//   @override
//   _EventPageState createState() => _EventPageState();
// }

// class _EventPageState extends State<EventPage> {
//   EventBloc get _bloc => widget.bloc;

//   void initState() {
//     _bloc.listenerStream.listen((event) {});
//     _bloc.add(LoadOutStandingEvent());
//     // _bloc.add(LoadCompetitionEvent());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<EventBloc, EventState>(
//         bloc: _bloc,
//         builder: (context, state) {
//           return _bloc.isLoading ? Loading() : Scaffold(
//               appBar: NavbarEvent(
//                 title: "Sự Kiện",
//                 searchBar: true,
//                 categoryOne: "Liên Trường",
//                 categoryTwo: "Trong Trường",
//               ),
//               backgroundColor: ArgonColors.bgColorScreen,
//               //key: _scaffoldKey,
//               drawer: ArgonDrawer(currentPage: "Event"),
//               body: Container(
//                 padding: EdgeInsets.only(left: 24.0, right: 24.0),
//                 child: SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       (state.outStandingEvents != null)
//                           ? Padding(
//                               padding: const EdgeInsets.only(top: 16.0),
//                               child: SpecialOffers(
//                                 outStandingEvents:
//                                     (state.outStandingEvents)!,
//                               ),
//                             )
//                           : SizedBox.shrink(),
//                       SizedBox(height: getProportionateScreenWidth(15)),
//                       Padding(
//                         padding: EdgeInsets.symmetric(
//                             horizontal: getProportionateScreenWidth(5)),
//                         child: SectionTitle(
//                           title: "Đang diễn ra",
//                           press: () {},
//                         ),
//                       ),
//                       SizedBox(height: 8.0),
//                       (state.outStandingEvents != null)
//                           ? Column(
//                               children: [
//                                 Wrap(
//                                   children: List.generate(
//                                       (state.outStandingEvents?.length)!,
//                                       (index) {
//                                     return CardSmall(
//                                         cta: "Xem thêm",
//                                         title: (state.outStandingEvents?[
//                                                 index])!
//                                             .name, // homeCards["Makeup"]!['title'],
//                                         img: (state.outStandingEvents?[
//                                                 index])!
//                                             .competitionEntities[0]
//                                             .imageUrl, //homeCards["Makeup"]!['image'],
//                                         type: (state.outStandingEvents?[
//                                                 index])!
//                                             .competitionTypeName, //homeCards["Makeup"]!['type'],
//                                         date:
//                                             '${(state.outStandingEvents?[index])!.startTime}', //homeCards["Makeup"]!['date'],
//                                         tap: () {
//                                           Navigator.of(context).pushNamed(
//                                               Routes.detailCompetition);
//                                         });
//                                   }),
//                                 )
//                               ],
//                             )
//                           : Text('Không có cuộc thi nào đang diễn ra'),
//                       SizedBox(height: 8.0),                    
//                     ],
//                   ),                  
//                 ),
//               ));
//         });
//   }
// }
