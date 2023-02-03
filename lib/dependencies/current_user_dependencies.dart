import 'package:get_it/get_it.dart';
import 'package:unicec_mobi/models/common/current_user.dart';
import 'package:unicec_mobi/models/entities/seedswallet/seeds_wallet_model.dart';

class CurrentUserDependencies {
  static Future setup(GetIt injector) async {
    injector.registerSingleton<CurrentUser>(CurrentUser(
        id: 0,
        email: '',
        fullname: '',
        avatar: '',
        idToken: '',
        clubIdSelected: 0,
        clubsBelongToStudent: [],
        membersBelongToClubs: [],
        seedsWallet: SeedsWalletModel(id: 0, amount: 0, status: false, studentId: 0)));
  }
}
