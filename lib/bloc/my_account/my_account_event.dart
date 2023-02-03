class MyAccountEvent {}

class LoadInfoAccountEvent extends MyAccountEvent {}

class ReceiveDataEvent extends MyAccountEvent {
  final int userId;
  ReceiveDataEvent({required this.userId});
}
