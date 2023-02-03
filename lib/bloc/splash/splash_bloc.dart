import 'package:unicec_mobi/bloc/splash/splash_state.dart';

import '../../services/splash_svc/i_splash_service.dart';
import '../../utils/base_bloc.dart';
import 'splash_event.dart';

class SplashBloc extends BaseBloc<SplashEvent, SplashState> {
  final ISplashService service;

  SplashBloc({required this.service}) : super(SplashState(opacity: 0)) {
    on((event, emit) async {
      if (event is SplashEvent) {
        emit(state.copyWith(opacity: 1));
      }
    });
  }
}
