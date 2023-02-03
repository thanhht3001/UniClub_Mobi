import 'package:unicec_mobi/bloc/seeds_wallet/seeds_wallet_event.dart';
import 'package:unicec_mobi/bloc/seeds_wallet/seeds_wallet_state.dart';
import 'package:unicec_mobi/models/entities/seedswallet/seeds_wallet_model.dart';
import 'package:unicec_mobi/services/seeds_wallet_svc/seeds_wallet_service.dart';
import 'package:unicec_mobi/utils/base_bloc.dart';

class SeedsWalletBloc extends BaseBloc<SeedsWalletEvent, SeedsWalletState> {
  final SeedsWalletService service;
  
  SeedsWalletBloc({required this.service})
      : super(SeedsWalletState(
            seedsWallet: SeedsWalletModel(
                id: 0, studentId: 0, amount: 0, status: true))){

                }
}
