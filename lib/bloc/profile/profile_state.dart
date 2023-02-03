import 'package:equatable/equatable.dart';
import 'package:unicec_mobi/models/entities/seedswallet/seeds_wallet_model.dart';

import '../../models/entities/user/user_model.dart';

class ProfileState extends Equatable{ // this function is no use anymore now
  UserModel? user;
  SeedsWalletModel? seedsWallet;

  ProfileState({this.user, this.seedsWallet});

  ProfileState copyWith({UserModel? user, SeedsWalletModel? seedsWallet}){
    return ProfileState(user: user, seedsWallet: seedsWallet);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [user, seedsWallet];

}