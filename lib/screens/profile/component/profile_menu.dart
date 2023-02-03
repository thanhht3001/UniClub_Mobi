import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants/Theme.dart';
import '../../../utils/app_color.dart';
import '../../constants.dart';


class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.text,
    required this.icon,
    this.press,
  }) : super(key: key);

  final String text, icon;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          primary: kPrimaryColor,
          padding: EdgeInsets.all(20),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: Color.fromARGB(255, 235, 237, 241),
        ),
        onPressed: press,
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              color: ArgonColors.warning,
              width: 22,
            ),
            const SizedBox(width: 20),
            Expanded(child: Text(text, style: const TextStyle(fontSize: 18.0, color: Colors.black87, fontWeight: FontWeight.normal),)),
            Icon(Icons.arrow_forward_ios, color: AppColors.mainColor,),
          ],
        ),
      ),
    );
  }
}