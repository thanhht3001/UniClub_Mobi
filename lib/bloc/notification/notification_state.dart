import 'package:equatable/equatable.dart';
import 'package:unicec_mobi/models/common/paging_result.dart';
import 'package:unicec_mobi/models/entities/notification/notification_model.dart';

class NotificationState extends Equatable {
  // final List<NotificationModel>? notifications;
  // final List<NotificationModel>? currentNotifications;
  // final int currentPage;
  // final int pageSize;
  // final bool? hasNext;
  final PagingResult<NotificationModel>? notifications;

  NotificationState({this.notifications});

  NotificationState copyWith(
      {PagingResult<NotificationModel>? notifications}) {
    return NotificationState(notifications: notifications);
  }

  @override
  List<Object?> get props => [notifications];
}
