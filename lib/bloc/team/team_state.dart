import 'package:equatable/equatable.dart';
import 'package:unicec_mobi/models/entities/team/team_model.dart';

class TeamState extends Equatable {
  final TeamModel team;

  TeamState({required this.team});

  @override
  List<Object?> get props => [team];
}
