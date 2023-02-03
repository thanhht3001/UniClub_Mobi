import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:unicec_mobi/bloc/my_account/my_account_bloc.dart';
import 'package:unicec_mobi/constants/Theme.dart';
import 'package:unicec_mobi/utils/log.dart';
import '../../bloc/my_account/my_account_event.dart';
import '../../bloc/my_account/my_account_state.dart';

//widgets
import '../../models/common/current_user.dart';
import '../../utils/app_color.dart';
import '../../utils/dimens.dart';
import '../../utils/loading.dart';

class MyAccountPage extends StatefulWidget {
  final MyAccountBloc bloc;

  MyAccountPage({required this.bloc});

  @override
  _MyAccountPageState createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage>
    with AutomaticKeepAliveClientMixin {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  MyAccountBloc get _bloc => widget.bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc.listenerStream.listen((event) {});
    //_bloc.add(LoadInfoAccountEvent());
  }

  void didChangeDependencies() {
    super.didChangeDependencies();
    //nhận data
    RouteSettings settings = ModalRoute.of(context)!.settings;
    if (settings.arguments != null) {
      int userId = settings.arguments as int;
      Log.info('settings.arguments: $userId');
      if (userId > 0) {
        _bloc.add(ReceiveDataEvent(userId: userId));
        _bloc.isLoading = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    CurrentUser currentUser = GetIt.I.get<CurrentUser>();
    Log.info('init render UI my_account_page');

    return BlocBuilder<MyAccountBloc, MyAccountState>(
        bloc: _bloc,
        builder: (context, state) {
          // print('user: ${currentUser.avatar}');
          return Scaffold(
              extendBodyBehindAppBar: true,
              // appBar: NavbarProfile(
              //   title: "Thông Tin Sinh Viên",
              //   transparent: true,
              //   backButton: true,
              // ),
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                ),
                title: const Text("Thông tin tài khoản",
                    style: TextStyle(color: Colors.white)),
                centerTitle: true,
                backgroundColor: AppColors.mainColor,
              ),
              backgroundColor: AppColors.backgroundPageColor,
              // drawer: ArgonDrawer(currentPage: "My account"),
              body: (_bloc.isLoading)
                  ? Loading()
                  : Stack(children: <Widget>[
                      SafeArea(
                        child: ListView(children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 16.0, right: 16.0, top: 90.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Stack(children: <Widget>[
                                  Container(
                                    // decoration: BoxDecoration(
                                    //   boxShadow: [
                                    //     BoxShadow(
                                    //       color: Colors.grey.withOpacity(0.1),
                                    //       spreadRadius: 1,
                                    //       blurRadius: 7,
                                    //       offset: Offset(
                                    //           0, 3), // changes position of shadow
                                    //     ),
                                    //   ],
                                    // ),
                                    child: Container(
                                        child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 85.0, bottom: 20.0),
                                      child: Column(
                                        children: [
                                          Align(
                                            child: Text(
                                                "${state.user.fullname}",
                                                style: const TextStyle(
                                                    color: Color.fromRGBO(
                                                        50, 50, 93, 1),
                                                    fontSize: 28.0,
                                                    fontWeight:
                                                        FontWeight.w800)),
                                          ),
                                          const SizedBox(height: 10.0),
                                          state.user.id ==
                                                  GetIt.I.get<CurrentUser>().id
                                              ? Align(
                                                  child: Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 20),
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    0.15)),
                                                        color: Colors.grey
                                                            .withOpacity(0.15),
                                                        borderRadius:
                                                            const BorderRadius
                                                                    .all(
                                                                Radius.circular(
                                                                    10))),
                                                    child: Text(
                                                        "${state.user.studentCode} | ${state.seedsWallet?.amount ?? 0} điểm",
                                                        style: const TextStyle(
                                                          fontSize: 18,
                                                        )),
                                                  ),
                                                )
                                              : const SizedBox.shrink(),
                                          const Divider(
                                            height: 40.0,
                                            thickness: 1.5,
                                            indent: 32.0,
                                            endIndent: 32.0,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 32.0, right: 32.0),
                                            child: Align(
                                              child: Text(
                                                  state.user.description,
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                      fontSize: 17.0,
                                                      fontWeight:
                                                          FontWeight.w400)),
                                            ),
                                          ),
                                          SizedBox(height: Dimens.size20),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: Dimens.size20),
                                            child: Container(
                                              child: Column(children: [
                                                Padding(
                                                  padding: EdgeInsets.all(
                                                      Dimens.size10),
                                                  child: Row(children: [
                                                    const Icon(Icons.school),
                                                    //account_circle_outlined
                                                    SizedBox(
                                                      width: Dimens.size20,
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        state.user
                                                                .universityName ??
                                                            '',
                                                        style: const TextStyle(
                                                            fontSize: 18),
                                                      ),
                                                    )
                                                  ]),
                                                ),
                                                // Divider(
                                                //   height: 0.6,
                                                //   color: Colors.black,
                                                // ),
                                                Padding(
                                                  padding: EdgeInsets.all(
                                                      Dimens.size10),
                                                  child: Row(children: [
                                                    const Icon(
                                                        Icons.business_center),
                                                    SizedBox(
                                                      width: Dimens.size20,
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        state.user
                                                                .departmentName ??
                                                            '',
                                                        style: const TextStyle(
                                                            fontSize: 18),
                                                      ),
                                                    )
                                                  ]),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.all(
                                                      Dimens.size10),
                                                  child: Row(children: [
                                                    const Icon(
                                                        Icons.alternate_email),
                                                    SizedBox(
                                                      width: Dimens.size20,
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        state.user.email,
                                                        style: const TextStyle(
                                                            fontSize: 17),
                                                      ),
                                                    )
                                                  ]),
                                                ),
                                                state.user.phoneNumber
                                                        .isNotEmpty
                                                    ? Padding(
                                                        padding: EdgeInsets.all(
                                                            Dimens.size10),
                                                        child: Row(children: [
                                                          const Icon(
                                                              Icons.phone),
                                                          SizedBox(
                                                            width:
                                                                Dimens.size20,
                                                          ),
                                                          Text(
                                                            state.user
                                                                .phoneNumber,
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        17),
                                                          )
                                                        ]),
                                                      )
                                                    : const SizedBox.shrink(),
                                                state.user.dob.isNotEmpty
                                                    ? Padding(
                                                        padding: EdgeInsets.all(
                                                            Dimens.size10),
                                                        child: Row(children: [
                                                          const Icon(
                                                              Icons.cake),
                                                          SizedBox(
                                                            width:
                                                                Dimens.size20,
                                                          ),
                                                          Text(
                                                            state.user.dob,
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        17),
                                                          )
                                                        ]),
                                                      )
                                                    : const SizedBox.shrink(),
                                                Padding(
                                                  padding: EdgeInsets.all(
                                                      Dimens.size10),
                                                  child: Row(children: [
                                                    const Icon(
                                                        Icons.transgender),
                                                    SizedBox(
                                                      width: Dimens.size20,
                                                    ),
                                                    Text(
                                                      (state.user.gender
                                                              .contains("Male")
                                                          ? "Nam"
                                                          : "Nữ"),
                                                      style: const TextStyle(
                                                          fontSize: 17),
                                                    )
                                                  ]),
                                                ),
                                              ]),
                                            ),
                                          )
                                        ],
                                      ),
                                    )),
                                  ),
                                  FractionalTranslation(
                                      translation: const Offset(0.0, -0.5),
                                      child: Align(
                                        alignment:
                                            const FractionalOffset(0.5, 0.0),
                                        child: CircleAvatar(
                                          backgroundImage:
                                              NetworkImage(state.user.avatar),
                                          radius: 65.0,
                                          // maxRadius: 200.0,
                                        ),
                                      ))
                                ]),
                                (state.user.id == GetIt.I.get<CurrentUser>().id)
                                    ? Padding(
                                        padding: const EdgeInsets.only(top: 16),
                                        child: Container(
                                          width: double.infinity,
                                          margin: const EdgeInsets.only(
                                              right: 15, left: 15, bottom: 15),
                                          child: FlatButton(
                                            textColor: ArgonColors.white,
                                            color: ArgonColors.warning,
                                            onPressed: () async {
                                              // Respond to button press
                                              int userId =
                                                  await Navigator.pushNamed(
                                                      context,
                                                      '/editMyAccount') as int;
                                              //.then((value) => _bloc.add(ReceiveDataEvent(userId: value as int))
                                              //);
                                              if (userId != null) {
                                                _bloc.add(ReceiveDataEvent(
                                                    userId: userId));
                                              }
                                            },
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            child: const Padding(
                                                padding: EdgeInsets.only(
                                                    left: 16.0,
                                                    right: 16.0,
                                                    top: 12,
                                                    bottom: 12),
                                                child: Text(
                                                    "Chỉnh sửa thông tin",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 18.0))),
                                          ),
                                        ),
                                      )
                                    : Text(''),
                              ],
                            ),
                          ),
                        ]),
                      )
                    ]));
        });
  }
}
