import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicec_mobi/bloc/view_result_team/view_result_team_bloc.dart';
import 'package:unicec_mobi/models/entities/team/team_in_competition_request_model.dart';
import '../../bloc/view_result_team/view_result_team_event.dart';
import '../../utils/app_color.dart';
import '../../utils/router.dart';
import '../view_result_team/component/view_result_team_menu.dart';

class ViewResultTeamPage extends StatefulWidget {
  ViewResultTeamBloc bloc;

  ViewResultTeamPage({required this.bloc});

  @override
  State<StatefulWidget> createState() => _ViewResultTeamPageState();
}

class _ViewResultTeamPageState
    extends State<ViewResultTeamPage>
    with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  ViewResultTeamBloc get _bloc => widget.bloc;

  @override
  void initState() {
    super.initState();    

    _bloc.listenerStream.listen((event) {
      if (event is NavigateToMatchDetailEvent) {
        Navigator.of(context)
            .pushNamed(Routes.viewDetailMatch, arguments: _bloc.state.match);
      }
    });
  }

  void didChangeDependencies(){
    RouteSettings? settings = ModalRoute.of(context)?.settings;
    if(settings != null){
      TeamInCompetitionRequestModel request = settings.arguments as TeamInCompetitionRequestModel;
      _bloc.IsLoading = true;
      _bloc.add(LoadData(competitionId: request.competitionId, teamId: request.teamId));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          ),
          title: const Text(
            "Kết quả các vòng đấu",
            style: TextStyle(color: Colors.white),
          ),
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: AppColors.mainColor,
        ),
        body: ViewResultTeamMenu()
      ),
    );
  }
}
