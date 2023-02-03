import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:unicec_mobi/utils/app_color.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('loading widget');
    return Container(
      color: Colors.white,
      child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        SpinKitCircle(
          color: AppColors.mainColor,
          size: 50.0,
        ),
        SizedBox(height: 10),
        Text("Đang tải...")
      ])),
    );
  }
}
