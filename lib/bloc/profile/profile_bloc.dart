import 'package:get_it/get_it.dart';
import 'package:unicec_mobi/bloc/profile/profile_event.dart';
import 'package:unicec_mobi/bloc/profile/profile_state.dart';
import 'package:unicec_mobi/models/entities/seedswallet/seeds_wallet_model.dart';
import 'package:unicec_mobi/models/entities/user/user_model.dart';
import 'package:unicec_mobi/models/enums/user_status.dart';
import 'package:unicec_mobi/services/user_svc/i_user_service.dart';
import 'package:unicec_mobi/utils/base_bloc.dart';
import 'package:unicec_mobi/utils/firebase.dart';

import '../../models/common/current_user.dart';
import '../../utils/log.dart';

class ProfileBloc extends BaseBloc<ProfileEvent, ProfileState> { // this function is no use anymore now
  final IUserService service;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool isLoading){
    _isLoading = isLoading;
  }

  ProfileBloc({required this.service})
      : super(ProfileState(
            user: UserModel(
                id: 0,
                roleId: 0,
                fullname: '',
                email: '',
                avatar: '',
                gender: '',
                studentCode: '',
                phoneNumber: '',
                status: UserStatus.InActive,
                dob: '',
                description: '',
                isOnline: false))) {
    on((event, emit) async {
      // if (event is LoadProfileEvent) {
      //   print('LoadProfileEvent is running ...');
      //   CurrentUser currentUser = GetIt.I.get<CurrentUser>().currentUser;
      //   UserModel? user = await service.getById(currentUser.id);
      //   if(user != null){
      //     emit(state.copyWith(user));
      //   }else{
      //     Log.error('ProfileBloc: user null');
      //   }
      // }

      if(event is LoadSeedsWalletEvent){
        _isLoading = true;
        int userId = GetIt.I.get<CurrentUser>().id;
        SeedsWalletModel? seedsWallet = await service.getSeedsWalletByUser(userId);
        // print('profileBloc - seedswallet: $seedsWallet');     
        if(seedsWallet != null){
          emit(state.copyWith(seedsWallet: seedsWallet));
        }else{
          Log.error('ProfileBloc: seedsWallet null');
        }
        _isLoading = false;
        // print('loading seedswallet: $_isLoading');      
      }

      if(event is LogoutEvent){
        await FirebaseUtils.logout();
      }
    });
  }
}
