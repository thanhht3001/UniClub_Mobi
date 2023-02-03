import 'package:flutter/material.dart';
import '../../constants/theme.dart';
import '../size_config.dart';

class CardHorizontal extends StatelessWidget {
  CardHorizontal(
      {this.title = "Placeholder Title",
      this.cta = "",
        this.date = "",
        this.type = "",
      this.img = "https://via.placeholder.com/200",
      this.tap = defaultFunc});

  final String cta;
  final String img;
  VoidCallback tap;
  final String title;
  final String date;
  final String type;

  static void defaultFunc() {
    print("the function works!");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 130,
        child: GestureDetector(
          onTap: tap,
          //onTap: () {},
          child: Card(
            elevation: 0.6,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(6.0))),
            child: Row(
              children: [
                Flexible(
                  flex: 1,
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(6.0),
                              bottomLeft: Radius.circular(6.0)),
                          image: DecorationImage(
                            image: NetworkImage(img),
                            fit: BoxFit.cover,
                          ))),
                ),
                Flexible(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text("@" + type,
                                  style: TextStyle(
                                      color: ArgonColors.warning, fontSize: 13)),
                              SizedBox(width: getProportionateScreenWidth(30)),
                              Text(date,
                                  style: TextStyle(
                                      color: ArgonColors.secondary, fontSize: 13, backgroundColor: Colors.red)),
                            ],
                          ),
                          Text(title,
                              style: TextStyle(
                                  color: ArgonColors.header, fontSize: 13)),
                          Text(cta,
                              style: TextStyle(
                                  color: ArgonColors.primary,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ));
  }
}
