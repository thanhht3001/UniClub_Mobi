import 'package:unicec_mobi/models/entities/user/user_model.dart';
import '../../utils/adapter.dart';
import 'i_splash_service.dart';

class SplashService implements ISplashService {
  Adapter adapter = Adapter();
  @override
  Future<UserModel> getStudent(int userId) {
    // TODO: implement getStudent
    throw UnimplementedError();
  }
}
