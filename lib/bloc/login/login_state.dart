import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  bool loading;

  LoginState({required this.loading});

  LoginState copyWith({required bool loading}) {
    return LoginState(loading: loading);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [loading];
}
