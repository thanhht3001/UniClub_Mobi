import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:loadmore/loadmore.dart';
import 'package:unicec_mobi/models/enums/member_status.dart';

import '../../../bloc/clubs_view/clubs_view_bloc.dart';
import '../../../bloc/clubs_view/clubs_view_event.dart';
import '../../../bloc/clubs_view/clubs_view_state.dart';
import '../../../models/common/current_user.dart';
import '../../../utils/dimens.dart';
import '../../../utils/loading.dart';
import '../../../utils/router.dart';

class ListViewClubs extends StatefulWidget {
  @override
  State<ListViewClubs> createState() => _ListViewClubsState();
}

class _ListViewClubsState extends State<ListViewClubs> {
  void load(BuildContext context) {
    BlocProvider.of<ClubsViewBloc>(context).add(LoadAddMoreEvent());
  }

  //refresh
  void refresh(BuildContext context) {
    BlocProvider.of<ClubsViewBloc>(context).add(ClubsViewInitEvent());
  }

  Future<bool> _loadMore(BuildContext context) async {
    print("onLoadMore");
    await Future.delayed(Duration(seconds: 0, milliseconds: 2000));
    BlocProvider.of<ClubsViewBloc>(context).add(IncrementalEvent());
    //lúc này stateModel cũng có r nhưng mà chưa có hàm render lại cái view
    //phải đưa cái hàm này vào trong để add event và có state
    load(context);
    return true;
  }

  Future<bool> _refresh(BuildContext context) async {
    print("onRefresh");
    BlocProvider.of<ClubsViewBloc>(context).isLoading = true;
    BlocProvider.of<ClubsViewBloc>(context).add(RefreshEvent());
    await Future.delayed(Duration(seconds: 0, milliseconds: 2000));
    refresh(context);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    ClubsViewBloc bloc = BlocProvider.of<ClubsViewBloc>(context);
    const defaultImage = 'https://picsum.photos/seed/513/600';

    return BlocBuilder<ClubsViewBloc, ClubsViewState>(
      bloc: bloc,
      builder: (context, state) {
        return (bloc.isLoading)
            ? Loading()
            : state.listClubsBelongToUniversity.isEmpty
                ? const Center(
                    child: Text('Không có dữ liệu danh sách các câu lạc bộ'),
                  )
                : RefreshIndicator(
                    onRefresh: () {
                      return _refresh(context);
                    },
                    child: LoadMore(
                      isFinish: state.hasNext == false,
                      onLoadMore: () {
                        return _loadMore(context);
                      },
                      whenEmptyLoad: false,
                      delegate: DefaultLoadMoreDelegate(),
                      textBuilder: DefaultLoadMoreTextBuilder.english,
                      child: ListView.builder(
                        //scrollDirection: Axis.vertical,
                        itemCount: state.listClubsBelongToUniversity.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              // bloc.add(ChooseClubEvent(
                              //     clubSelect: state
                              //         .listClubsBelongToUniversity[index]));

                              if (state.listClubsBelongToUniversity[index]
                                      .isMemberStatus ==
                                  MemberStatus.Active) {
                                GetIt.I.get<CurrentUser>().clubIdSelected =
                                    state.listClubsBelongToUniversity[index].id;
                                Navigator.of(context)
                                    .popAndPushNamed(Routes.main);
                              } else {
                                bloc.add(ChooseClubEvent(
                                    clubSelect: state
                                        .listClubsBelongToUniversity[index]));
                              }
                            },
                            child: Card(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 4, bottom: 8, top: 15),
                                    child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: Image(
                                          image: NetworkImage(state
                                                      .listClubsBelongToUniversity[
                                                          index]
                                                      .image !=
                                                  null
                                              ? "${state.listClubsBelongToUniversity[index].image}"
                                              : defaultImage),
                                          width: 120,
                                          height: 110,
                                          fit: BoxFit.cover,
                                        )),
                                  ),
                                  SizedBox(
                                    width: Dimens.size8,
                                  ),
                                  Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          state
                                              .listClubsBelongToUniversity[
                                                  index]
                                              .name,
                                          style: TextStyle(
                                              fontSize: Dimens.size20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        (state
                                                    .listClubsBelongToUniversity[
                                                        index]
                                                    .isMemberStatus ==
                                                MemberStatus.Active)
                                            ? Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: Dimens.size10),
                                                child: const Text(
                                                    'Đã là thành viên'),
                                              )
                                            : (state
                                                        .listClubsBelongToUniversity[
                                                            index]
                                                        .isMemberStatus ==
                                                    MemberStatus.Pending)
                                                ? Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical:
                                                                Dimens.size10),
                                                    child: const Text(
                                                        'Đang đợi xét duyệt'),
                                                  )
                                                : (state
                                                            .listClubsBelongToUniversity[
                                                                index]
                                                            .isMemberStatus ==
                                                        MemberStatus.Student)
                                                    ? Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: Dimens
                                                                    .size10),
                                                        child: const Text(
                                                            'Chưa là thành viên'),
                                                      )
                                                    : Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: Dimens
                                                                    .size10),
                                                        child:
                                                            const Text('lỗi'))
                                      ])
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
      },
    );
  }
}
