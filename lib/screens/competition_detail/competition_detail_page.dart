import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get_it/get_it.dart';
import 'package:unicec_mobi/models/enums/competition_scope_status.dart';
import 'package:unicec_mobi/models/enums/competition_status.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../bloc/competition_detail/competition_detail_bloc.dart';
import '../../bloc/competition_detail/competition_detail_event.dart';
import '../../bloc/competition_detail/competition_detail_state.dart';
import '../../constants/Theme.dart';
import '../../models/common/current_user.dart';
import '../../models/entities/competition/competition_in_clubs_model.dart';
import '../../models/entities/competition/competition_in_majors_model.dart';
import '../../models/entities/competition/send_data_model.dart';
import '../../models/entities/competition_entity/competition_entity_model.dart';
import '../../utils/app_color.dart';
import '../../utils/loading.dart';
import '../../utils/log.dart';
import '../../utils/router.dart';
import '../../utils/utils.dart';
import '../size_config.dart';
import '../widgets/drawer.dart';

class CompetitionDetailPage extends StatefulWidget {
  final CompetitionDetailBloc bloc;

  CompetitionDetailPage({required this.bloc});

  @override
  _CompetitionDetailPageState createState() => _CompetitionDetailPageState();
}

class _CompetitionDetailPageState extends State<CompetitionDetailPage> {
  CompetitionDetailBloc get _bloc => widget.bloc;

  void initState() {
    super.initState();

    _bloc.listenerStream.listen((event) {
      if (event is ShowPopUpAnnouncement) {
        if (event.message.contains("thành công")) {
          // check competition is single or team
          if (_bloc.state.competitionDetail?.minNumber == 1 &&
              _bloc.state.competitionDetail?.maxNumber == 1) {
            _bloc.add(CreateTeamEvent(
                competitionId: (_bloc.state.competitionDetail?.id)!,
                teamName: GetIt.I.get<CurrentUser>().fullname));
          }

          AwesomeDialog(
            context: context,
            animType: AnimType.LEFTSLIDE,
            headerAnimationLoop: false,
            dialogType: DialogType.SUCCES,
            showCloseIcon: true,
            title: 'Thành Công',
            desc: (event.message.contains("Tham gia"))
                ? "Bạn đã đăng ký tham gia thành công"
                : (event.message.contains("Điểm danh"))
                    ? "Bạn đã điểm danh thành công"
                    : "Lỗi",
            btnOkOnPress: () {},
            btnOkIcon: Icons.check_circle,
            onDissmissCallback: (type) {
              debugPrint('Dialog Dissmiss from callback $type');
            },
          ).show();
        } else {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.ERROR,
            animType: AnimType.RIGHSLIDE,
            headerAnimationLoop: true,
            title: 'Thất Bại',
            desc: (event.message.contains("full"))
                ? "Bạn không thể đăng ký tham gia, số lượng người tham gia đã đầy"
                : (event.message.contains("seeds point"))
                    ? "Bạn không thể đăng ký tham gia, điểm trong ví không đủ"
                    : (event.message.contains("Competition not found"))
                        ? "Thất bại, mã điểm danh không hợp lệ"
                        : (event.message.contains("Register"))
                            ? "Thất bại, hiện tại chưa tới thời điểm đăng ký"
                            : event.message,
            btnOkOnPress: () {},
            btnOkIcon: Icons.cancel,
            btnOkColor: Colors.red,
          ).show();
        }
      }
    });
  }

  String switchScope() {
    if (_bloc.state.competitionDetail?.scope != null) {
      CompetitionScopeStatus? scope = _bloc.state.competitionDetail?.scope;
      switch (scope) {
        case CompetitionScopeStatus.InterUniversity:
          return 'Liên Trường';
        case CompetitionScopeStatus.University:
          return 'Trong Trường';
        case CompetitionScopeStatus.Club:
          return 'Câu lạc bộ';
        default:
          return '';
      }
    }

    return '';
  }

  List<Widget> ListMajorInCompetition(
      List<CompetitionInMajorsModel>? majorsInCompetition) {
    List<Widget> result = [];
    if (majorsInCompetition != null) {
      result = majorsInCompetition
          .map<Widget>((e) => Container(
                margin: const EdgeInsets.only(left: 10, bottom: 5, top: 5),
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.orangeAccent),
                    color: Colors.orangeAccent,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Text('${e.name}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    )),
              ))
          .toList();
    }

    return result;
  }

  List<Widget> getListFluencer(List<CompetitionEntityModel>? model) {
    if (model != null) {
      model = model.where((element) => element.entityTypeId == 2).toList();
      return model
          .map((e) => Container(
              margin: new EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              width: 50,
              height: 50,
              child:
                  CircleAvatar(backgroundImage: NetworkImage("${e.imageUrl}"))))
          .toList();
    }
    return [];
  }

  List<Widget> getListSponsor(List<CompetitionEntityModel>? model) {
    if (model != null) {
      model = model.where((element) => element.entityTypeId == 3).toList();
      return model
          .map((e) => Container(
              margin: new EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              width: 50,
              height: 50,
              child:
                  CircleAvatar(backgroundImage: NetworkImage("${e.imageUrl}"))))
          .toList();
    }
    return [];
  }

  List<Widget> getListClub(List<CompetitionInClubsModel>? model) {
    const defaultImage = 'https://picsum.photos/seed/513/600';
    if (model != null) {
      return model
          .map((e) => Container(
              margin: new EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              width: 50,
              height: 50,
              child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      "${e.image != "" ? e.image : defaultImage}"))))
          .toList();
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    print('detailCompetitionPage - isloading: ${_bloc.isLoading}');

    RouteSettings settings = ModalRoute.of(context)!.settings;
    if (settings.arguments != null) {
      print('competitionId: ${settings.arguments as int}');
      _bloc.add(
          LoadCompetitionDetailEvent(competitionId: settings.arguments as int));
      _bloc.isLoading = true;
    }

    //var universityName = GetIt.I.get<CurrentUser>().universityName;
    const defaultImage = 'https://picsum.photos/seed/513/600';

    return BlocBuilder<CompetitionDetailBloc, CompetitionDetailState>(
        bloc: _bloc,
        builder: (context, state) {
          Log.info('content: ${state.competitionDetail?.content}');
          return Scaffold(
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                ),
                title: Text(
                    ((state.competitionDetail?.numberOfTeam != 0)
                        ? "Chi Tiết Cuộc Thi"
                        : "Chi Tiết Sự Kiện"),
                    style: TextStyle(color: Colors.white, fontSize: 23)),
                automaticallyImplyLeading: false,
                centerTitle: true,
                backgroundColor: AppColors.mainColor,
              ),
              backgroundColor: ArgonColors.bgColorScreen,
              drawer: ArgonDrawer(currentPage: "Competition Detail"),
              body: (_bloc.isLoading)
                  ? Loading()
                  : Stack(children: <Widget>[
                      SafeArea(
                        child: ListView(children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 0.0, right: 0.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Stack(children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.1),
                                          spreadRadius: 1,
                                          blurRadius: 7,
                                          offset: const Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Card(
                                        semanticContainer: true,
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        elevation: .0,
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5.0))),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 0,
                                              bottom: 10.0,
                                              left: 10.0,
                                              right: 10.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(height: 10.0),
                                              Row(
                                                children: [
                                                  _bloc.state.competitionDetail
                                                              ?.clubsInCompetition
                                                              .firstWhere((element) =>
                                                                  element.isOwner ==
                                                                  true) !=
                                                          null
                                                      ? Padding(
                                                          padding: const EdgeInsets.fromLTRB(
                                                              6.0, 2.0, 10.0, 2.0),
                                                          child: Container(
                                                              width: 48,
                                                              height: 48,
                                                              child: CircleAvatar(
                                                                  backgroundImage:
                                                                      NetworkImage(_bloc.state.competitionDetail?.clubsInCompetition.firstWhere((element) => element.isOwner == true).image != ''
                                                                          ? '${_bloc.state.competitionDetail?.clubsInCompetition.firstWhere((element) => element.isOwner == true).image}'
                                                                          : defaultImage))))
                                                      : const SizedBox.shrink(),
                                                  Text(
                                                    "${_bloc.state.competitionDetail?.clubsInCompetition.where((element) => element.isOwner == true).first.name}",
                                                    style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Expanded(
                                                      child: SizedBox(
                                                          width:
                                                              getProportionateScreenWidth(
                                                                  10))),
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.all(
                                                            15.0),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            3.0),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: ArgonColors
                                                                .success),
                                                        color:
                                                            ArgonColors.success,
                                                        borderRadius:
                                                            const BorderRadius
                                                                    .all(
                                                                Radius.circular(
                                                                    10))),
                                                    child: Text(
                                                        (_bloc.state.competitionDetail
                                                                        ?.fee) !=
                                                                    null &&
                                                                (_bloc
                                                                        .state
                                                                        .competitionDetail
                                                                        ?.fee)! >
                                                                    0
                                                            ? '${_bloc.state.competitionDetail?.fee} VNĐ'
                                                            : "Không thu phí",
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 18,
                                                        )),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 10.0),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10, right: 10),
                                                child: Align(
                                                  child: Text(
                                                      "${_bloc.state.competitionDetail?.name}",
                                                      style: const TextStyle(
                                                          color: Color.fromRGBO(
                                                              50, 50, 93, 1),
                                                          fontSize: 28.0)),
                                                ),
                                              ),
                                              const SizedBox(height: 5.0),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10, left: 10),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                        "@${_bloc.state.competitionDetail?.competitionTypeName}",
                                                        style: TextStyle(
                                                            color: AppColors
                                                                .mainColor,
                                                            fontSize: 18)),
                                                    const SizedBox(
                                                      width: 20,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(height: 10.0),
                                              (_bloc.state.competitionDetail
                                                          ?.competitionEntities
                                                          .where((element) =>
                                                              element
                                                                  .entityTypeId ==
                                                              1)
                                                          .first
                                                          .imageUrl !=
                                                      null)
                                                  ? Container(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Image.network(
                                                          '${_bloc.state.competitionDetail?.competitionEntities.where((element) => element.entityTypeId == 1).first.imageUrl}'),
                                                    )
                                                  : const SizedBox.shrink(),
                                              const SizedBox(height: 10.0),
                                              (_bloc.state.competitionDetail
                                                              ?.majorsInCompetition !=
                                                          null &&
                                                      (_bloc
                                                              .state
                                                              .competitionDetail
                                                              ?.majorsInCompetition
                                                              .length)! >
                                                          0)
                                                  // ? Text("AAAAAAAAAA")
                                                  ? Wrap(
                                                      alignment:
                                                          WrapAlignment.start,
                                                      direction:
                                                          Axis.horizontal,
                                                      children:
                                                          ListMajorInCompetition(state
                                                              .competitionDetail
                                                              ?.majorsInCompetition))
                                                  : Row(
                                                      children: [
                                                        // major
                                                        Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .all(15.0),
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(3.0),
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .orangeAccent),
                                                              color: Colors
                                                                  .orangeAccent,
                                                              borderRadius:
                                                                  const BorderRadius
                                                                          .all(
                                                                      Radius.circular(
                                                                          10))),
                                                          child: const Text(
                                                              'Toàn bộ các ngành',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 18,
                                                              )),
                                                        ),
                                                      ],
                                                    ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10,
                                                    left: 10.0,
                                                    right: 10.0),
                                                child: Row(
                                                  children: [
                                                    const Icon(
                                                        Icons
                                                            .calendar_today_outlined,
                                                        size: 23,
                                                        color: Colors.orange),
                                                    const SizedBox(width: 10.0),
                                                    Text(
                                                      (_bloc.state.competitionDetail !=
                                                              null)
                                                          ? Utils.convertDateTime(
                                                              _bloc
                                                                  .state
                                                                  .competitionDetail!
                                                                  .startTime)
                                                          : Utils
                                                              .convertDateTime(
                                                                  DateTime
                                                                      .now()),
                                                      style: const TextStyle(
                                                          fontSize: 18),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: 10.0),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10.0, right: 10.0),
                                                child: Row(
                                                  children: [
                                                    const Icon(
                                                      Icons
                                                          .add_location_rounded,
                                                      size: 23,
                                                      color: Colors.orange,
                                                    ),
                                                    const SizedBox(width: 10.0),
                                                    Expanded(
                                                        child: Text(
                                                      "${_bloc.state.competitionDetail?.addressName} - ${_bloc.state.competitionDetail?.address}",
                                                      style: const TextStyle(
                                                          fontSize: 18),
                                                    )),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: 10.0),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10, right: 10),
                                                child: Row(
                                                  children: [
                                                    const Icon(
                                                      Icons
                                                          .account_balance_sharp,
                                                      size: 23,
                                                      color: Colors.orange,
                                                    ),
                                                    SizedBox(width: 10.0),
                                                    Expanded(
                                                        child: Text(
                                                      switchScope(),
                                                      style: const TextStyle(
                                                          fontSize: 18),
                                                    )),
                                                  ],
                                                ),
                                              ),
                                              const Divider(
                                                height: 40.0,
                                                thickness: 1.5,
                                                indent: 32.0,
                                                endIndent: 32.0,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10.0, right: 10),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                        child: Html(
                                                      data: _bloc
                                                          .state
                                                          .competitionDetail
                                                          ?.content,
                                                      onLinkTap: (url,
                                                          context,
                                                          attributes,
                                                          element) async {
                                                        print('url: $url');
                                                        if (await canLaunch(
                                                            url!)) {
                                                          await launch(
                                                            url,
                                                          );
                                                        } else {
                                                          throw 'Could not launch $url';
                                                        }
                                                      },
                                                      tagsList: Html.tags,
                                                      style: {
                                                        "p": Style(
                                                            fontSize:
                                                                const FontSize(
                                                                    18.0)),
                                                        "em": Style(
                                                            fontStyle: FontStyle
                                                                .italic),
                                                        "strong": Style(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                        "a": Style(
                                                            textDecoration:
                                                                TextDecoration
                                                                    .underline,
                                                            color: Colors
                                                                .blueAccent),
                                                        // "ul": Wrap()
                                                        "li": Style(
                                                            fontSize:
                                                                const FontSize(
                                                                    15.0))
                                                      },
                                                      onCssParseError:
                                                          (css, messages) {
                                                        Log.error(
                                                            'css that errored: $css');
                                                        Log.error(
                                                            'error messages: ');
                                                        messages
                                                            .forEach((element) {
                                                          Log.error('$element');
                                                        });
                                                      },
                                                    )),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(height: 10.0),
//----------------------------------------------------------------------------Các câu lạc bộ tham gia tổ chức
                                              (_bloc
                                                          .state
                                                          .competitionDetail
                                                          ?.clubsInCompetition
                                                          .length)! >
                                                      0
                                                  ? Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10.0,
                                                              right: 10.0),
                                                      child: Row(
                                                        children: const [
                                                          Expanded(
                                                            child: Text(
                                                              "Các câu lạc bộ tham gia tổ chức",
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  : const SizedBox(
                                                      height: 10.0),
                                              (_bloc
                                                          .state
                                                          .competitionDetail
                                                          ?.clubsInCompetition
                                                          .length)! >
                                                      0
                                                  ? Wrap(
                                                      children: getListClub(_bloc
                                                          .state
                                                          .competitionDetail
                                                          ?.clubsInCompetition),
                                                    )
                                                  : SizedBox(height: 0),
//----------------------------------------------------------------------------Ban giám khảo
                                              ((_bloc.state.competitionDetail
                                                          ?.competitionEntities
                                                          .where((element) =>
                                                              element
                                                                  .entityTypeId ==
                                                              2)
                                                          .length)! >
                                                      0)
                                                  ? Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10.0,
                                                              right: 10.0),
                                                      child: Row(
                                                        children: const [
                                                          Expanded(
                                                            child: Text(
                                                              "Ban giám khảo",
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  : SizedBox(height: 0),
                                              ((_bloc.state.competitionDetail
                                                          ?.competitionEntities
                                                          .where((element) =>
                                                              element
                                                                  .entityTypeId ==
                                                              2)
                                                          .length)! >
                                                      0)
                                                  ? Wrap(
                                                      children: getListFluencer(
                                                          _bloc
                                                              .state
                                                              .competitionDetail
                                                              ?.competitionEntities),
                                                    )
                                                  : SizedBox(height: 0),
//----------------------------------------------------------------------------Các đơn vị tài trợ
                                              ((_bloc.state.competitionDetail
                                                          ?.competitionEntities
                                                          .where((element) =>
                                                              element
                                                                  .entityTypeId ==
                                                              3)
                                                          .length)! >
                                                      0)
                                                  ? Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10.0,
                                                              right: 10.0,
                                                              top: 10),
                                                      child: Row(
                                                        children: const [
                                                          Expanded(
                                                            child: Text(
                                                              "Các đơn vị tài trợ",
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  : SizedBox(height: 0),
                                              ((_bloc.state.competitionDetail
                                                          ?.competitionEntities
                                                          .where((element) =>
                                                              element
                                                                  .entityTypeId ==
                                                              3)
                                                          .length)! >
                                                      0)
                                                  ? Wrap(
                                                      children: getListFluencer(
                                                          _bloc
                                                              .state
                                                              .competitionDetail
                                                              ?.competitionEntities),
                                                    )
                                                  : SizedBox(height: 0),
//-------------------------------------------------------------Ban tổ chức
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10.0,
                                                    right: 10,
                                                    top: 10),
                                                child: Row(
                                                  children: const [
                                                    Expanded(
                                                      child: Text(
                                                        "Ban tổ chức",
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 10),
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                        height: 80.0,
                                                        child: Container(
                                                            margin:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        10),
                                                            width: 50,
                                                            height: 50,
                                                            child: CircleAvatar(
                                                                backgroundImage: NetworkImage((_bloc
                                                                            .state
                                                                            .competitionDetail
                                                                            ?.universityImage)! !=
                                                                        ''
                                                                    ? "${_bloc.state.competitionDetail?.universityImage}"
                                                                    : defaultImage)))),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                alignment: Alignment.center,
                                                child: Wrap(
                                                  alignment:
                                                      WrapAlignment.center,
                                                  // mainAxisAlignment:
                                                  //     MainAxisAlignment
                                                  //         .spaceAround,
                                                  runSpacing: 20.0,
                                                  // spacing: 20.0,
                                                  children: [
                                                    Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          if (state
                                                                  .competitionDetail
                                                                  ?.numberOfTeam !=
                                                              0)
                                                            Container(
                                                                width: 166.0,
                                                                height: 37,
                                                                child: RaisedButton(
                                                                    textColor: ArgonColors.white,
                                                                    color: ArgonColors.warning,
                                                                    onPressed: () {
                                                                      //chuyển sang trang list team
                                                                      if (state
                                                                              .isParticipant ==
                                                                          true) {
                                                                        SendDataModel data = SendDataModel(
                                                                            competitionId:
                                                                                state.competitionDetail!.id,
                                                                            max: state.competitionDetail!.maxNumber,
                                                                            min: state.competitionDetail!.minNumber);
                                                                        Navigator.of(context).pushNamed(
                                                                            Routes
                                                                                .viewListTeamParticipant,
                                                                            arguments:
                                                                                data);
                                                                      } else {
                                                                        Navigator.of(context).pushNamed(
                                                                            Routes
                                                                                .viewListTeamStudent,
                                                                            arguments:
                                                                                state.competitionDetail?.id);
                                                                      }
                                                                    },
                                                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                                                    child: Padding(
                                                                        padding: const EdgeInsets.only(bottom: 10, top: 10),
                                                                        child: Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceAround,
                                                                          children: const [
                                                                            Icon(Icons.supervised_user_circle_sharp,
                                                                                size: 15),
                                                                            // SizedBox(
                                                                            //   width:
                                                                            //       5,
                                                                            // ),
                                                                            Text("Các đội tham gia",
                                                                                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15))
                                                                          ],
                                                                        )))),
                                                          if (state
                                                                  .competitionDetail
                                                                  ?.numberOfTeam !=
                                                              0)
                                                            Container(
                                                              width: 155.0,
                                                              height: 37,
                                                              child:
                                                                  RaisedButton(
                                                                      textColor:
                                                                          ArgonColors
                                                                              .white,
                                                                      color: ArgonColors
                                                                          .success,
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pushNamed(
                                                                            context,
                                                                            Routes
                                                                                .viewCompetitionRound,
                                                                            arguments:
                                                                                _bloc.state.competitionDetail?.id);
                                                                      },
                                                                      shape: RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(4)),
                                                                      child: Padding(
                                                                          padding: const EdgeInsets.only(bottom: 10, top: 10),
                                                                          child: Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: const [
                                                                              Icon(Icons.description, size: 15),
                                                                              SizedBox(
                                                                                width: 5,
                                                                              ),
                                                                              Text("Các vòng thi", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15))
                                                                            ],
                                                                          ))),
                                                            ),
                                                        ]),
                                                    if (state
                                                                .competitionDetail
                                                                ?.status ==
                                                            CompetitionStatus
                                                                .Finish ||
                                                        state.competitionDetail
                                                                ?.status ==
                                                            CompetitionStatus
                                                                .Complete ||
                                                        state.competitionDetail
                                                                ?.status ==
                                                            CompetitionStatus
                                                                .End)
                                                      Container(
                                                        width: 420.0,
                                                        height: 37,
                                                        child: RaisedButton(
                                                            textColor:
                                                                ArgonColors
                                                                    .white,
                                                            color: ArgonColors
                                                                .info,
                                                            onPressed: () {
                                                              Navigator.pushNamed(
                                                                  context,
                                                                  Routes
                                                                      .viewCompetitionRoundResult,
                                                                  arguments: {
                                                                    'competitionId':
                                                                        state
                                                                            .competitionDetail
                                                                            ?.id
                                                                  });
                                                            },
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            4)),
                                                            child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        bottom:
                                                                            10,
                                                                        top:
                                                                            10),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: const [
                                                                    Icon(
                                                                        Icons
                                                                            .description,
                                                                        size:
                                                                            15),
                                                                    SizedBox(
                                                                      width: 5,
                                                                    ),
                                                                    Text(
                                                                        "Kết quả cuộc thi",
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            fontSize: 15))
                                                                  ],
                                                                ))),
                                                      ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                alignment: Alignment.center,
                                                margin:
                                                    const EdgeInsets.all(15.0),
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color:
                                                            ArgonColors.white),
                                                    color: ArgonColors.error,
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                4))),
                                                child: Text(
                                                    "Hạn cuối đăng ký: ${Utils.convertDateTime(_bloc.state.competitionDetail!.endTimeRegister)}",
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                    )),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10, left: 10),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                        "${_bloc.state.competitionDetail?.view} lượt xem",
                                                        style: const TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 18)),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 16),
                                                child: Container(
                                                    width: double.infinity,
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 15,
                                                            left: 15,
                                                            bottom: 15),
                                                    child:
                                                        //Publish
                                                        (state.competitionDetail
                                                                    ?.status ==
                                                                CompetitionStatus
                                                                    .Publish)
                                                            ? FlatButton(
                                                                textColor:
                                                                    ArgonColors
                                                                        .white,
                                                                color: AppColors
                                                                    .greyColor,
                                                                onPressed: () {
                                                                  // _bloc.add(ParticipateTheCompetitionEvent(
                                                                  //     competitionId: (state
                                                                  //         .competitionDetail
                                                                  //         ?.id)!));
                                                                },
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              4.0),
                                                                ),
                                                                child: const Padding(
                                                                    padding: EdgeInsets.only(
                                                                        left:
                                                                            16.0,
                                                                        right:
                                                                            16.0,
                                                                        top: 12,
                                                                        bottom:
                                                                            12),
                                                                    child: Text(
                                                                        "Chuẩn bị mở Tham Gia",
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            fontSize: 18.0))),
                                                              )

                                                            //Register time nhưng chưa tham gia
                                                            : (state.isParticipant ==
                                                                        false &&
                                                                    state.competitionDetail
                                                                            ?.status ==
                                                                        CompetitionStatus
                                                                            .Register)
                                                                ? FlatButton(
                                                                    textColor:
                                                                        ArgonColors
                                                                            .white,
                                                                    color: AppColors
                                                                        .mainColor,
                                                                    onPressed:
                                                                        () {
                                                                      //show dialog thông báo nếu như có thu phí seedpoints
                                                                      if (state
                                                                              .competitionDetail!
                                                                              .seedsDeposited >
                                                                          0) {
                                                                        AwesomeDialog(
                                                                          context:
                                                                              context,
                                                                          keyboardAware:
                                                                              true,
                                                                          dismissOnBackKeyPress:
                                                                              false,
                                                                          dialogType:
                                                                              DialogType.WARNING,
                                                                          animType:
                                                                              AnimType.BOTTOMSLIDE,
                                                                          btnCancelText:
                                                                              "Hủy",
                                                                          btnOkText:
                                                                              "Xác Nhận",
                                                                          title:
                                                                              'Bạn Chắc Chứ',
                                                                          // padding: const EdgeInsets.all(5.0),
                                                                          desc: (state.competitionDetail?.numberOfTeam != 0)
                                                                              ? 'Do Cuộc Thi này có thu điểm cọc trước là ${state.competitionDetail!.seedsDeposited}SP, bạn vẫn muốn tham gia chứ ?'
                                                                              : 'Do Sự Kiện này có thu điểm cọc trước là ${state.competitionDetail!.seedsDeposited}SP, bạn vẫn muốn tham gia chứ ?',
                                                                          btnCancelOnPress:
                                                                              () {
                                                                            //Navigator.of(context).pop();
                                                                          },
                                                                          btnOkOnPress:
                                                                              () {
                                                                            _bloc.add(ParticipateTheCompetitionEvent(competitionId: (state.competitionDetail?.id)!));
                                                                          },
                                                                        ).show();
                                                                      } else {
                                                                        _bloc.add(ParticipateTheCompetitionEvent(
                                                                            competitionId:
                                                                                (state.competitionDetail?.id)!));
                                                                      }
                                                                    },
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              4.0),
                                                                    ),
                                                                    child: const Padding(
                                                                        padding: EdgeInsets.only(
                                                                            left:
                                                                                16.0,
                                                                            right:
                                                                                16.0,
                                                                            top:
                                                                                12,
                                                                            bottom:
                                                                                12),
                                                                        child: Text(
                                                                            "Tham gia ngay",
                                                                            style:
                                                                                TextStyle(fontWeight: FontWeight.w600, fontSize: 18.0))),
                                                                  )
                                                                //tham gia r nhưng vẫn còn register
                                                                : (state.isParticipant ==
                                                                            true &&
                                                                        (state.competitionDetail?.status ==
                                                                            CompetitionStatus
                                                                                .Register))
                                                                    ? FlatButton(
                                                                        textColor:
                                                                            ArgonColors.white,
                                                                        color: Colors
                                                                            .green,
                                                                        onPressed:
                                                                            () {},
                                                                        shape:
                                                                            RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(4.0),
                                                                        ),
                                                                        child: const Padding(
                                                                            padding: EdgeInsets.only(
                                                                                left: 16.0,
                                                                                right: 16.0,
                                                                                top: 12,
                                                                                bottom: 12),
                                                                            child: Text("Đã tham gia", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18.0))),
                                                                      )
                                                                    //tham gia mà chưa điểm danh
                                                                    : ((state.isAttendance == false) &&
                                                                            (state.isParticipant ==
                                                                                true) &&
                                                                            (state.competitionDetail?.status == CompetitionStatus.Upcoming ||
                                                                                state.competitionDetail?.status == CompetitionStatus.Start ||
                                                                                state.competitionDetail?.status == CompetitionStatus.OnGoing))
                                                                        ? FlatButton(
                                                                            textColor:
                                                                                ArgonColors.white,
                                                                            color: (state.competitionDetail?.status == CompetitionStatus.Upcoming)
                                                                                ? AppColors.greyColor
                                                                                : AppColors.mainColor,
                                                                            onPressed:
                                                                                () {
                                                                              if (state.competitionDetail?.status != CompetitionStatus.Start && state.competitionDetail?.status != CompetitionStatus.OnGoing) {
                                                                                AwesomeDialog(
                                                                                  context: context,
                                                                                  dialogType: DialogType.ERROR,
                                                                                  animType: AnimType.RIGHSLIDE,
                                                                                  headerAnimationLoop: true,
                                                                                  title: 'Thất Bại',
                                                                                  desc: 'Không thể điểm danh vì chưa tới thời gian điểm danh, xin vui lòng quay lại sau',
                                                                                  btnOkOnPress: () {},
                                                                                  btnOkIcon: Icons.cancel,
                                                                                  btnOkColor: Colors.red,
                                                                                ).show();
                                                                                return;
                                                                              }
                                                                              print("Điểm danh");
                                                                              _bloc.add(AttendanceCompetitionEvent(seedsCode: (state.competitionDetail?.seedsCode)!));
                                                                            },
                                                                            shape:
                                                                                RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(8.0),
                                                                            ),
                                                                            child:
                                                                                const Padding(padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 12, bottom: 12), child: Text("Điểm danh", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18.0))),
                                                                          )
                                                                        //là participant và đã điểm danh
                                                                        : (state.isAttendance == true && (state.competitionDetail?.status == CompetitionStatus.Start || state.competitionDetail?.status == CompetitionStatus.OnGoing))
                                                                            ? FlatButton(
                                                                                textColor: ArgonColors.white,
                                                                                color: Colors.green,
                                                                                onPressed: () {},
                                                                                shape: RoundedRectangleBorder(
                                                                                  borderRadius: BorderRadius.circular(4.0),
                                                                                ),
                                                                                child: const Padding(padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 12, bottom: 12), child: Text("Đã Điểm Danh", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18.0))),
                                                                              )
                                                                            //TH còn lại -> hiện là cuộc thi đã kết thúc
                                                                            : (state.competitionDetail?.status == CompetitionStatus.Pending)
                                                                                ? FlatButton(
                                                                                    textColor: ArgonColors.white,
                                                                                    color: Colors.grey,
                                                                                    onPressed: () {},
                                                                                    shape: RoundedRectangleBorder(
                                                                                      borderRadius: BorderRadius.circular(4.0),
                                                                                    ),
                                                                                    child: Padding(padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 12, bottom: 12), child: (state.competitionDetail?.numberOfTeam != 0) ? Text("Cuộc Thi chưa thể bắt đầu vì một vài lý do", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18.0)) : Text("Sự Kiện chưa thể bắt đầu vì một vài lý do", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18.0))),
                                                                                  )
                                                                                : FlatButton(
                                                                                    textColor: ArgonColors.white,
                                                                                    color: Colors.grey,
                                                                                    onPressed: () {},
                                                                                    shape: RoundedRectangleBorder(
                                                                                      borderRadius: BorderRadius.circular(4.0),
                                                                                    ),
                                                                                    child: Padding(padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 12, bottom: 12), child: (state.competitionDetail?.numberOfTeam != 0) ? Text("Cuộc Thi đã kết thúc", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18.0)) : Text("Sự Kiện đã kết thúc", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18.0))),
                                                                                  )),
                                              ),
                                            ],
                                          ),
                                        )),
                                  ),
                                ]),
                              ],
                            ),
                          ),
                        ]),
                      )
                    ]));
        });
  }
}
