import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/firebase.dart';
import '../../utils/router.dart';

import '../../constants/theme.dart';

import 'drawer-tile.dart';

class ArgonDrawer extends StatelessWidget {
  final String? currentPage;

  ArgonDrawer({this.currentPage});

  // _launchURL() async {
  //   const url = 'https://creative-tim.com';
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
      color: ArgonColors.white,
      child: Column(children: [
        Container(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width * 0.85,
            child: SafeArea(
              bottom: false,
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 32),
                  child: Image.asset("assets/img/argon-logo.png"),
                ),
              ),
            )),
        Expanded(
          flex: 2,
          child: ListView(
            padding: const EdgeInsets.only(top: 24, left: 16, right: 16),
            children: [
              //Cuộc Thi và Sự Kiện
              DrawerTile(
                  icon: Icons.home,
                  onTap: () {
                    if (currentPage != "Home") {
                      Navigator.pushNamed(context, '/home');
                    }
                  },
                  iconColor: ArgonColors.primary,
                  title: "Cuộc Thi và Sự Kiện (not yet)",
                  isSelected: currentPage == "Home" ? true : false),

              //Câu lạc bộ
              DrawerTile(
                  icon: Icons.pie_chart,
                  onTap: () {
                    if (currentPage != "Club") {
                      //Navigator.pushNamed(context, '/profile');
                      Navigator.of(context).pushReplacementNamed(Routes.club);
                    }
                  },
                  iconColor: ArgonColors.warning,
                  title: "Câu Lạc Bộ (doing)",
                  isSelected: currentPage == "Club" ? true : false),

              //Competition Activity
              DrawerTile(
                  icon: Icons.apps,
                  onTap: () {
                    if (currentPage != "CompetitionActivity") {
                      Navigator.of(context).pushReplacementNamed(Routes.task);
                    }
                  },
                  iconColor: ArgonColors.primary,
                  title: "Tasks Của Bạn (not yet)",
                  isSelected:
                      currentPage == "CompetitionActivity" ? true : false),

              //Profile
              DrawerTile(
                  icon: Icons.account_circle,
                  onTap: () {
                    if (currentPage != "Profile") {
                      Navigator.of(context)
                          .pushNamed(Routes.profile);
                    }
                  },
                  iconColor: ArgonColors.info,
                  title: "Thông Tin Sinh Viên (doing)",
                  isSelected: currentPage == "Profile" ? true : false),

              //Chức năng Logout
              // DrawerTile(
              //   icon: Icons.settings_input_component,
              //   onTap: () async {
              //     //event logout
              //     await FirebaseUtils.logout();
              //     Navigator.of(context).pushReplacementNamed(Routes.splash);
              //   },
              //   iconColor: ArgonColors.error,
              //   title: "Logout (done)",
              //   //isSelected: currentPage == "Elements" ? true : false),
              // ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
              padding: EdgeInsets.only(left: 8, right: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(height: 4, thickness: 0, color: ArgonColors.muted),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 16.0, left: 16, bottom: 8),
                    child: Text("DOCUMENTATION",
                        style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 0.5),
                          fontSize: 15,
                        )),
                  ),
                  DrawerTile(
                      icon: Icons.airplanemode_active,
                      //onTap: _launchURL,
                      onTap: () {},
                      iconColor: ArgonColors.muted,
                      title: "Getting Started",
                      isSelected:
                          currentPage == "Getting started" ? true : false),
                ],
              )),
        ),
      ]),
    ));
  }
}
