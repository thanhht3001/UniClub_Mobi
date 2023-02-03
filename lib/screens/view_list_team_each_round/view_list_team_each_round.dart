import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicec_mobi/models/enums/team_status.dart';
import '../../bloc/view_list_team_in_round/view_list_team_in_round_bloc.dart';
import '../../bloc/view_list_team_in_round/view_list_team_in_round_event.dart';
import '../../bloc/view_list_team_in_round/view_list_team_in_round_state.dart';
import '../../models/entities/team/sending_data_model.dart';
import '../../utils/app_color.dart';
import '../../utils/router.dart';
import 'component/list_team_menu_each_round.dart';

class ViewListTeamEachRoundPage extends StatefulWidget {
  final ViewListTeamInRoundBloc bloc;
  ViewListTeamEachRoundPage({required this.bloc});
  @override
  State<StatefulWidget> createState() => _ViewListTeamEachRoundPageState();
}

class _ViewListTeamEachRoundPageState extends State<ViewListTeamEachRoundPage>
    with AutomaticKeepAliveClientMixin {
  //bloc
  ViewListTeamInRoundBloc get bloc => widget.bloc;
  //
  //final _formKeyTeamName = GlobalKey<FormState>();
  //final _formKeyTeamDescription = GlobalKey<FormState>();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    //mặc định competition id 2
    //bloc.add(ReceiveDataEvent(competitionId: 2));
    //
    bloc.listenerStream.listen((event) {
      if (event is NavigateToTeamDetailEvent) {
        SendingDataModel data = SendingDataModel(
            competitionId: event.competitionId,
            teamId: event.teamId,
            status: TeamStatus.IsLocked,
            teamDescription: "",
            teamName: "",
            max: 0,
            min: 0);

        Navigator.of(context)
            .pushNamed(Routes.viewDetailTeamParticipant, arguments: data);
      }
    });
  }

  //nhận competition Id
  void didChangeDependencies() {
    RouteSettings settings = ModalRoute.of(context)!.settings;
    if (settings.arguments != null) {
      int roundId = settings.arguments as int;
      if (roundId != 0) {
        bloc.add(ReceiveDataEvent(roundId: roundId));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
        value: bloc,
        child: BlocBuilder<ViewListTeamInRoundBloc, ViewListTeamInRoundState>(
            bloc: bloc,
            builder: (context, state) {
              return Scaffold(
                appBar: AppBar(
                  leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                  ),
                  title: const Text(
                    "Danh sách đội thi", //Danh sách các đội thi trong vòng đấu
                    style: TextStyle(color: Colors.white),
                  ),
                  automaticallyImplyLeading: false,
                  centerTitle: true,
                  backgroundColor: AppColors.mainColor,
                ),
                body: ViewListTeamEachRoundMenu(),
                //floatingActionButton: AddTeamButtonWithoutLogin(),
              );
            }));
  }
}
