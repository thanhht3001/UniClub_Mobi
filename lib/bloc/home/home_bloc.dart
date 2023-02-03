import 'package:unicec_mobi/bloc/home/home_event.dart';
import 'package:unicec_mobi/models/common/current_user.dart';
import 'package:unicec_mobi/utils/base_bloc.dart';

import '../../models/entities/seedswallet/seeds_wallet_model.dart';
import '../../services/user_svc/i_user_service.dart';
import 'home_state.dart';

class HomeBloc extends BaseBloc<HomeEvent, HomeState> {
  IUserService service;

  HomeBloc({required this.service})
      : super(HomeState(
            user: CurrentUser(
                id: 0,
                email: '',
                fullname: '',
                idToken: '',
                avatar: '',
                clubIdSelected: 0,
                clubsBelongToStudent: [],
                membersBelongToClubs: [],
                universityId: 0,
                seedsWallet: SeedsWalletModel(id: 0, amount: 0, status: false, studentId: 0)))) {
    on(((event, emit) async {
      if (event is LoadDataEvent) {
        // implement later
      }
    }));
  }
}
