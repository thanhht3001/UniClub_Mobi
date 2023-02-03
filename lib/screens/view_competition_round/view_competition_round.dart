import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicec_mobi/bloc/competition_round/competition_round_bloc.dart';
import '../../bloc/competition_round/competition_round_event.dart';
import '../../utils/app_color.dart';
import '../../utils/log.dart';
import 'component/body_round.dart';

class ViewCompetitionRoundPage extends StatefulWidget {
  CompetitionRoundBloc bloc;

  ViewCompetitionRoundPage({required this.bloc});

  @override
  State<StatefulWidget> createState() => _ViewCompetitionRoundPageState();
}

class _ViewCompetitionRoundPageState extends State<ViewCompetitionRoundPage>
    with AutomaticKeepAliveClientMixin {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  CompetitionRoundBloc get _bloc => widget.bloc;

  @override
  void initState() {
    super.initState();
  }

  void didChangeDependencies() {
    RouteSettings settings = ModalRoute.of(context)!.settings;
    if (settings.arguments != null) {
      Log.info('Settings arguments: ${settings.arguments}');
      _bloc.add(
          LoadRoundsByCompetition(competitionId: settings.arguments as int));
      _bloc.isLoading = true;
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
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          ),
          title: const Text(
            "Các vòng thi",
            style: TextStyle(color: Colors.white),
          ),
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: AppColors.mainColor,
        ),
        body: Body(),
      ),
    );
  }
}
