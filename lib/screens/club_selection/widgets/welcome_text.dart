import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../../models/common/current_user.dart';
import '../../../utils/dimens.dart';

class WelcomeText extends StatefulWidget {
  const WelcomeText({Key? key}) : super(key: key);

  @override
  State<WelcomeText> createState() => _WelcomeTextState();
}

class _WelcomeTextState extends State<WelcomeText> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(0),
      child: Text('Xin chào, ${GetIt.I.get<CurrentUser>().fullname}',
          style: TextStyle(
              fontSize: Dimens.size25,
              color: Colors.black.withOpacity(Dimens.size0p7),
              fontWeight: FontWeight.bold)),
    );
  }
}
