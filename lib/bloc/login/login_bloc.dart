import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:unicec_mobi/models/common/current_user.dart';
import 'package:unicec_mobi/models/entities/member/member_detail_model.dart';
import 'package:unicec_mobi/models/entities/seedswallet/seeds_wallet_model.dart';
import '../../models/entities/uni_selector/uni_selector_model.dart';
import '../../services/i_services.dart';
import '../../utils/base_bloc.dart';
import '../../utils/firebase.dart';
import '../../utils/utils.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends BaseBloc<LoginEvent, LoginState> {
  final ILoginService service;
  final IUserService userService;
  final IClubService clubService;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool isLoading){
    _isLoading = isLoading;
  }


  LoginBloc({required this.service, required this.userService, required this.clubService})
      : super(LoginState(loading: false)) {
    on((event, emit) async {
      if (event is SignInGoogleEvent) {
        _isLoading = true;
        UserCredential? credential = await FirebaseUtils.signInWithGoogle();
        if (credential != null) {
          //xử lý logic ở chỗ này
          //1.Nếu chưa đăng nhập thì sẽ trả ra model tạm gồm jwt và list
          //2.Nếu đăng nhập rồi thì trả ra String idToken thôi
          //3.Trường hợp lỗi

          UniSelectorModel? uniSelector = await saveUserData(credential.user);
          if (uniSelector != null) {
            if (uniSelector.listUniBelongToEmail.isEmpty) {
              emit(state.copyWith(loading: false));
              listener.add(NavigatorWelcomePageEvent());
            } else {
              emit(state.copyWith(loading: false));
              listener.add(NavigatorUniversitySelectionPageEvent(
                  listUniBelongToEmail: uniSelector.listUniBelongToEmail));
            }
          } //bắt trường hợp đăng nhập gmail kh phải của trường
          else {
            emit(state.copyWith(loading: false));
            listener
                .add(ShowingSnackBarEvent(message: "Tài khoản không hợp lệ"));
            await FirebaseUtils.logout();
          }
        }
      }
      if (event is LoadingEvent) {
        emit(state.copyWith(loading: true));
      }

      _isLoading = false;
    });
  }

  Future<UniSelectorModel?> saveUserData(User? credentialUser) async {
    String? idToken = await credentialUser?.getIdToken();
    String? imagePath = credentialUser?.photoURL;

    //chứa cả Token + List University
    UniSelectorModel? uniSelector = await service.getUniSelector(idToken);

    if (uniSelector != null) {
      //decode JWT
      Map<String, dynamic> userMap = Utils.fromJWT(uniSelector.token);
      CurrentUser user = GetIt.I.get<CurrentUser>();
      user.id = int.parse(userMap['Id']);
      user.idToken = (uniSelector.token);

      //role admin
      int roleId = int.parse(userMap['RoleId']);
      if (roleId == 1 || roleId == 4) {
        return null;
      }
      //if new student kh trả ra UniversityID -> sẽ được cập nhật bên trang UniSelection
      if (uniSelector.listUniBelongToEmail.isEmpty) {
        //
        user.universityId = int.parse(userMap['UniversityId']);
        //load list club belong to student
        user.clubsBelongToStudent = await clubService
            .getListClubsBelongToStudent(user.id); //-. lấy những member active
        //load list member belong to club -> active
        if (user.clubsBelongToStudent != null) {
          for (var club in user.clubsBelongToStudent) {
            MemberDetailModel? member =
                await service.getMemberBelongToClub(club.id);

            user.membersBelongToClubs.add(member);
          }
        }
      }
      user.email = (credentialUser?.email)!;
      user.fullname = userMap['Fullname'];
      user.avatar = imagePath!;
      user.seedsWallet = await userService.getSeedsWalletByUser(user.id) ??
          SeedsWalletModel(id: 0, studentId: 0, amount: 0, status: false);
    } else {
      return null;
    }
    return uniSelector;

    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // List<String> userInfo = [
    //   "${user.id}",
    //   idToken,
    //   user.email,
    //   user.fullname,
    //   user.phone,
    //   user.imagePath
    // ];
    // await preferences.setStringList("userInfo", userInfo);
    //await FirebaseUtils.saveUserImage(user.id, user.imagePath);
  }
}
