import 'package:flutter/material.dart';
import '../../../animation/fade_animation.dart';
import '../../../utils/dimens.dart';

class LoginHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: Dimens.size20, right: Dimens.size20, top: 20, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FadeAnimation(
              delay: Dimens.size1,
              child: Text(
                "Đăng nhập",
                style: TextStyle(color: Colors.white, fontSize: Dimens.size40),
              )),
          SizedBox(
            height: Dimens.size10,
          ),
          FadeAnimation(
              delay: Dimens.size1p3,
              child: Text(
                "Chào mừng đến với UniCEC",
                style: TextStyle(color: Colors.white, fontSize: Dimens.size18),
              )),
        ],
      ),
    );
  }
}
