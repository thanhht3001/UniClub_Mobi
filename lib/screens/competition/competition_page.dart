import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loadmore/loadmore.dart';
import 'package:unicec_mobi/bloc/competition/competition_bloc.dart';
import 'package:unicec_mobi/bloc/competition/competition_state.dart';
import 'package:unicec_mobi/models/entities/competition_entity/competition_entity_model.dart';
import 'package:unicec_mobi/utils/log.dart';

import '../../bloc/competition/competition_event.dart';
import '../../constants/theme.dart';
import '../../../utils/utils.dart';

//widgets
import '../../utils/loading.dart';
import '../../utils/router.dart';
import '../size_config.dart';
import '../widgets/card-small.dart';
import '../widgets/drawer.dart';
import 'widgets/navbar_competition.dart';
import 'widgets/suggest_competition.dart';
import 'widgets/section_title.dart';

class CompetitionPage extends StatefulWidget {
  final CompetitionBloc bloc;

  CompetitionPage({required this.bloc});

  @override
  _CompetitionPageState createState() => _CompetitionPageState();
}

class _CompetitionPageState extends State<CompetitionPage>
    with AutomaticKeepAliveClientMixin {
  CompetitionBloc get _bloc => widget.bloc;
  static final GlobalKey _formKey = GlobalKey();

  void initState() {
    _bloc.listenerStream.listen((event) {
      if (event is ListenLoadOutStandingEvent) {
        _bloc.add(LoadOutStandingCompetitionEvent());
      }
    });
    _bloc.add(LoadOutStandingCompetitionEvent());

    _bloc.add(LoadCompetitionEvent());
  }

  void load(BuildContext context) {
    BlocProvider.of<CompetitionBloc>(context).add(LoadAddMoreEvent());
  }

  //refresh
  void refresh(BuildContext context) {
    BlocProvider.of<CompetitionBloc>(context).add(LoadCompetitionEvent());
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    Log.info('Build competition page');
    const defaultImage = 'https://picsum.photos/seed/513/600';

    return BlocProvider.value(
      value: _bloc,
      child: BlocBuilder<CompetitionBloc, CompetitionState>(
          bloc: _bloc,
          builder: (context, state) {
            return Scaffold(
                appBar: NavbarCompetition(
                  title: "Cu???c Thi & S??? Ki???n",                                    
                  searchBar: true,
                  categoryOne: "Cu???c Thi",
                  categoryTwo: "S??? Ki???n",
                ),
                resizeToAvoidBottomInset: false,                
                backgroundColor: ArgonColors.bgColorScreen,
                //key: _scaffoldKey,
                drawer: ArgonDrawer(currentPage: "Competition"),
                body: (state.isLoading &&
                        (state.competitions.isEmpty ||
                            state.competitions.isNotEmpty))
                    ? Loading()
                    : Container(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
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
                                          title: "Hi???n C??",
                                          press: () {},
                                        ),
                                      ),
                                      const SizedBox(height: 8.0),
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
                                                //l???y h??nh ???nh
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
                                                    cta: "Xem Chi Ti???t",
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
                                                    tap: () async {
                                                      bool returnData = await Navigator
                                                              .of(context)
                                                          .pushNamed(
                                                              Routes
                                                                  .detailCompetition,
                                                              arguments: state
                                                                  .competitions[
                                                                      index]
                                                                  .id) as bool;
                                                      if (returnData) {
                                                        _bloc.add(
                                                            LoadingEvent());
                                                        _bloc
                                                            .add(SearchEvent());
                                                      }
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
                                            ? 'Ch??a c?? Cu???c Thi n??o!'
                                            : 'Ch??a c?? S??? Ki???n n??o!',
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
    BlocProvider.of<CompetitionBloc>(context).add(IncrementalEvent());
    //l??c n??y stateModel c??ng c?? r nh??ng m?? ch??a c?? h??m render l???i c??i view
    //ph???i ????a c??i h??m n??y v??o trong ????? add event v?? c?? state
    load(context);
    return true;
  }

  Future<bool> _refresh(BuildContext context) async {
    print("onRefresh");
    BlocProvider.of<CompetitionBloc>(context).add(RefreshEvent());
    await Future.delayed(Duration(seconds: 0, milliseconds: 5000));
    refresh(context);
    return true;
  }
}
