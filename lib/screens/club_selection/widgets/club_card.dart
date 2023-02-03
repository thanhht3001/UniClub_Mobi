import 'package:get_it/get_it.dart';
import 'package:unicec_mobi/models/entities/member/member_detail_model.dart';
import '../../../bloc/club_selection/club_selection_bloc.dart';
import '../../../bloc/club_selection/club_selection_event.dart';
import '../../../bloc/club_selection/club_selection_state.dart';
import '../../../models/common/current_user.dart';
import '../../../models/entities/club/club_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/loading.dart';
import '../../../utils/router.dart';

class ClubCard extends StatefulWidget {
  const ClubCard(
      {Key? key,
      this.width = 250,
      this.aspectRetio = 1.02,
      required this.club,
      required this.member})
      : super(key: key);

  final double width, aspectRetio;
  final ClubModel club;
  final MemberDetailModel? member;

  @override
  State<ClubCard> createState() => _ClubCardState();
}

class _ClubCardState extends State<ClubCard> {
  ClubModel get _club => widget.club;

  @override
  Widget build(BuildContext context) {
    ClubSelectionBloc bloc = BlocProvider.of<ClubSelectionBloc>(context);
    Size size = MediaQuery.of(context).size;
    const defaultImage = 'https://picsum.photos/seed/513/600';

    return BlocBuilder<ClubSelectionBloc, ClubSelectionState>(
      bloc: bloc,
      builder: (context, state) {
        return (bloc.isLoading)
            ? Loading()
            : Padding(
                padding: const EdgeInsets.all(10),
                child: GestureDetector(
                  onTap: () async {
                    GetIt.I.get<CurrentUser>().clubIdSelected = widget.club.id;
                    Navigator.of(context).pushNamed(Routes.main);
                  },
                  child: Container(
                    height: size.height * 0.15,
                    width: size.width,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(255, 235, 237, 241)),
                      color: const Color.fromARGB(255, 235, 237, 241),
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      // borderRadius: BorderRadius.circular(10.0),
                      // color: Colors.white.withOpacity(0.5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                            margin:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            height: size.height * 0.1,
                            width: size.width * 0.2,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage((_club.image != '')
                                    ? '${_club.image}'
                                    : defaultImage),
                              ),
                            )),
                        // SizedBox(
                        //   width: 15.0,
                        // ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: [
                                    const Text(
                                      'CLB: ',
                                      style: TextStyle(fontSize: 15.0),
                                    ),
                                    Text(
                                      _club.name,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                RichText(
                                    overflow: TextOverflow.ellipsis,
                                    text: TextSpan(children: [
                                      const TextSpan(
                                          text: 'Số thành viên: ',
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.black)),
                                      TextSpan(
                                          text: "${_club.totalMember}",
                                          style: const TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black)),
                                    ])),
                                Row(children: [
                                  const Text(
                                    'Vai trò:',
                                    style: TextStyle(fontSize: 15.0),
                                  ),
                                  const SizedBox(width: 10.0),
                                  Container(
                                    padding: const EdgeInsets.all(3.0),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.lightGreen),
                                        color: Colors.lightGreen,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Text(
                                      widget.member?.clubRoleName ?? "",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                ]),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
        //   Container(
        //   margin: EdgeInsets.all(Dimens.size5),
        //   padding: EdgeInsets.all(Dimens.size10),
        //   decoration: BoxDecoration(
        //     color: Colors.white.withOpacity(Dimens.size0p8),
        //     borderRadius: BorderRadius.circular(18),
        //   ),
        //   child: InkWell(
        //     onTap: () {
        //       bloc.add(
        //           ChooseClubSelectionEvent(clubIdSelected: widget.club.id));
        //     },
        //     child: Container(
        //         decoration: BoxDecoration(
        //           borderRadius: BorderRadius.all(Radius.circular(3)),
        //           color: Colors.orange[600],
        //         ),
        //         margin: EdgeInsets.symmetric(
        //             horizontal: 50.0, vertical: Dimens.size30),
        //         child: Padding(
        //           padding: const EdgeInsets.all(15.0),
        //           child: Row(
        //             mainAxisAlignment: MainAxisAlignment.center,
        //             children: [
        //               SizedBox(width: 5),
        //               Text(
        //                 widget.club.name,
        //                 style: TextStyle(color: Colors.white, fontSize: 20),
        //               )
        //             ],
        //           ),
        //         )),
        //   ),
        //   // child: SizedBox(
        //   //     width: widget.width,
        //   //     child: GestureDetector(
        //   //       onTap: () {
        //   //         bloc.add(ChooseClubSelectionEvent(
        //   //             clubIdSelected: widget.club.id));
        //   //       },
        //   //       child: Column(
        //   //         children: [
        //   //           Text(
        //   //             widget.club.name,
        //   //             style: TextStyle(
        //   //                 fontSize: Dimens.size22,
        //   //                 fontWeight: FontWeight.bold),
        //   //           ),
        //   //           SizedBox(height: Dimens.size5),
        //   //         ],
        //   //       ),
        //   //     )
        //   //     )
        //   //
        // );
      },
    );
  }
}
