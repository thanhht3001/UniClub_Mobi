import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loadmore/loadmore.dart';
import '../../bloc/view_list_competition_participant/view_list_competition_participant_bloc.dart';
import '../../bloc/view_list_competition_participant/view_list_competition_participant_event.dart';
import '../../bloc/view_list_competition_participant/view_list_competition_participant_state.dart';
import '../../models/entities/competition_entity/competition_entity_model.dart';
import '../../utils/loading.dart';
import '../../utils/router.dart';
import '../size_config.dart';
import '../widgets/card-small.dart';
import '/utils/log.dart';
import '../../constants/theme.dart';

//widgets
import '../widgets/drawer.dart';
import 'component/body_competition_of_participant.dart';
import 'widgets/navbar_competition.dart';

class ViewListCompetitionOfParticipantPage extends StatefulWidget {
  final ViewListCompetitionParticipantBloc bloc;
  ViewListCompetitionOfParticipantPage({required this.bloc});

  @override
  _ViewListCompetitionOfParticipantPageState createState() =>
      _ViewListCompetitionOfParticipantPageState();
}

class _ViewListCompetitionOfParticipantPageState
    extends State<ViewListCompetitionOfParticipantPage> {
  //bloc
  ViewListCompetitionParticipantBloc get bloc => widget.bloc;

  void load(BuildContext context) {
    BlocProvider.of<ViewListCompetitionParticipantBloc>(context)
        .add(LoadAddMoreEvent());
  }

  //refresh
  void refresh(BuildContext context) {
    BlocProvider.of<ViewListCompetitionParticipantBloc>(context)
        .add(LoadListCompetitionParticipantEvent());
  }

  void initState() {
    bloc.add(LoadListCompetitionParticipantEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
        value: bloc,
        child: Scaffold(
            appBar: NavbarCompetitionOfParticipant(
              title: "Cuộc Thi và Sự Kiện đã đăng ký",
              searchBar: true,
              categoryOne: "Cuộc Thi",
              categoryTwo: "Sự Kiện",
              //categoryThree: "Câu Lạc Bộ",
            ),
            backgroundColor: ArgonColors.bgColorScreen,
            // drawer: ArgonDrawer(currentPage: "Competition"),
            body: BlocBuilder<ViewListCompetitionParticipantBloc,
                    ViewListCompetitionParticipantState>(
                bloc: bloc,
                builder: (context, state) {
                  return (state.isLoading &&
                          (state.competitions.isEmpty ||
                              state.competitions.isNotEmpty))
                      ? Loading()
                      : (state.competitions.isEmpty)
                          ? Padding(
                              padding: const EdgeInsets.only(top: 100.0),
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
                                          ? 'Bạn chưa tham gia Cuộc Thi nào!'
                                          : 'Bạn chưa tham gia Sự Kiện nào!',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container(
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 10.0),
                              child: RefreshIndicator(
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
                                      textBuilder:
                                          DefaultLoadMoreTextBuilder.english,
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: state.competitions.length,
                                          itemBuilder: (context, index) {
                                            //lấy hình ảnh
                                            var competitionEntities = state
                                                .competitions
                                                .elementAt(index)
                                                .competitionEntities;
                                            String? imageUrl;
                                            if ((competitionEntities.length) >
                                                0) {
                                              imageUrl = competitionEntities
                                                  .firstWhere(
                                                      (element) =>
                                                          element.entityTypeId ==
                                                          1,
                                                      orElse: () =>
                                                          CompetitionEntityModel(
                                                              id: 0,
                                                              competitionId: 0,
                                                              entityTypeId: 0,
                                                              entityTypeName:
                                                                  '',
                                                              name: '',
                                                              imageUrl:
                                                                  "https://i.ytimg.com/vi/dip_8dmrcaU/maxresdefault.jpg",
                                                              website: '',
                                                              email: '',
                                                              description: ''))
                                                  .imageUrl;
                                            }
                                            return CardSmall(
                                                cta: "Xem Chi Tiết",
                                                title: state
                                                    .competitions[index].name,
                                                img: imageUrl ??
                                                    "https://i.ytimg.com/vi/dip_8dmrcaU/maxresdefault.jpg",
                                                type: state.competitions[index]
                                                    .competitionTypeName,
                                                date:
                                                    (state.competitions[index])
                                                        .startTime,
                                                status: state
                                                    .competitions[index].status,
                                                isEvent: state.isEvent!,
                                                scope: state
                                                    .competitions[index].scope,
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
                                                    bloc.add(LoadingEvent());
                                                    bloc.add(SearchEvent());
                                                  }
                                                });
                                          }))),
                            );
                  //);
                })));
  }

  Future<bool> _loadMore(BuildContext context) async {
    print("onLoadMore");
    await Future.delayed(Duration(seconds: 0, milliseconds: 5000));
    BlocProvider.of<ViewListCompetitionParticipantBloc>(context)
        .add(IncrementalEvent());
    //lúc này stateModel cũng có r nhưng mà chưa có hàm render lại cái view
    //phải đưa cái hàm này vào trong để add event và có state
    load(context);
    return true;
  }

  Future<bool> _refresh(BuildContext context) async {
    print("onRefresh");
    BlocProvider.of<ViewListCompetitionParticipantBloc>(context)
        .add(RefreshEvent());
    await Future.delayed(Duration(seconds: 0, milliseconds: 5000));
    refresh(context);
    return true;
  }
}
