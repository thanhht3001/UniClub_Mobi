import 'package:flutter/material.dart';

class ProfilePic extends StatelessWidget {
  String avatar;
  ProfilePic({
    required this.avatar,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(avatar),
          )
        ],
      ),
    );
  }
}