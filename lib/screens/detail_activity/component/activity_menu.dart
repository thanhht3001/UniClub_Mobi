import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import '../../../bloc/view_detail_activity/view_detail_activity_bloc.dart';
import '../../../bloc/view_detail_activity/view_detail_activity_event.dart';
import '../../../bloc/view_detail_activity/view_detail_activity_state.dart';
import '../../../constants/Constants.dart';
import '../../../models/enums/competition_activity_status.dart';
import '../../../models/enums/priority_status.dart';
import '../../../utils/loading.dart';
import '../../../utils/log.dart';
import '../../../utils/utils.dart';
import '../../club/tab_club_info/default_button.dart';
import '../../club/tab_club_info/top_rounded_container.dart';
import '../../size_config.dart';

class ViewDetailActivityMenu extends StatefulWidget {
  const ViewDetailActivityMenu({
    Key? key,
  }) : super(key: key);

  @override
  State<ViewDetailActivityMenu> createState() => _ViewDetailActivityMenuState();
}

class _ViewDetailActivityMenuState extends State<ViewDetailActivityMenu> {
  //int selectedImage = 0;

  List<DropdownMenuItem<CompetitionActivityStatus>> get dropdownStatus {
    List<DropdownMenuItem<CompetitionActivityStatus>> menuItems = [
      DropdownMenuItem(
          child: Row(
            children: [
              Icon(
                Icons.star,
                color: Colors.deepPurple,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "Mở",
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          value: CompetitionActivityStatus.Open),
      DropdownMenuItem(
          child: Row(
            children: [
              Icon(
                Icons.star,
                color: Colors.orangeAccent,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "Đang làm",
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          value: CompetitionActivityStatus.OnGoing),
      DropdownMenuItem(
          child: Row(
            children: [
              Icon(
                Icons.star,
                color: Colors.deepOrange,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "Chờ",
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          value: CompetitionActivityStatus.Pending),
      DropdownMenuItem(
          child: Row(
            children: [
              Icon(
                Icons.star,
                color: Colors.lightGreen,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "Hoàn Thành",
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          value: CompetitionActivityStatus.Finished),
    ];
    return menuItems;
  }

  @override
  Widget build(BuildContext context) {
    //String selectedValueStatus = "Open";
    //String selectedValuePriority = "High";
    //bloc
    ViewDetailActivityBloc bloc =
        BlocProvider.of<ViewDetailActivityBloc>(context);

    return BlocBuilder<ViewDetailActivityBloc, ViewDetailActivityState>(
        bloc: bloc,
        builder: (context, state) {
          return (state.isLoading)
              ? Loading()
              : Stack(children: <Widget>[
                  SafeArea(
                    child: ListView(children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 0.0, right: 0.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Stack(children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.1),
                                      spreadRadius: 1,
                                      blurRadius: 7,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Card(
                                    semanticContainer: true,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    elevation: .0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5.0))),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 0.0, bottom: 20.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              children: [
                                                SizedBox(height: 10.0),
                                                Row(
                                                  children: [
                                                    //Mã Competition Activity
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.all(
                                                              15.0),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              3.0),
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color: Colors
                                                                  .lightGreen),
                                                          color:
                                                              Colors.lightGreen,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          10))),
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            Icons.today,
                                                            color: Colors.white,
                                                            size: 20,
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          // Icon(Icons
                                                          //     .business_center)
                                                          // Text(
                                                          //     "CA-${state.competitionActivityDetail?.id ?? ""}",
                                                          //     style: TextStyle(
                                                          //       color: Colors
                                                          //           .white,
                                                          //       fontSize: 20,
                                                          //     )),
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                        child: SizedBox(
                                                      width: 10,
                                                    )),

                                                    //Điểm Competition Activity
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.all(
                                                              15.0),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              3.0),
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color: Colors
                                                                  .redAccent),
                                                          color:
                                                              Colors.redAccent,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          10))),
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .control_point_sharp,
                                                            color: Colors.white,
                                                            size: 20,
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text(
                                                              "${state.competitionActivityDetail?.seedsPoint ?? ""} điểm",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 20,
                                                              )),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 10.0),

                                                // Name Competition Activity
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10, right: 10),
                                                  child: Align(
                                                    child: Text(
                                                        state.competitionActivityDetail
                                                                ?.name ??
                                                            "",
                                                        style: const TextStyle(
                                                            color:
                                                                Color.fromRGBO(
                                                                    50,
                                                                    50,
                                                                    93,
                                                                    1),
                                                            fontSize: 28.0)),
                                                  ),
                                                ),
                                                SizedBox(height: 5.0),

                                                // Người tạo
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 10,
                                                          left: 10,
                                                          top: 10),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                          "Bởi ${state.competitionActivityDetail?.creatorName ?? ""}",
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize:
                                                                      18)),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 10.0),
                                                        child: Text(
                                                            (state.competitionActivityDetail
                                                                        ?.createTime !=
                                                                    null)
                                                                ? Utils.convertDateTime(state
                                                                    .competitionActivityDetail!
                                                                    .createTime)
                                                                : "",
                                                            style:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .grey,
                                                                    fontSize:
                                                                        18)),
                                                      ),
                                                    ],
                                                  ),
                                                ),

                                                //drop down menu
                                                (state.competitionActivityDetail!
                                                            .status ==
                                                        CompetitionActivityStatus
                                                            .Completed)
                                                    ? Row(
                                                        children: [
                                                          Icon(
                                                            Icons.star,
                                                            color: Colors
                                                                .lightGreen,
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text(
                                                            "Kết thúc",
                                                            style: TextStyle(
                                                                fontSize: 18),
                                                          ),
                                                        ],
                                                      )
                                                    : (state.competitionActivityDetail!
                                                                .status ==
                                                            CompetitionActivityStatus
                                                                .Cancelling)
                                                        ? Row(
                                                            children: [
                                                              Icon(
                                                                Icons.star,
                                                                color: Colors
                                                                    .brown,
                                                              ),
                                                              SizedBox(
                                                                width: 10,
                                                              ),
                                                              Text(
                                                                "Hủy",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        18),
                                                              ),
                                                            ],
                                                          )
                                                        : Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right: 10,
                                                                    left: 10,
                                                                    top: 15),
                                                            child: Row(
                                                              children: [
                                                                DropdownButton(
                                                                  value: state
                                                                      .status,
                                                                  items:
                                                                      dropdownStatus,
                                                                  onChanged:
                                                                      (CompetitionActivityStatus?
                                                                          value) {
                                                                    bloc.add(ChangeStatusEvent(
                                                                        newStatus:
                                                                            value!));
                                                                  },
                                                                ),
                                                              ],
                                                            )),

                                                SizedBox(height: 10.0),

                                                //image
                                                if (state
                                                    .competitionActivityDetail!
                                                    .activitiesEntities
                                                    .isNotEmpty)
                                                  SizedBox(
                                                    width:
                                                        getProportionateScreenWidth(
                                                            238), //238
                                                    child: AspectRatio(
                                                      aspectRatio: 1,
                                                      child: Hero(
                                                          tag: 1,
                                                          child: Image.network(state
                                                                  .competitionActivityDetail!
                                                                  .activitiesEntities[
                                                                      state
                                                                          .selectedImageIndex]
                                                                  .imageUrl
                                                                  .contains(
                                                                      'http')
                                                              ? state
                                                                  .competitionActivityDetail!
                                                                  .activitiesEntities[
                                                                      state
                                                                          .selectedImageIndex]
                                                                  .imageUrl
                                                              : "https://picsum.photos/seed/513/600")
                                                          //Image.network(
                                                          //     "https://img.freepik.com/premium-photo/astronaut-outer-open-space-planet-earth-stars-provide-background-erforming-space-planet-earth-sunrise-sunset-our-home-iss-elements-this-image-furnished-by-nasa_150455-16829.jpg?w=2000"),
                                                          ),
                                                    ),
                                                  ),
                                                if (state
                                                    .competitionActivityDetail!
                                                    .activitiesEntities
                                                    .isNotEmpty)
                                                  SizedBox(
                                                      height:
                                                          getProportionateScreenWidth(
                                                              20)),
                                                if (state
                                                    .competitionActivityDetail!
                                                    .activitiesEntities
                                                    .isNotEmpty)
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      ...List.generate(
                                                          state
                                                                  .competitionActivityDetail
                                                                  ?.activitiesEntities
                                                                  .length ??
                                                              1,
                                                          (index) =>
                                                              buildSmallImagePreview(
                                                                  index)),
                                                    ],
                                                  ),

                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10,
                                                          right: 20,
                                                          top: 10),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          "Nội dung",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 18),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),

                                                //Description
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10,
                                                          right: 20,
                                                          top: 10),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.description,
                                                        size: 23,
                                                        color: Colors.orange,
                                                      ),
                                                      SizedBox(width: 10.0),
                                                      Expanded(
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                                child: Html(
                                                              data: state
                                                                  .competitionActivityDetail
                                                                  ?.description,
                                                              tagsList:
                                                                  Html.tags,
                                                              style: {
                                                                "p": Style(
                                                                    fontSize:
                                                                        const FontSize(
                                                                            18.0)),
                                                                "em": Style(
                                                                    fontStyle:
                                                                        FontStyle
                                                                            .italic),
                                                                "strong": Style(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                                "a": Style(
                                                                    textDecoration:
                                                                        TextDecoration
                                                                            .underline,
                                                                    color: Colors
                                                                        .blueAccent),
                                                                // "ul": Wrap()
                                                                "li": Style(
                                                                    fontSize:
                                                                        const FontSize(
                                                                            15.0))
                                                              },
                                                              // onLinkTap: (url, _, _){
                                                              //   print('Open with url: $url ...');
                                                              // },
                                                              onCssParseError:
                                                                  (css,
                                                                      messages) {
                                                                Log.error(
                                                                    'css that errored: $css');
                                                                Log.error(
                                                                    'error messages: ');
                                                                messages.forEach(
                                                                    (element) {
                                                                  Log.error(
                                                                      '$element');
                                                                });
                                                              },
                                                            )),
                                                          ],
                                                        ),

                                                        //     Text(
                                                        //   state.competitionActivityDetail
                                                        //           ?.description ??
                                                        //       "",
                                                        //   style: TextStyle(
                                                        //       fontSize: 18),
                                                        // )
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Divider(
                                                  height: 30.0,
                                                  thickness: 1.5,
                                                  indent: 32.0,
                                                  endIndent: 32.0,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10, right: 20),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          "Thông tin chi tiết",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 18),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20.0,
                                                          right: 20),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          "Người thực hiện",
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),

                                                //người được assign
                                                ListView.builder(
                                                    physics:
                                                        NeverScrollableScrollPhysics(),
                                                    shrinkWrap: true,
                                                    itemCount: state
                                                        .competitionActivityDetail!
                                                        .memberTakesActivities
                                                        .length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Row(
                                                        children: [
                                                          GestureDetector(
                                                            child: Container(
                                                              margin:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 15.0,
                                                                      bottom:
                                                                          15,
                                                                      right: 15,
                                                                      left: 25),
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(5.0),
                                                              decoration: BoxDecoration(
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .black12),
                                                                  color: Colors
                                                                      .black12,
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              10))),
                                                              child: Row(
                                                                children: [
                                                                  CircleAvatar(
                                                                    radius:
                                                                        30.0,
                                                                    backgroundImage: NetworkImage(state
                                                                            .competitionActivityDetail!
                                                                            .memberTakesActivities[
                                                                                index]
                                                                            .memberImg
                                                                            .contains(
                                                                                'http')
                                                                        ? state
                                                                            .competitionActivityDetail!
                                                                            .memberTakesActivities[index]
                                                                            .memberImg
                                                                        : "https://picsum.photos/seed/513/600"),
                                                                    backgroundColor:
                                                                        Colors
                                                                            .transparent,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Text(
                                                                      state.competitionActivityDetail?.memberTakesActivities[index].memberName ??
                                                                          "",
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            18,
                                                                      )),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                                    }),

                                                // Divider(
                                                //   height: 30.0,
                                                //   thickness: 1.5,
                                                //   indent: 32.0,
                                                //   endIndent: 32.0,
                                                // ),
                                                // Padding(
                                                //   padding:
                                                //       const EdgeInsets.only(
                                                //           left: 20.0,
                                                //           right: 20),
                                                //   child: Row(
                                                //     children: [
                                                //       Expanded(
                                                //         child: Text(
                                                //           "Ngày bắt đầu",
                                                //           style: TextStyle(
                                                //               fontSize: 18,
                                                //               color:
                                                //                   Colors.grey),
                                                //         ),
                                                //       ),
                                                //     ],
                                                //   ),
                                                // ),
                                                // Padding(
                                                //   padding:
                                                //       const EdgeInsets.only(
                                                //           left: 20,
                                                //           right: 20,
                                                //           top: 10),
                                                //   child: Row(
                                                //     children: [
                                                //       Icon(
                                                //         Icons.calendar_today,
                                                //         size: 23,
                                                //         color: Colors.orange,
                                                //       ),
                                                //       SizedBox(width: 10.0),
                                                //       Expanded(
                                                //           child: Text(
                                                //         Utils.convertDateTime(state
                                                //             .competitionActivityDetail!
                                                //             .createTime),
                                                //         style: TextStyle(
                                                //             fontSize: 18),
                                                //       )),
                                                //     ],
                                                //   ),
                                                // ),
                                                Divider(
                                                  height: 30.0,
                                                  thickness: 1.5,
                                                  indent: 32.0,
                                                  endIndent: 32.0,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20.0,
                                                          right: 20),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          "Độ ưu tiên",
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                //Priority
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20,
                                                          right: 20,
                                                          top: 10),
                                                  child: Row(
                                                    children: [
                                                      if (state
                                                              .competitionActivityDetail
                                                              ?.priority ==
                                                          PriorityStatus.High)
                                                        Row(
                                                          children: [
                                                            Icon(
                                                              Icons.warning,
                                                              color: Colors.red,
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Text(
                                                              "Cao",
                                                              style: TextStyle(
                                                                  fontSize: 18),
                                                            ),
                                                          ],
                                                        ),
                                                      if (state
                                                              .competitionActivityDetail
                                                              ?.priority ==
                                                          PriorityStatus.Medium)
                                                        Row(
                                                          children: [
                                                            Icon(
                                                              Icons.warning,
                                                              color: Colors
                                                                  .orangeAccent,
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Text(
                                                              "Trung bình",
                                                              style: TextStyle(
                                                                  fontSize: 18),
                                                            ),
                                                          ],
                                                        ),
                                                      if (state
                                                              .competitionActivityDetail
                                                              ?.priority ==
                                                          PriorityStatus.Low)
                                                        Row(
                                                          children: [
                                                            Icon(
                                                              Icons.warning,
                                                              color:
                                                                  Colors.green,
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Text(
                                                              "Thấp",
                                                              style: TextStyle(
                                                                  fontSize: 18),
                                                            ),
                                                          ],
                                                        ),
                                                    ],
                                                  ),
                                                ),
                                                Divider(
                                                  height: 30.0,
                                                  thickness: 1.5,
                                                  indent: 32.0,
                                                  endIndent: 32.0,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20.0,
                                                          right: 20),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          "Ngày Hạn Chót",
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20,
                                                          right: 20,
                                                          top: 10),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.calendar_today,
                                                        size: 23,
                                                        color: Colors.orange,
                                                      ),
                                                      SizedBox(width: 10.0),
                                                      Expanded(
                                                          child: Text(
                                                        Utils.convertDateTime(state
                                                            .competitionActivityDetail!
                                                            .ending),
                                                        style: TextStyle(
                                                            fontSize: 18),
                                                      )),
                                                    ],
                                                  ),
                                                ),
                                                Divider(
                                                  height: 30.0,
                                                  thickness: 1.5,
                                                  indent: 32.0,
                                                  endIndent: 32.0,
                                                ),
                                                // Padding(
                                                //   padding:
                                                //       const EdgeInsets.only(
                                                //           left: 20.0,
                                                //           right: 20),
                                                //   child: Row(
                                                //     children: [
                                                //       Expanded(
                                                //         child: Text(
                                                //           "Tổng thời gian",
                                                //           style: TextStyle(
                                                //               fontSize: 18,
                                                //               color:
                                                //                   Colors.grey),
                                                //         ),
                                                //       ),
                                                //     ],
                                                //   ),
                                                // ),
                                                // Padding(
                                                //   padding:
                                                //       const EdgeInsets.only(
                                                //           left: 20,
                                                //           right: 20,
                                                //           top: 10),
                                                //   child: Row(
                                                //     children: [
                                                //       Icon(
                                                //         Icons.access_time,
                                                //         size: 23,
                                                //         color: Colors.orange,
                                                //       ),
                                                //       SizedBox(width: 10.0),
                                                //       Expanded(
                                                //           child: Text(
                                                //         "5" + " giờ",
                                                //         style: TextStyle(
                                                //             fontSize: 18),
                                                //       )),
                                                //     ],
                                                //   ),
                                                // ),
                                                (state.competitionActivityDetail
                                                                ?.status ==
                                                            CompetitionActivityStatus
                                                                .Cancelling ||
                                                        state.competitionActivityDetail
                                                                ?.status ==
                                                            CompetitionActivityStatus
                                                                .Completed)
                                                    ? SizedBox(height: 10)
                                                    : TopRoundedContainer(
                                                        color: Colors.white,
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                            left: SizeConfig
                                                                    .screenWidth *
                                                                0.25,
                                                            right: SizeConfig
                                                                    .screenWidth *
                                                                0.25,
                                                            bottom:
                                                                getProportionateScreenWidth(
                                                                    40),
                                                            top:
                                                                getProportionateScreenWidth(
                                                                    20),
                                                          ),
                                                          child: DefaultButton(
                                                            text:
                                                                "Cập nhật hoạt động",
                                                            press: () {
                                                              bloc.add(
                                                                  UpdateStatusEvent());
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                              ),
                            ]),
                          ],
                        ),
                      ),
                    ]),
                  )
                ]);
        });
  }

  //chọn ảnh
  GestureDetector buildSmallImagePreview(int index) {
    ViewDetailActivityBloc bloc =
        BlocProvider.of<ViewDetailActivityBloc>(context);
    return GestureDetector(
      onTap: () {
        // setState(() {
        //   selectedImage = index;
        // });
        //chuyển ảnh
        bloc.add(ChangeImageIndex(imageIndex: index));
      },
      child: BlocBuilder<ViewDetailActivityBloc, ViewDetailActivityState>(
          bloc: bloc,
          builder: (context, state) {
            return AnimatedContainer(
                duration: defaultDuration,
                margin: EdgeInsets.only(right: 15),
                padding: EdgeInsets.all(8),
                height: getProportionateScreenWidth(48),
                width: getProportionateScreenWidth(48),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: kPrimaryColor.withOpacity(
                          state.selectedImageIndex == index ? 1 : 0)),
                ),
                child: Image.network(state.competitionActivityDetail!
                        .activitiesEntities[index].imageUrl
                        .contains('http')
                    ? state.competitionActivityDetail!.activitiesEntities[index]
                        .imageUrl
                    : "https://picsum.photos/seed/513/600"));
          }),
    );
  }
}
