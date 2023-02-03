import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicec_mobi/bloc/view_list_match/view_list_match_bloc.dart';
import '../../bloc/view_list_match/view_list_match_event.dart';
import '../../models/entities/competition_round/competition_round_model.dart';
import '../../utils/app_color.dart';
import 'component/list_match_menu.dart';

class ViewListMatchPage extends StatefulWidget {
  ViewListMatchBloc bloc;

  ViewListMatchPage({required this.bloc});

  @override
  State<StatefulWidget> createState() => _ViewListMatchPageState();
}

class _ViewListMatchPageState extends State<ViewListMatchPage>
    with AutomaticKeepAliveClientMixin {
  ViewListMatchBloc get _bloc => widget.bloc;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  void didChangeDependencies() {
    RouteSettings? settings = ModalRoute.of(context)?.settings;
    if (settings != null) {
      CompetitionRoundModel round = settings.arguments as CompetitionRoundModel;
      _bloc.isLoading = true;
      _bloc.add(LoadMatchesByRoundEvent(roundId: round.id, round: round));         
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
              "Danh sách các trận đấu",
              style: TextStyle(color: Colors.white),
            ),
            automaticallyImplyLeading: false,
            centerTitle: true,
            backgroundColor: AppColors.mainColor,
          ),
          body: ListMatchMenu(),
        ));
  }
}
