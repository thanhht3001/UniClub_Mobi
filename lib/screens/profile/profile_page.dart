import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicec_mobi/bloc/profile/profile_bloc.dart';
import 'package:unicec_mobi/utils/app_color.dart';
import 'component/body.dart';

class ProfilePage extends StatefulWidget {
  static String routeName = "/profile";
  ProfileBloc bloc;

  ProfilePage({required this.bloc});

  @override
  State<StatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with AutomaticKeepAliveClientMixin {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  ProfileBloc get _bloc => widget.bloc;

  @override
  void initState() {
    super.initState();
    _bloc.listenerStream.listen((event) {});
    // _bloc.add(LoadProfileEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
        value: _bloc,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Trang cá nhân",
                style: TextStyle(color: Colors.white)),
            automaticallyImplyLeading: false,
            backgroundColor: AppColors.mainColor,
            centerTitle: true,
          ),
          body: Body(),
          //bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.profile),
        ));
  }
}
