import 'package:unicec_mobi/bloc/add_team_dialog/add_team_dialog_event.dart';
import 'package:unicec_mobi/bloc/add_team_dialog/add_team_dialog_state.dart';
import 'package:unicec_mobi/utils/base_bloc.dart';

class AddTeamDialogBloc
    extends BaseBloc<AddTeamDialogEvent, AddTeamDialogState> {
  AddTeamDialogBloc()
      : super(AddTeamDialogState(valueTeamDescription: '', valueTeamName: '')) {
    on(((event, emit) async {
      //get Description
      if (event is ChangeTeamDescriptionValueEvent) {
        emit(state.copyWith(
          valueTeamDescription: event.newDescriptionValue, // change
          valueTeamName: state.valueTeamName,
        ));
      }
      //get Name
      if (event is ChangeTeamNameValueEvent) {
        emit(state.copyWith(
          valueTeamDescription: state.valueTeamDescription,
          valueTeamName: event.newNameValue, // change
        ));
      }
      //
      if (event is ClickButtonCreate) {
        listener.add(SendingDataEvent(
            teamName: state.valueTeamName,
            teamDescription: state.valueTeamDescription));
      }
    }));
  }
}
