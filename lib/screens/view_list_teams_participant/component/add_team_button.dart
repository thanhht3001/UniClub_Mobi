import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:unicec_mobi/bloc/add_team_dialog/add_team_dialog_bloc.dart';
import 'package:unicec_mobi/bloc/view_list_team_participant/view_list_team_participant_bloc.dart';
import 'package:unicec_mobi/bloc/view_list_team_participant/view_list_team_participant_event.dart';
import 'package:unicec_mobi/screens/view_list_teams_participant/component/add_team_dialog.dart';
import '../../../bloc/add_team_dialog/add_team_dialog_event.dart';
import '../../../constants/Theme.dart';

class AddTeamButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 80.0),
      child: FloatingActionButton(
        heroTag: "Tạo đội thi",
        backgroundColor: ArgonColors.warning,
        onPressed: () async {
          SendingDataEvent? data = await showDialog(
              context: context,
              builder: (context) {
                return AddTeamDialog(bloc: GetIt.I.get<AddTeamDialogBloc>());
              });
          if (data != null) {
            BlocProvider.of<ViewListTeamParticipantBloc>(context).add(
                CreateTeamEvent(
                    teamName: data.teamName,
                    teamDescription: data.teamDescription));
          }
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
