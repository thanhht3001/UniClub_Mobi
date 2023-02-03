import '../../models/entities/user/user_model.dart';

abstract class ISplashService {
  Future<UserModel> getStudent(int userId);
}
