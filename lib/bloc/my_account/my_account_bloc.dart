import 'package:unicec_mobi/bloc/my_account/my_account_event.dart';
import 'package:unicec_mobi/bloc/my_account/my_account_state.dart';
import 'package:unicec_mobi/models/entities/seedswallet/seeds_wallet_model.dart';
import 'package:unicec_mobi/models/enums/user_status.dart';
import 'package:unicec_mobi/services/i_services.dart';
import 'package:unicec_mobi/utils/base_bloc.dart';
import '../../models/entities/user/user_model.dart';
import '../../utils/log.dart';

class MyAccountBloc extends BaseBloc<MyAccountEvent, MyAccountState> {
  final IUserService service;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool isLoading){
    _isLoading = isLoading;
  }

  MyAccountBloc({required this.service})
      : super(MyAccountState(
            user: UserModel(
                id: 0,
                avatar: '',
                description: '',
                dob: '',
                email: '',
                fullname: '',
                gender: '',
                isOnline: false,
                phoneNumber: '',
                roleId: 3,
                status: UserStatus.InActive,
                studentCode: '',
                departmentId: 0,
                universityId: 0),
            seedsWallet: SeedsWalletModel(
                id: 0, amount: 0, status: false, studentId: 0))) {
    on((event, emit) async {
      // if (event is LoadInfoAccountEvent) {
      //   print('LoadProfileEvent is running ...');
      //   CurrentUser currentUser = GetIt.I.get<CurrentUser>().currentUser;
      //   UserModel? user = await service.getById(currentUser.id);
      //   SeedsWalletModel? seedsWallet =
      //       await service.getSeedsWalletByUser(currentUser.id);
      //   if (user != null && seedsWallet != null) {
      //     emit(state.copyWith(user, seedsWallet));
      //   } else {
      //     Log.error('ProfileBloc: user and seedsWallet null');
      //   }
      // }
      if (event is ReceiveDataEvent) {
        print('LoadProfileEvent is running ...');
        _isLoading = true;
        //CurrentUser currentUser = GetIt.I.get<CurrentUser>().currentUser;
        UserModel? user = await service.getById(event.userId);
        SeedsWalletModel? seedsWallet =
            await service.getSeedsWalletByUser(event.userId);
        
        Log.info('my_account_bloc - user: $user');
        Log.info('my_account_bloc - seedsWallet: $seedsWallet');
        if (user != null) {
          emit(state.copyWith(user, seedsWallet));
        } else {
          Log.error('ProfileBloc: user and seedsWallet null');
        }
        _isLoading = false;
      }
    });
  }
}
