import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicec_mobi/bloc/clubs_view/clubs_view_bloc.dart';
import 'package:unicec_mobi/utils/router.dart';

import '../../bloc/clubs_view/clubs_view_event.dart';
import '../../utils/app_color.dart';
import '../../utils/dimens.dart';
import 'widgets/clubs_view_list.dart';

class ClubsViewPage extends StatefulWidget {
  final ClubsViewBloc bloc;

  ClubsViewPage({required this.bloc});

  @override
  _ClubsViewPageState createState() => _ClubsViewPageState();
}

class _ClubsViewPageState extends State<ClubsViewPage> {
  ClubsViewBloc get bloc => widget.bloc;

  @override
  void initState() {
    bloc.listenerStream.listen((event) async {
      if (event is NavigatorClubViewDetailPageEvent) {
        bool returnData = await Navigator.pushNamed(
                context, Routes.clubViewDetail, arguments: event.clubSelect)
            as bool;
        if (returnData) {
          bloc.add(RefreshEvent());
          bloc.add(ClubsViewInitEvent());
        }
      }
    });
    bloc.add(ClubsViewInitEvent());
    super.initState();
    bloc.isLoading = true;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
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
            // iconTheme: const IconThemeData(color: Colors.white),
            title: Text('Danh sách các Câu Lạc Bộ',
                style: TextStyle(color: Colors.white, fontSize: Dimens.size23)),
            backgroundColor: AppColors.mainColor,
            automaticallyImplyLeading: false,
            centerTitle: true,
          ),
          body: ListViewClubs()),
    );
  }
}
