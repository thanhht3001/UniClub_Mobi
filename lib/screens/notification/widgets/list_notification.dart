import '../../../bloc/notification/notification_event.dart';
import 'package:loadmore/loadmore.dart';

import '../../../bloc/notification/notification_bloc.dart';
import '../../../bloc/notification/notification_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import '../../../models/entities/notification/notification_model.dart';
import '../../../utils/dimens.dart';
import '../../../utils/loading.dart';
import '../../../utils/utils.dart';
import '../noti_detail_page.dart';

class ListNotification extends StatefulWidget {
  const ListNotification({Key? key}) : super(key: key);

  _ListNotificationState createState() => _ListNotificationState();
}

class _ListNotificationState extends State<ListNotification> {
  Future _loadMore(BuildContext context) async {
    print('loadmore is running !!!!!!!!!');
    await Future.delayed(const Duration(seconds: 0, milliseconds: 2000));
    BlocProvider.of<NotificationBloc>(context).add(LoadMoreEvent());
  }

  Future _refresh(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 0, milliseconds: 2000));
    BlocProvider.of<NotificationBloc>(context).add(RefreshNotificationsEvent());
    BlocProvider.of<NotificationBloc>(context).add(LoadNotificationsEvent());
  }

  @override
  Widget build(BuildContext context) {
    NotificationBloc _bloc = BlocProvider.of<NotificationBloc>(context);
    
    return BlocBuilder<NotificationBloc, NotificationState>(
        bloc: _bloc,
        builder: (context, state) {
          List<NotificationModel>? notifications = state.notifications?.items;
          return (_bloc.isLoading)
              ? Loading()
              : (notifications != null)
                  ? RefreshIndicator(
                      onRefresh: () async {
                        var refresh = _refresh(context);
                        return refresh;
                      },
                      child: LoadMore(
                        isFinish: !(state.notifications?.hasNext ?? false),
                        onLoadMore: () async {
                          await _loadMore(context);
                          return true;
                        },
                        whenEmptyLoad: true,
                        delegate: const DefaultLoadMoreDelegate(),
                        textBuilder: DefaultLoadMoreTextBuilder.english,
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: notifications.length,
                            itemBuilder: (context, index) {
                              return Card(
                                margin: EdgeInsets.all(Dimens.size10),
                                elevation: 4.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(Dimens.size15),
                                ),
                                child: Container(
                                  padding: EdgeInsets.all(Dimens.size10),
                                  margin: EdgeInsets.all(Dimens.size10),
                                  child: GestureDetector(
                                    onTap: () async {
                                      bool returnData = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                NotiDetailPage(
                                                    notifications[index])),
                                      ) as bool;
                                      if (returnData) {
                                        _bloc.add(LoadingEvent());
                                        BlocProvider.of<NotificationBloc>(
                                                context)
                                            .add(RefreshNotificationsEvent());
                                        BlocProvider.of<NotificationBloc>(
                                                context)
                                            .add(LoadNotificationsEvent());
                                      }
                                    },
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          notifications[index].title,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                          maxLines: 2,
                                        ),
                                        SizedBox(height: 10,),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                Utils.convertDateTime(
                                                    notifications[index]
                                                        .createTime),
                                                style: TextStyle(
                                                  color: Colors.black26,
                                                  fontSize: 15,
                                                ),
                                                maxLines: 1,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: Dimens.size15,
                                        ),
                                        Text(
                                          notifications[index].body,
                                          style: TextStyle(
                                              fontSize: 16),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    )
                  : Padding(
                  padding: const EdgeInsets.only(top: 180.0),
                  child: Column(
                    children: [
                      Container(
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  alignment: Alignment.topCenter,
                                  image: AssetImage(
                                      "assets/img/not-found-icon-24.jpg"),
                                  fit: BoxFit.fitWidth))),
                      Image.asset("assets/img/not-found-icon-24.jpg"),
                      const Padding(
                        padding: EdgeInsets.only(top: 25.0),
                        child: Text(
                          'Không có thông báo nào',
                          style: TextStyle(fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                );
        });
  }
}
