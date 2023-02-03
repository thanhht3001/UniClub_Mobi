import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../size_config.dart';

class DefaultButton extends StatefulWidget {
  DefaultButton({
    Key? key,
    this.text,
    required this.press,
  }) : super(key: key);
  final String? text;
  VoidCallback press;

  @override
  State<DefaultButton> createState() => _DefaultButtonState();
}

class _DefaultButtonState extends State<DefaultButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: getProportionateScreenHeight(56),
      child: TextButton(
        style: TextButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          primary: Colors.white,
          backgroundColor: kPrimaryColor,
        ),
        onPressed: widget.press,
        child: Text(
          widget.text!,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(18),
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
