import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:unicec_mobi/models/entities/member/member_detail_model.dart';
import 'package:unicec_mobi/utils/router.dart';
import '../../../constants/Theme.dart';
import '../../../models/entities/club/club_model.dart';
import '../../../utils/router.dart';
import '../../size_config.dart';

class ClubDescription extends StatefulWidget {
  const ClubDescription({
    Key? key,
    required this.club,
    required this.member,
  }) : super(key: key);

  final ClubModel? club;
  final MemberDetailModel? member;

  @override
  State<ClubDescription> createState() => _ClubDescriptionState();
}

class _ClubDescriptionState extends State<ClubDescription> {
  @override
  Widget build(BuildContext context) {
    const defaultImage = 'https://picsum.photos/seed/513/600';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 60.0, left: 20),
              child: FractionalTranslation(
                  translation: const Offset(0.0, -0.5),
                  child: Align(
                    alignment: const FractionalOffset(0.5, 0.0),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(//AssetImage(
                          widget.club?.image != null
                              ? "${widget.club?.image}"
                              : defaultImage
                          // "https://lh3.googleusercontent.com/DQj-gonAVTlhj5W7_DhBVmX-0P42rfvx8TSp1WfQeZ6iFIon6InIS8M4Nbqy7Ql5ahgEXSiRDiWD88v-bcPYIEAg3Q=w640-h400-e365-rj-sc0x00ffffff"
                          ),
                      radius: 40.0,
                      // maxRadius: 200.0,
                    ),
                  )),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: const EdgeInsets.only(left: 20.0),
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
                                fontWeight: FontWeight.bold),
                          )),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20),
                  child: (widget.club?.founding == null)
                      ? Text(
                          '',
                          style: Theme.of(context).textTheme.headline6,
                        )
                      : RichText(
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(children: [
                            const TextSpan(
                                text: 'Ngày thành lập: ',
                                style: TextStyle(
                                    fontSize: 15.0, color: Colors.black)),
                            TextSpan(
                                text: widget.club!.founding
                                    .toString()
                                    .split(" ")[0],
                                style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                          ])),
                ),
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
              const Text(
                '',
                maxLines: 10,
              ),
            if (widget.club?.description != null)
              Text(
                widget.club!.description,
                maxLines: 10,
                style: const TextStyle(fontSize: 16),
              ),
          ]),
        ),
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
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
            vertical: 10,
          ),
          child: Column(children: [
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Thông tin cá nhân',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                ),
                Container(
                      margin: const EdgeInsets.all(10.0),
                      padding: const EdgeInsets.all(3.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.orangeAccent),
                          color: Colors.orangeAccent,
                          borderRadius: const BorderRadius.all(Radius.circular(10))),
                      child: Text(widget.member?.clubRoleName ?? 'Thành viên',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          )),
                    ),
              ],
            ),
            const SizedBox(height: 10),
            if (widget.member?.name != null)
              Container(
                margin: const EdgeInsets.only(left: 15.0), // 30.0
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(Icons.account_circle),
                    const SizedBox(width: 10),
                    Text(widget.member?.name ?? '',
                        style: const TextStyle(fontSize: 16)),                   
                  ],
                ),
              ),
            // SizedBox(height: 10),
            // if (widget.member?.phone != null)
            //   Padding(
            //     padding: const EdgeInsets.only(left: 30.0),
            //     child: Row(
            //       children: [
            //         Icon(Icons.phone),
            //         SizedBox(width: 10),
            //         Text(widget.member?.phone ?? '',
            //             style: TextStyle(fontSize: 16)),
            //       ],
            //     ),
            //   ),
            // // SizedBox(height: 10),
          ]),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
            vertical: 10,
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: const [
                Text(
                  'Xem danh sách thành viên của CLB',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              width: 220.0,
              height: 36,
              margin: const EdgeInsets.all(15),
              child: RaisedButton(
                  textColor: ArgonColors.primary,
                  color: ArgonColors.secondary,
                  onPressed: () {
                    Navigator.of(context).pushNamed(Routes.viewListMember);
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                  child: Padding(
                      padding: const EdgeInsets.only(
                          bottom: 10, top: 10, left: 8, right: 8),
                      child: Row(
                        // mainAxisAlignment:
                        // MainAxisAlignment
                        //     .spaceAround,
                        children: const [
                          Icon(Icons.description, size: 13),
                          SizedBox(
                            width: 5,
                          ),
                          Text("Danh sách thành viên",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16))
                        ],
                      ))),
            ),
          ]),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
            vertical: 10,
          ),
          child: Column(children: [
            Wrap(
              children: const [
                Text(
                  'Các cuộc thi và sự kiện câu lạc bộ hiện có',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              width: 305.0,
              height: 36,
              margin: const EdgeInsets.all(15),
              child: RaisedButton(
                  textColor: ArgonColors.primary,
                  color: ArgonColors.secondary,
                  onPressed: () {
                    Navigator.pushNamed(context, '/viewListCompetitionOfClub');
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                  child: Padding(
                      padding: const EdgeInsets.only(
                          bottom: 10, top: 10, left: 8, right: 8),
                      child: Row(
                        // mainAxisAlignment:
                        // MainAxisAlignment
                        //     .spaceAround,
                        children: const [
                          Icon(Icons.description, size: 13),
                          SizedBox(
                            width: 5,
                          ),
                          Text("Danh sách Cuộc Thi & Sự Kiện",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16))
                        ],
                      ))),
            ),
            const SizedBox(height: 10),
          ]),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
            // vertical: 10,
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            if (widget.club?.clubFanpage != null ||
                widget.club?.clubContact != null)
              Row(
                children: const [
                  Text(
                    'Thông tin liên hệ',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                ],
              ),
            const SizedBox(height: 10),
            if (widget.club?.clubFanpage != null)
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Wrap(
                  spacing: 10,
                  children: [
                    const Icon(Icons.web),
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
                padding: const EdgeInsets.only(left: 10),
                child: Wrap(
                  spacing: 10,
                  children: [
                    const Icon(Icons.phone),
                    Text(widget.club?.clubContact ?? '',
                        style: const TextStyle(fontSize: 16)),
                  ],
                ),
              )
          ]),
        ),
      ],
    );
  }
}
