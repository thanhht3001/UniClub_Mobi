import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loadmore/loadmore.dart';
import '../../bloc/view_list_competition_of_club/view_list_competition_of_club_bloc.dart';
import '../../bloc/view_list_competition_of_club/view_list_competition_of_club_event.dart';
import '../../bloc/view_list_competition_of_club/view_list_competition_of_club_state.dart';
import '../../constants/theme.dart';
//widgets
import '../../models/entities/competition_entity/competition_entity_model.dart';
import '../../utils/loading.dart';
import '../../utils/log.dart';
import '../../utils/router.dart';
import '../competition/widgets/section_title.dart';
import '../competition/widgets/suggest_competition.dart';
import '../size_config.dart';
import '../widgets/card-small.dart';
import '../widgets/drawer.dart';
import 'widgets/navbar_competition.dart';

class ViewListCompetitionOfClubPage extends StatefulWidget {
  final ViewListCompetitionOfClubBloc bloc;

  ViewListCompetitionOfClubPage({required this.bloc});

  @override
  _ViewListCompetitionOfClubPageState createState() =>
      _ViewListCompetitionOfClubPageState();
}

class _ViewListCompetitionOfClubPageState
    extends State<ViewListCompetitionOfClubPage>
    with AutomaticKeepAliveClientMixin {
  ViewListCompetitionOfClubBloc get _bloc => widget.bloc;
  static final GlobalKey _formKey = GlobalKey();

  void initState() {
    _bloc.listenerStream.listen((event) {
      if (event is ListenLoadOutStandingEvent) {
        _bloc.add(LoadOutStandingCompetitionEvent());
      }
    });
    _bloc.add(LoadOutStandingCompetitionEvent());
    //_bloc.isLoading = true;
    _bloc.add(LoadCompetitionEvent());
  }

  void load(BuildContext context) {
    BlocProvider.of<ViewListCompetitionOfClubBloc>(context)
        .add(LoadAddMoreEvent());
  }

  //refresh
  void refresh(BuildContext context) {
    BlocProvider.of<ViewListCompetitionOfClubBloc>(context)
        .add(LoadCompetitionEvent());
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    Log.info('Build competition page');
    const defaultImage = 'https://picsum.photos/seed/513/600';

    return BlocProvider.value(
      value: _bloc,
      child: BlocBuilder<ViewListCompetitionOfClubBloc,
              ViewListCompetitionOfClubState>(
          bloc: _bloc,
          builder: (context, state) {
            // return (_bloc.isLoading)
            //     ? Loading()
            //     :
            return Scaffold(
                appBar: NavbarCompetitionOfClub(
                  title: "Cuộc Thi và Sự Kiện câu lạc bộ",
                  searchBar: true,
                  categoryOne: "Cuộc Thi",
                  categoryTwo: "Sự Kiện",
                ),
                resizeToAvoidBottomInset: false,
                backgroundColor: ArgonColors.bgColorScreen,
                //key: _scaffoldKey,
                // drawer: ArgonDrawer(currentPage: "Competition"),
                body: (state.isLoading &&
                        (state.competitions.isEmpty ||
                            state.competitions.isNotEmpty))
                    ? Loading()
                    : Container(
                        padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                        child: (state.competitions.isNotEmpty)
                            ? RefreshIndicator(
                                onRefresh: () {
                                  return _refresh(context);
                                },
                                child: SingleChildScrollView(
                                  physics: ScrollPhysics(),
                                  child: Column(
                                    children: [
                                      (state.outStandingCompetitions.isNotEmpty)
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 16.0),
                                              child: SpecialOffers(
                                                outStandingEvents: (state
                                                    .outStandingCompetitions),
                                              ),
                                            )
                                          : const SizedBox.shrink(),
                                      SizedBox(
                                          height:
                                              getProportionateScreenWidth(15)),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                getProportionateScreenWidth(5)),
                                        child: SectionTitle(
                                          title: "Hiện Có",
                                          press: () {},
                                        ),
                                      ),
                                      SizedBox(height: 8.0),
                                      LoadMore(
                                          isFinish: !state.hasNext,
                                          onLoadMore: () {
                                            return _loadMore(context);
                                          },
                                          whenEmptyLoad: false,
                                          delegate: DefaultLoadMoreDelegate(),
                                          textBuilder:
                                              DefaultLoadMoreTextBuilder
                                                  .english,
                                          child: ListView.builder(
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount:
                                                  state.competitions.length,
                                              itemBuilder: (context, index) {
                                                //lấy hình ảnh
                                                var competitionEntities = state
                                                    .competitions
                                                    .elementAt(index)
                                                    .competitionEntities;
                                                String? imageUrl;
                                                if ((competitionEntities
                                                        .length) >
                                                    0) {
                                                  imageUrl = competitionEntities
                                                      .firstWhere(
                                                          (element) =>
                                                              element.entityTypeId ==
                                                              1,
                                                          orElse: () =>
                                                              CompetitionEntityModel(
                                                                  id: 0,
                                                                  competitionId:
                                                                      0,
                                                                  entityTypeId:
                                                                      0,
                                                                  entityTypeName:
                                                                      '',
                                                                  name: '',
                                                                  imageUrl:
                                                                      "https://i.ytimg.com/vi/dip_8dmrcaU/maxresdefault.jpg",
                                                                  website: '',
                                                                  email: '',
                                                                  description:
                                                                      ''))
                                                      .imageUrl;
                                                }
                                                return CardSmall(
                                                    cta: "Xem Chi Tiết",
                                                    title: state
                                                        .competitions[index]
                                                        .name,
                                                    img: imageUrl ??
                                                        "https://i.ytimg.com/vi/dip_8dmrcaU/maxresdefault.jpg",
                                                    type: state
                                                        .competitions[index]
                                                        .competitionTypeName,
                                                    date: (state.competitions[
                                                            index])
                                                        .startTime,
                                                    status: state
                                                        .competitions[index]
                                                        .status,
                                                    isEvent: state.isEvent!,
                                                    scope: state
                                                        .competitions[index]
                                                        .scope,
                                                    tap: () {
                                                      Navigator.of(context)
                                                          .pushNamed(
                                                              Routes
                                                                  .detailCompetition,
                                                              arguments: state
                                                                  .competitions[
                                                                      index]
                                                                  .id);
                                                    });
                                              })),
                                    ],
                                  ),
                                ),
                              )
                            : Padding(
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
                                    Image.asset(
                                        "assets/img/not-found-icon-24.jpg"),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 25.0),
                                      child: Text(
                                        (state.isEvent == false)
                                            ? 'Chưa có Cuộc Thi nào!'
                                            : 'Chưa có Sự Kiện nào!',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                  ],
                                ),
                              )));
          }),
    );
  }

  Future<bool> _loadMore(BuildContext context) async {
    print("onLoadMore");
    await Future.delayed(Duration(seconds: 0, milliseconds: 5000));
    BlocProvider.of<ViewListCompetitionOfClubBloc>(context)
        .add(IncrementalEvent());
    //lúc này stateModel cũng có r nhưng mà chưa có hàm render lại cái view
    //phải đưa cái hàm này vào trong để add event và có state
    load(context);
    return true;
  }

  Future<bool> _refresh(BuildContext context) async {
    print("onRefresh");
    BlocProvider.of<ViewListCompetitionOfClubBloc>(context).add(RefreshEvent());
    await Future.delayed(Duration(seconds: 0, milliseconds: 5000));
    refresh(context);
    return true;
  }
}


// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:unicec_mobi/bloc/competition/competition_bloc.dart';
// import 'package:unicec_mobi/bloc/competition/competition_state.dart';
// import 'package:unicec_mobi/screens/view_list_competition_of_club/status/approve.dart';
// import 'package:unicec_mobi/screens/view_list_competition_of_club/status/cancel.dart';
// import 'package:unicec_mobi/screens/view_list_competition_of_club/status/complete.dart';
// import 'package:unicec_mobi/screens/view_list_competition_of_club/status/draft.dart';
// import 'package:unicec_mobi/screens/view_list_competition_of_club/status/end.dart';
// import 'package:unicec_mobi/screens/view_list_competition_of_club/status/on_going.dart';
// import 'package:unicec_mobi/screens/view_list_competition_of_club/status/pending.dart';
// import 'package:unicec_mobi/screens/view_list_competition_of_club/status/pending_review.dart';
// import 'package:unicec_mobi/screens/view_list_competition_of_club/status/publish.dart';
// import 'package:unicec_mobi/screens/view_list_competition_of_club/status/register.dart';
// import 'package:unicec_mobi/screens/view_list_competition_of_club/status/start.dart';
// import 'package:unicec_mobi/screens/view_list_competition_of_club/status/upcoming.dart';
// import 'package:unicec_mobi/utils/app_color.dart';
// import 'package:unicec_mobi/utils/log.dart';

// import '../../bloc/competition/competition_event.dart';
// import '../../constants/theme.dart';

// //widgets
// import '../../utils/loading.dart';
// import '../../utils/router.dart';
// import '../size_config.dart';
// import '../widgets/card-small.dart';
// import '../widgets/drawer.dart';
// import 'widgets/navbar_competition.dart';
// import 'widgets/suggest_competition.dart';
// import 'widgets/section_title.dart';

// class ViewListCompetitionOfClubPage extends StatefulWidget {
//   ViewListCompetitionOfClubPage();

//   @override
//   _ViewListCompetitionOfClubPageState createState() =>
//       _ViewListCompetitionOfClubPageState();
// }

// class _ViewListCompetitionOfClubPageState
//     extends State<ViewListCompetitionOfClubPage> {
//   void initState() {}

//   @override
//   Widget build(BuildContext context) {
//     Log.info('Build competition page');
//     return Scaffold(
//         // appBar: NavbarCompetitionOfClub(
//         //   title: "Cuộc thi và sự kiện trong CLB",
//         //   searchBar: true,
//         //   categoryOne: "Cuộc Thi",
//         //   categoryTwo: "Sự Kiện",
//         //   // bloc: _bloc,
//         //   // state: "state",
//         // ),
//         backgroundColor: ArgonColors.bgColorScreen,
//         //key: _scaffoldKey,
//         drawer: ArgonDrawer(currentPage: "Competition"),
//         body: Container(
//           padding: EdgeInsets.only(left: 24.0, right: 24.0),
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 ApprovePage(),
//                 CancelPage(),
//                 CompletePage(),
//                 DraftPage(),
//                 EndPage(),
//                 OnGoingPage(),
//                 PendingPage(),
//                 PendingReviewPage(),
//                 PublishPage(),
//                 RegisterPage(),
//                 StartPage(),
//                 UpComingPage(),
//               ],
//             ),
//           ),
//         ));
//   }
// }
