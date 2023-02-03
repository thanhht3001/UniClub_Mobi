import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:unicec_mobi/bloc/competition/competition_bloc.dart';
import 'package:unicec_mobi/bloc/view_competition_member_task/view_competition_member_task_bloc.dart';
import 'package:unicec_mobi/bloc/view_detail_match/view_detail_match_bloc.dart';
import 'package:unicec_mobi/bloc/view_list_match/view_list_match_bloc.dart';
import 'package:unicec_mobi/bloc/view_result_team/view_result_team_bloc.dart';
import 'package:unicec_mobi/screens/pages.dart';
import '../../bloc/club/club_bloc.dart';
import '../../bloc/main/main_bloc.dart';
import '../../bloc/main/main_event.dart';
import '../../bloc/main/main_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/notification/notification_bloc.dart';
import '../../bloc/profile/profile_bloc.dart';
import '../../main.dart';
import '../../models/common/current_user.dart';
import '../../utils/app_color.dart';
import '../notification/notification_page.dart';
import '../size_config.dart';
import '../view_detai_match/view_detail_match.dart';
import '../view_list_match/view_list_match.dart';
import '../view_result_team/component/view_result_team_menu.dart';
import '../view_result_team/view_result_team.dart';
import 'widget/component_button.dart';

class MainPage extends StatefulWidget {
  final MainBloc _bloc;

  const MainPage(this._bloc, {Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late PageController _pageController;
  late StreamSubscription _listener;
  // StreamSubscription keyboardSubscription;
  // KeyboardVisibilityController keyboardVisibilityController =
  // KeyboardVisibilityController();

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  MainBloc get bloc => widget._bloc;

  @override
  void initState() {
    super.initState();
    int? clubIdSelected = GetIt.I.get<CurrentUser>().clubIdSelected;
    // if (GetIt.I.get<CurrentUser>().clubIdSelected != 0) {
    if (bloc.state.clubSelected != clubIdSelected) {
      _pageController = PageController(initialPage: 0);
    } else {
      _pageController =
          PageController(initialPage: bloc.state.currentPageIndex);
    }

    // bloc.listenerStream.listen((event) {
    //   if (event is CreateInitialPageView) {
    //     _pageController = PageController(initialPage: 0);
    //   }
    //   if (event is InitialPageView) {
    //     _pageController =
    //         PageController(initialPage: bloc.state.currentPageIndex);
    //   }
    // });

    // bloc.listenerStream.listen((event) {
    //   if (event is SwitchingPageEvent) {
    //     Navigator.of(context).pushNamed(Routes.test);
    //   }
    // });
    //
    // _listener = FirebaseAuth.instance.authStateChanges().listen((user) {
    //   if (user == null) {
    //     //sign out
    //     Navigator.pushReplacementNamed(context, Routes.login);
    //   }
    // });

    // keyboardSubscription =
    //     keyboardVisibilityController.onChange.listen((visible) {
    //       if (visible) {
    //         bloc.add(HidingFloatingActionButtonEvent());
    //       } else {
    //         bloc.add(ShowingFloatingActionButtonEvent());
    //       }
    //     });

    /// gives  you the message on which user taps
    /// and it opened  the app from terminated state
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      // handle when click notification
      if (message != null) {
        final routeFromMessage = message.data['route'];

        Navigator.of(context).pushNamed(routeFromMessage);
      }
    });

    /// foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("FirebaseMessaging.onMessage.title ${message.notification?.title}");
      print('FirebaseMessaging.onMessage.body ${message.notification?.body}');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      // If `onMessage` is triggered with a notification, construct our own
      // local notification to show to users using the created channel.
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(channel.id, channel.name,
                  importance: Importance.high,
                  channelDescription: channel.description,
                  icon: '@mipmap/ic_launcher',
                  color: AppColors.mainColor),
            ));
      }
    });

    // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    //   print(
    //       "FirebaseMessaging.onMessageOpenedApp ${message.notification?.title}");
    //   print(
    //       "FirebaseMessaging.onMessageOpenedApp ${message.notification?.title}");

    //   final routeFromMessage = message.data['click_action'];
    //   print(routeFromMessage);
    //   Navigator.of(context).pushNamed(routeFromMessage);

    //   RemoteNotification? notification = message.notification;
    //   AndroidNotification? android = message.notification?.android;
    //   // If `onMessage` is triggered with a notification, construct our own
    //   // local notification to show to users using the created channel.
    //   if (notification != null && android != null) {
    //     // Navigator.pushNamed(context, Routes.test);
    //     flutterLocalNotificationsPlugin.show(
    //         notification.hashCode,
    //         notification.title,
    //         notification.body,
    //         NotificationDetails(
    //           android: AndroidNotificationDetails(channel.id, channel.name,
    //               importance: Importance.high,
    //               channelDescription: channel.description,
    //               icon: '@mipmap/ic_launcher',
    //               color: AppColors.mainColor),
    //         ));
    //   }

    //   // new part

    // });

    // FirebaseMessaging.onBackgroundMessage((message) {
    //   Log.info("onBackgroundMessage ${message.data}");
    //   // return ;
    // });

    // print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
    // FirebaseFirestore.instance.collection('Notification').get().then((querySnapshot) {
    //   for (var element in querySnapshot.docs) {
    //     Map<String, dynamic> dataMap = element.data();
    //     print("dataMap $dataMap");
    //   }
    // });

    // CollectionReference<Map<String, dynamic>> collection =
    //     FirebaseFirestore.instance.collection("Notification");
    // print("collection.path ${collection.path}");
    // print("collection.id ${collection.id}");
    // collection.add({"test": "aaaaaaa"});
    // rootBundle.load('assets/images/background.jpg').then((byteData) {
    //   return byteData.buffer.asUint8List();
    // }).then((value) {
    //   return collection.doc("test").set({"img_background": Blob(value)});
    // }).then((value) => print("finish")).catchError((error) => print("error: $error"));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  ///Don't use BlocListener, bloc is disposed when navigator to other page,
  ///so that, user stream instead
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocProvider.value(
      value: bloc,
      child: BlocBuilder<MainBloc, MainState>(
        bloc: bloc,
        builder: (context, state) {
          return WillPopScope(
            onWillPop: () async {
              // show the snackbar with some text
              // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              //     content: Text('The System Back Button is Deactivated')));
              // return false;
              return true;
            },
            child: Scaffold(
              body: PageView(
                physics: NeverScrollableScrollPhysics(),
                controller: _pageController,
                onPageChanged: (index) {
                  if (bloc.state.clubSelected !=
                      GetIt.I.get<CurrentUser>().clubIdSelected) {
                    bloc.add(SwitchingPageEvent(pageIndex: index));
                    // update điều kiện
                    bloc.add(UpdateClubSelected());
                  } else {
                    //normal flow
                    bloc.add(SwitchingPageEvent(pageIndex: index));
                  }
                },
                children: <Widget>[
                  // ClubSelectionPage(bloc: GetIt.I.get<ClubSelectionBloc>()),
                  ClubPage(
                      bloc: GetIt.I.get<
                          ClubBloc>()), // cố định tại vị trí là page 0, nếu chuyển sẻ phải implement lại
                  ViewCompetitionMemberTaskPage(
                      bloc: GetIt.I.get<
                          ViewCompetitionMemberTaskBloc>()), // trang show Competition mà Member này có task ở trỏng
                  CompetitionPage(bloc: GetIt.I.get<CompetitionBloc>()),
                  NotificationPage(bloc: GetIt.I.get<NotificationBloc>()),
                  // ViewResultTeamPage(bloc: GetIt.I.get<ViewResultTeamBloc>()),
                  ProfilePage(bloc: GetIt.I.get<ProfileBloc>())
                ],
              ),
              bottomNavigationBar: BottomAppBar(
                shape: const CircularNotchedRectangle(),
                notchMargin: 8,
                child: SizedBox(
                  height: 55,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //CLB
                      Flexible(
                          fit: FlexFit.tight,
                          child: MaterialButton(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            onPressed: () {
                              _pageController.jumpToPage(0);
                            },
                            child: Column(
                              children: [
                                Icon(
                                  Icons.groups,
                                  color:
                                      //ss1 từ clubSelection -> MainPage
                                      ((state.clubSelected !=
                                                  GetIt.I
                                                      .get<CurrentUser>()
                                                      .clubIdSelected) &&
                                              state.currentPageIndex != 1)
                                          ? AppColors.mainColor
                                          : bloc.state.currentPageIndex == 0
                                              ? AppColors.mainColor
                                              : Colors.grey,
                                ),
                                Text(
                                  'Câu Lạc Bộ',
                                  style: TextStyle(
                                      color:
                                          //ss1 từ clubSelection -> MainPage
                                          ((state.clubSelected !=
                                                      GetIt.I
                                                          .get<CurrentUser>()
                                                          .clubIdSelected) &&
                                                  state.currentPageIndex != 1)
                                              ? AppColors.mainColor
                                              : bloc.state.currentPageIndex == 0
                                                  ? AppColors.mainColor
                                                  : Colors.grey,
                                      fontSize: 13),
                                )
                              ],
                            ),
                          )
                          //ComponentButton(
                          //   index: 0,
                          //   label: "Câu Lạc Bộ",
                          //   onPressed: () {
                          //     _pageController.jumpToPage(0);
                          //   },
                          //   clubIdSelected: state.clubSelected,
                          // ),
                          ),
                      Flexible(
                        fit: FlexFit.tight,
                        child: ComponentButton(
                          index: 1,
                          label: "Hoạt động",
                          onPressed: () {
                            _pageController.jumpToPage(1);
                          },
                          clubIdSelected: state.clubSelected,
                        ),
                      ),
                      Container(
                        width: 72,
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Text(
                              "",
                              style: TextStyle(
                                  color:
                                      //ss1 chắc chắn là trang 2
                                      ((state.clubSelected ==
                                                  GetIt.I
                                                      .get<CurrentUser>()
                                                      .clubIdSelected) &&
                                              state.currentPageIndex == 2)
                                          ? AppColors.mainColor
                                          //ss2 dùng để ẩn cho nó qua clb
                                          : ((state.clubSelected !=
                                                      GetIt.I
                                                          .get<CurrentUser>()
                                                          .clubIdSelected) &&
                                                  state.currentPageIndex == 2)
                                              ? Colors.grey
                                              :
                                              //ss3 là bth
                                              state.currentPageIndex == 2
                                                  ? AppColors.mainColor
                                                  : Colors.grey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13),
                            )),
                      ),
                      Flexible(
                        fit: FlexFit.tight,
                        child: ComponentButton(
                          index: 3,
                          label: "Thông báo",
                          onPressed: () {
                            _pageController.jumpToPage(3);
                          },
                          clubIdSelected: state.clubSelected,
                        ),
                      ),
                      Flexible(
                        fit: FlexFit.tight,
                        child: ComponentButton(
                          index: 4,
                          label: "Cá nhân",
                          onPressed: () {
                            // Navigator.of(context).pushNamed(Routes.profile);
                            _pageController.jumpToPage(4);
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
              floatingActionButton: state.isHiddenFAB
                  ? const SizedBox()
                  : FloatingActionButton(
                      child: const Icon(Icons.emoji_events, size: 30.0),
                      onPressed: () {
                        _pageController.jumpToPage(2);
                      },
                      backgroundColor: AppColors.mainColor,
                      heroTag: "main_page",
                    ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              extendBody: true,
              resizeToAvoidBottomInset: false,
            ),
          );
        },
      ),
    );
  }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   _listener.cancel();
  //   super.dispose();
  // }
}
