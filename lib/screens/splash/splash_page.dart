import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//
import '../../bloc/splash/splash_bloc.dart';
import '../../bloc/splash/splash_event.dart';
import '../../bloc/splash/splash_state.dart';
import '../../utils/app_color.dart';
import '../../utils/dimens.dart';
import '../../utils/firebase.dart';
import '../../utils/router.dart';

class SplashPage extends StatefulWidget {
  final SplashBloc bloc;

  SplashPage({required this.bloc});

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  SplashBloc get bloc => widget.bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(milliseconds: 10), () {
      bloc.add(SplashEvent());
    });

    Future.delayed(const Duration(seconds: 4), () async {
      //await FirebaseUtils.logout();
      Navigator.of(context).pushReplacementNamed(Routes.login);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: BlocBuilder(
          bloc: bloc,
          builder: (context, SplashState state) {
            return AnimatedOpacity(
              duration: const Duration(seconds: 3),
              opacity: state.opacity,
              child: Container(
                  width: MediaQuery.of(context).size.width * 2 / 3,
                  height: MediaQuery.of(context).size.width * 2 / 3,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/img/logo-app-splash.jpg"),
                          alignment: Alignment.center,
                          fit: BoxFit.contain))),
            );
          },
        ),
      ),
    );
  }
}
