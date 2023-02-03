import 'package:equatable/equatable.dart';

import '../../models/common/current_user.dart';

class HomeState extends Equatable {// change data in state if you need
  CurrentUser user;

  HomeState({required this.user});

  HomeState copyWith({required CurrentUser user}){
    return HomeState(user: user);
  }

  @override
  List<Object?> get props => [user];
}
