import 'package:flutter/material.dart';

import '../../models/entities/notification/notification_model.dart';
import '../../utils/app_color.dart';
import '../../utils/dimens.dart';
import '../../utils/utils.dart';

class NotiDetailPage extends StatelessWidget {
  final NotificationModel notification;
  const NotiDetailPage(this.notification);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, true);
          },
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        title: const Text("Chi tiết thông báo",
            style: TextStyle(color: Colors.white, fontSize: 23)),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: AppColors.mainColor,
      ),
      body: Card(
        margin: EdgeInsets.all(Dimens.size10),
        elevation: Dimens.size4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimens.size15),
        ),
        child: Container(
          padding: EdgeInsets.all(Dimens.size10),
          margin: EdgeInsets.all(Dimens.size10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                notification.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: Dimens.size20,
                ),
              ),
              SizedBox(
                height: Dimens.size15,
              ),
              Text(
                Utils.convertDateTime(notification.createTime),
                // "${notification.createTime}",
                style: TextStyle(
                  color: Colors.black26,
                  fontSize: Dimens.size15,
                ),
              ),
              SizedBox(
                height: Dimens.size15,
              ),
              const Divider(
                color: Colors.black26,
              ),
              SizedBox(
                height: Dimens.size15,
              ),
              Text(
                notification.body,
                style: TextStyle(
                  fontSize: Dimens.size16,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
