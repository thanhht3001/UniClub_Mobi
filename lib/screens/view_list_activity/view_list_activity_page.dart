import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/view_competition_activity/view_competition_activity_bloc.dart';
import '../../bloc/view_competition_activity/view_competition_activity_event.dart';
import '../../utils/app_color.dart';
import 'component/list_activity_menu.dart';

class ViewListActivityPage extends StatefulWidget {
  final ViewCompetitionActivityBloc bloc;

  ViewListActivityPage({required this.bloc});

  @override
  State<StatefulWidget> createState() => _ViewListActivityPageState();
}

class _ViewListActivityPageState extends State<ViewListActivityPage>
    with AutomaticKeepAliveClientMixin {
  //bloc
  ViewCompetitionActivityBloc get bloc => widget.bloc;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    //add init event
    //bloc.add(ViewCompetitionActivityInitEvent());
  }

  //nhận competition Id
  void didChangeDependencies() {
    RouteSettings settings = ModalRoute.of(context)!.settings;
    if (settings.arguments != null) {
      int competitionId = settings.arguments as int;
      if (competitionId != 0) {
        bloc.add(ReceiveDataEvent(competitionId: competitionId));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          ),
          title: const Text(
            "Danh Sách Công Việc",
            style: TextStyle(color: Colors.white),
          ),
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: AppColors.mainColor,
        ),
        body: ViewListActivityMenu(),
      ),
    );
  }
}
