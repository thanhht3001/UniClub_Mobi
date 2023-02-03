import 'package:unicec_mobi/models/common/paging_request.dart';
import 'package:unicec_mobi/models/common/paging_result.dart';
import 'package:unicec_mobi/models/entities/notification/notification_model.dart';

abstract class INotificationService{
  Future<PagingResult<NotificationModel>?> GetAllNotisByUser(int userId, PagingRequest? request);
  Future<NotificationModel?> GetDetailNoti(int id); 
}