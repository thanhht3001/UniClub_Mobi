import 'package:equatable/equatable.dart';
import 'package:unicec_mobi/models/entities/seedswallet/seeds_wallet_model.dart';

class SeedsWalletState extends Equatable{
  final SeedsWalletModel seedsWallet;

  SeedsWalletState({required this.seedsWallet});
  
  @override
  // TODO: implement props
  List<Object?> get props => [seedsWallet];


}