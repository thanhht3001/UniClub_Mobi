import 'package:unicec_mobi/utils/app_color.dart';

import '../../../animation/fade_animation.dart';
import '../../../bloc/login/login_bloc.dart';
import '../../../bloc/login/login_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../bloc/login/login_state.dart';
import '../../../utils/dimens.dart';

class LoginBody extends StatelessWidget {
  LoginBloc bloc;

  LoginBody({required this.bloc});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Dimens.size60),
              topRight: Radius.circular(Dimens.size60))),
      padding: EdgeInsets.all(Dimens.size30),
      child: BlocBuilder<LoginBloc, LoginState>(
        bloc: bloc,
        builder: (context, state) {
          return Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: FadeAnimation(
                    delay: Dimens.size1p7,
                    child: const Text(
                      "Đăng nhập với",
                      style: TextStyle(color: Colors.grey, fontSize: 18.0),
                    )),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FadeAnimation(
                      delay: Dimens.size1p8,
                      child: InkWell(
                        onTap: () {
                          bloc.add(LoadingEvent());
                          bloc.add(SignInGoogleEvent());
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            backgroundColor: Colors.orange[600],
                            child: const Icon(FontAwesomeIcons.google,
                                color: Colors.white),
                          ),
                        ),
                      )),
                ],
              ),
              SizedBox(
                height: Dimens.size80,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FadeAnimation(
                      delay: Dimens.size1p8,
                      child: Container(
                          width: 195.0,
                          height: 50.0,
                          decoration: BoxDecoration(
                              color: AppColors.mainColor,
                              image: const DecorationImage(
                                  image: AssetImage(
                                      "assets/img/logo-name-app.jpg"),
                                  fit: BoxFit.contain)))),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
