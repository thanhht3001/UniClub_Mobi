import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicec_mobi/bloc/view_detail_match/view_detail_match_bloc.dart';
import '../../bloc/view_detail_match/view_detail_match_event.dart';
import '../../models/entities/match/match_model.dart';
import '../../utils/app_color.dart';
import 'component/detail_match_menu.dart';

class ViewDetailMatchPage extends StatefulWidget {
  //bloc
  ViewDetailMatchBloc bloc;

  ViewDetailMatchPage({required this.bloc});

  @override
  State<StatefulWidget> createState() => _ViewDetailMatchPageState();
}

class _ViewDetailMatchPageState extends State<ViewDetailMatchPage>
    with AutomaticKeepAliveClientMixin {
  ViewDetailMatchBloc get bloc => widget.bloc;
  //
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {}

  void didChangeDependencies() {
    RouteSettings? settings = ModalRoute.of(context)?.settings;
    if (settings != null) {
      bloc.add(LoadData(match: settings.arguments as MatchModel));
    }
  }

  @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       leading: IconButton(
  //         onPressed: () {
  //           Navigator.pop(context);
  //         },
  //         icon: Icon(Icons.arrow_back_ios, color: Colors.white),
  //       ),
  //       title: const Text(
  //         "Chi tiết trận đấu",
  //         style: TextStyle(color: Colors.white),
  //       ),
  //       automaticallyImplyLeading: false,
  //       centerTitle: true,
  //       backgroundColor: AppColors.mainColor,
  //     ),
  //     body: ViewDetailMatchMenu(),
  //   );
  // }
  Widget build(BuildContext context) {
    return BlocProvider.value(
        value: bloc,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            ),
            title: const Text(
              "Chi tiết trận đấu",
              style: TextStyle(color: Colors.white),
            ),
            automaticallyImplyLeading: false,
            centerTitle: true,
            backgroundColor: AppColors.mainColor,
          ),
          body: ViewDetailMatchMenu(),
        ));
  }
}
