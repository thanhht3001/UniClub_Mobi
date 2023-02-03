import 'package:equatable/equatable.dart';

class AddTeamDialogState extends Equatable {
  String valueTeamName;
  String valueTeamDescription;

  AddTeamDialogState({
    required this.valueTeamName,
    required this.valueTeamDescription,
  });

  AddTeamDialogState copyWith({
    required String valueTeamName,
    required String valueTeamDescription,
  }) {
    return AddTeamDialogState(
      valueTeamName: valueTeamName,
      valueTeamDescription: valueTeamDescription,
    );
  }

  @override
  List<Object?> get props => [
        valueTeamName,
        valueTeamDescription,
      ];
}
