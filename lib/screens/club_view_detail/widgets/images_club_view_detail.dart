import 'package:flutter/material.dart';

import '../../../constants/Constants.dart';
import '../../../models/entities/club/club_model.dart';
import '../../size_config.dart';

class ClubImages extends StatefulWidget {
  const ClubImages({
    Key? key,
    required this.club,
  }) : super(key: key);

  final ClubModel? club;

  @override
  _ClubImagesState createState() => _ClubImagesState();
}

class _ClubImagesState extends State<ClubImages> {
  int selectedImage = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: getProportionateScreenWidth(150), //238
          child: AspectRatio(
            aspectRatio: 1,
            child: Hero(
              tag: (widget.club?.id == null) ? -1 : widget.club!.id,
              child: (widget.club?.image == null)
                  ? Image.network(
                      "https://docs.flutter.dev/assets/images/dash/dash-fainting.gif")
                  : Image.network(widget.club!.image.toString()),
            ),
          ),
        ),
        // SizedBox(height: getProportionateScreenWidth(20)),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     ...List.generate(5, (index) => buildSmallImagePreview(index)),
        //   ],
        // )
      ],
    );
  }

// hàm này chưa build xong thành hàm của mình
  GestureDetector buildSmallImagePreview(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedImage = index;
        });
      },
      child: AnimatedContainer(
        duration: defaultDuration,
        margin: EdgeInsets.only(right: 15),
        padding: EdgeInsets.all(8),
        height: getProportionateScreenWidth(48),
        width: getProportionateScreenWidth(48),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: kPrimaryColor.withOpacity(selectedImage == index ? 1 : 0)),
        ),
        child: (widget.club?.image == null)
            ? Image.network(
                "https://docs.flutter.dev/assets/images/dash/dash-fainting.gif")
            : Image.network(widget.club!.image
                .toString()), //Image.asset(widget.product.images[index]),
      ),
    );
  }
}
