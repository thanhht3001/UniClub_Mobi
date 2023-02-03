class NotificationModel {
  int id;
  int userId;
  String title;
  String body;
  DateTime createTime;

  NotificationModel(
      {required this.id,
      required this.userId,
      required this.title,
      required this.body,
      required this.createTime});

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    int id = json['id'] ?? 0;
    int userId = json['user_id'] ?? 0;
    String title = json['title'] ?? '';
    String body = json['body'] ?? '';
    DateTime createTime = DateTime.parse(json['create_time']);

    return NotificationModel(
        id: id,
        userId: userId,
        title: title,
        body: body,
        createTime: createTime);
  }
}
