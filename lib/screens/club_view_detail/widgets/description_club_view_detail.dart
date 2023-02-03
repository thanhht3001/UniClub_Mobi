import 'package:flutter/material.dart';
import 'package:unicec_mobi/utils/utils.dart';
import '../../../models/entities/club/club_model.dart';
import '../../size_config.dart';

class ClubViewDetailDescription extends StatefulWidget {
  const ClubViewDetailDescription({
    Key? key,
    required this.club,
    //this.pressOnSeeMore,
  }) : super(key: key);

  final ClubModel? club;
  //final GestureTapCallback? pressOnSeeMore;

  @override
  State<ClubViewDetailDescription> createState() =>
      _ClubViewDetailDescriptionState();
}

class _ClubViewDetailDescriptionState extends State<ClubViewDetailDescription> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 60.0, left: 20),
              child: FractionalTranslation(
                  translation: Offset(0.0, -0.5),
                  child: Align(
                    alignment: FractionalOffset(0.5, 0.0),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://lh3.googleusercontent.com/DQj-gonAVTlhj5W7_DhBVmX-0P42rfvx8TSp1WfQeZ6iFIon6InIS8M4Nbqy7Ql5ahgEXSiRDiWD88v-bcPYIEAg3Q=w640-h400-e365-rj-sc0x00ffffff"),
                      radius: 40.0,
                    ),
                  )),
            ),
            Column(
              children: [
                Padding(
                    padding: const EdgeInsets.only(left: 0),
                    child: (widget.club?.name == null)
                        ? Text(
                            'Không tìm thấy tên',
                            style: Theme.of(context).textTheme.headline6,
                          )
                        : Text(
                            widget.club!.name,
                            style: const TextStyle(
                              color: Color.fromRGBO(50, 50, 93, 1),
                              fontSize: 23.0,
                            ),
                          )),
                Padding(
                    padding: const EdgeInsets.only(top: 20, left: 20),
                    child: (widget.club?.founding == null)
                        ? Text(
                            '',
                            style: Theme.of(context).textTheme.headline6,
                          )
                        : Text(
                            Utils.convertDateTime(widget.club!.founding),
                            // widget.club!.founding.toString(),
                            style: const TextStyle(
                              color: Color.fromRGBO(50, 50, 93, 1),
                              fontSize: 16.0,
                            ),
                          )),
              ],
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(20), vertical: 20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: const [
                Text(
                  'Giới thiệu',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                ),
              ],
            ),
            if (widget.club?.description == null)
              Text(
                '',
                maxLines: 10,
              ),
            if (widget.club?.description != null)
              Text(
                widget.club!.description,
                maxLines: 10,
                style: TextStyle(fontSize: 16),
              ),
          ]),
        ),

        // //description
        // Padding(
        //   padding: EdgeInsets.only(
        //     left: getProportionateScreenWidth(20),
        //     right: getProportionateScreenWidth(64),
        //   ),
        //   child: (widget.club?.description == null)
        //       ? Text(
        //           '',
        //           maxLines: 10,
        //         )
        //       : Text(
        //           widget.club!.description,
        //           maxLines: 10,
        //           style: TextStyle(fontSize: 16),
        //         ),
        // ),

        //Thông tin liên hệ
        Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(20),
              vertical: 30,
            ),
            child: Column(children: [
              if (widget.club?.clubFanpage != null ||
                  widget.club?.clubContact != null)
                Row(
                  children: const [
                    Text(
                      'Thông tin liên hệ',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                    ),
                  ],
                ),
              const SizedBox(height: 10),
              if (widget.club?.clubFanpage != null)
                Padding(
                  padding: const EdgeInsets.only(left: 0),
                  child: Row(
                    children: [
                      const Icon(Icons.web),
                      const SizedBox(width: 10),
                      Text(
                        widget.club?.clubFanpage ?? '',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 10),
              if (widget.club?.clubContact != null)
                Padding(
                  padding: const EdgeInsets.only(left: 0),
                  child: Row(
                    children: [
                      const Icon(Icons.phone),
                      const SizedBox(width: 10),
                      Text(widget.club?.clubContact ?? '',
                          style: const TextStyle(fontSize: 16)),
                    ],
                  ),
                )
            ]))
        // Padding(
        //   padding: EdgeInsets.symmetric(
        //     horizontal: getProportionateScreenWidth(20),
        //     vertical: 10,
        //   ),
        //   child: GestureDetector(
        //     onTap: () {},
        //     child: Row(
        //       children: [
        //         Text(
        //           "Thông Tin Câu Lạc Bộ",
        //           style: TextStyle(
        //               fontWeight: FontWeight.w600,
        //               color: kPrimaryColor,
        //               fontSize: 20),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        // Padding(
        //     padding: EdgeInsets.symmetric(
        //         horizontal: getProportionateScreenWidth(20)),
        //     child: (widget.club?.name == null)
        //         ? Text(
        //             'Không có dữ liệu name',
        //             style: Theme.of(context).textTheme.headline6,
        //           )
        //         : Text(
        //             widget.club!.name,
        //             style: Theme.of(context).textTheme.headline5,
        //           )),
        // Padding(
        //   padding: EdgeInsets.only(
        //     left: getProportionateScreenWidth(20),
        //     right: getProportionateScreenWidth(64),
        //   ),
        //   child: (widget.club?.description == null)
        //       ? Text(
        //           'Không có dữ liệu Description',
        //           maxLines: 10,
        //         )
        //       : Text(
        //           widget.club!.description,
        //           maxLines: 10,
        //         ),
        // ),
        // Padding(
        //   padding: EdgeInsets.symmetric(
        //     horizontal: getProportionateScreenWidth(20),
        //     vertical: 10,
        //   ),
        //   child: Column(children: [
        //     Text(
        //       'Liên Hệ và Hợp Tác với Chúng Tôi',
        //       style: TextStyle(
        //           fontWeight: FontWeight.w600,
        //           color: kPrimaryColor,
        //           fontSize: 20),
        //     ),
        //     SizedBox(height: 10),
        //     Row(
        //       children: [
        //         Icon(Icons.web),
        //         SizedBox(width: 10),
        //         Text(
        //           widget.club?.clubFanpage ?? 'Không có dữ liệu clubFanpage',
        //         ),
        //       ],
        //     ),
        //     SizedBox(height: 10),
        //     Row(
        //       children: [
        //         Icon(Icons.phone),
        //         SizedBox(width: 10),
        //         Text(
        //           widget.club?.clubContact ?? 'Không có dữ liệu clubContact',
        //         ),
        //       ],
        //     )
        //   ]),
        // )
      ],
    );
  }
}
