import 'package:equatable/equatable.dart';
import 'package:unicec_mobi/models/entities/seedswallet/seeds_wallet_model.dart';
import 'package:unicec_mobi/models/entities/user/user_model.dart';

class MyAccountState extends Equatable{
  UserModel user;
  SeedsWalletModel? seedsWallet;

  MyAccountState({required this.user, this.seedsWallet});

  MyAccountState copyWith(UserModel user, SeedsWalletModel? seedsWallet){
    return MyAccountState(user: user, seedsWallet: seedsWallet);
  }
  
  @override
  // TODO: implement props
  List<Object?> get props => [user, seedsWallet];
}