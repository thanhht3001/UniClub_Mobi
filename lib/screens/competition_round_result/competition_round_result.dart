import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/competition_round/competition_round_bloc.dart';
import '../../utils/app_color.dart';
import '../../utils/log.dart';
import 'component/competition_round_result_menu.dart';

class ViewCompetitionRoundResultPage extends StatefulWidget {
  CompetitionRoundBloc bloc;

  ViewCompetitionRoundResultPage({required this.bloc});

  @override
  State<StatefulWidget> createState() => _ViewCompetitionRoundResultPageState();
}

class _ViewCompetitionRoundResultPageState
    extends State<ViewCompetitionRoundResultPage>
    with AutomaticKeepAliveClientMixin {
  //bloc
  CompetitionRoundBloc get bloc => widget.bloc;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    RouteSettings settings = ModalRoute.of(context)!.settings;
    int competitionId = 0;
    if (settings.arguments != null) {
      var args = settings.arguments as Map;
      competitionId = args['competitionId'] ?? 0;
      Log.info('settings.arguments: $competitionId');
    }

    return BlocProvider.value(
      value: bloc,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          ),
          title: Text(
            (competitionId == 0) ? "Kết quả vòng thi" : "Kết quả cuộc thi",
            style: const TextStyle(color: Colors.white),
          ),
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: AppColors.mainColor,
        ),
        body: ViewCompetitionRoundResultMenu(),
      ),
    );
  }
}
