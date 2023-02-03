import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:unicec_mobi/constants/Theme.dart';
import 'package:unicec_mobi/models/common/current_user.dart';
import 'package:unicec_mobi/utils/app_color.dart';
import 'package:unicec_mobi/utils/firebase.dart';
import 'package:unicec_mobi/utils/router.dart';
import '../../../bloc/profile/profile_bloc.dart';
import '../../../bloc/profile/profile_event.dart';
import '../../../bloc/profile/profile_state.dart';
import '../../../utils/loading.dart';
import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatelessWidget {
  CurrentUser user = GetIt.I.get<CurrentUser>();
  Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProfileBloc bloc = BlocProvider.of<ProfileBloc>(context);
    bloc.add(LoadSeedsWalletEvent());
    bloc.isLoading = true;

    return BlocBuilder<ProfileBloc, ProfileState>(
        bloc: bloc,
        builder: (context, state) {
          return (bloc.isLoading)
              ? Loading()
              : SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 25.0),
                            child: ProfilePic(avatar: user.avatar!),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(user.fullname,
                                      style: const TextStyle(
                                          color: Color.fromRGBO(50, 50, 93, 1),
                                          fontSize: 23.0,
                                          fontWeight: FontWeight.bold)),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20.0),
                                    child: Container(
                                      margin: const EdgeInsets.only(right: 20),
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: AppColors.mainColor),
                                          color: AppColors.mainColor,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10))),
                                      child:
                                          Text("${state.seedsWallet?.amount ?? 0} điểm",
                                              style: const TextStyle(
                                                  // color: Colors.bl,
                                                  fontSize: 18,
                                                  color: ArgonColors.white)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      ProfileMenu(
                        text: "Thông tin chi tiết",
                        icon: "assets/icons/icon-user.svg",
                        press: () => {
                          Navigator.pushNamed(context, Routes.myAccount,
                              arguments: GetIt.I.get<CurrentUser>().id)
                        },
                      ),
                      ProfileMenu(
                        text: "Cuộc Thi và Sự Kiện đang tham gia",
                        icon: "assets/icons/trophy.svg",
                        press: () {
                          Navigator.of(context).pushNamed(
                              Routes.viewListCompetitionOfParticipant);
                        },
                      ),
                      ProfileMenu(
                        text: "Cài đặt",
                        icon: "assets/icons/Settings.svg",
                        press: () {},
                      ),
                      ProfileMenu(
                        text: "Trung tâm trợ giúp",
                        icon: "assets/icons/Question mark.svg",
                        press: () {},
                      ),
                      ProfileMenu(
                        text: "Đăng xuất",
                        icon: "assets/icons/Log out.svg",
                        press: () async {
                          await FirebaseUtils.logout();
                          Navigator.pushReplacementNamed(context, Routes.login);
                        },
                      ),
                    ],
                  ),
                );
        });
  }
}
