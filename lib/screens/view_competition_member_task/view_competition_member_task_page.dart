import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../utils/loading.dart';
import '/bloc/view_competition_member_task/view_competition_member_task_event.dart';
import '../../bloc/view_competition_member_task/view_competition_member_task_bloc.dart';
import '../../utils/app_color.dart';
import 'component/list_competition_member_task_menu.dart';

class ViewCompetitionMemberTaskPage extends StatefulWidget {
  final ViewCompetitionMemberTaskBloc bloc;

  ViewCompetitionMemberTaskPage({required this.bloc});

  @override
  State<StatefulWidget> createState() =>
      _ViewCompetitionMemberTaskPagePageState();
}

class _ViewCompetitionMemberTaskPagePageState
    extends State<ViewCompetitionMemberTaskPage>
    with AutomaticKeepAliveClientMixin {
  //bloc
  ViewCompetitionMemberTaskBloc get bloc => widget.bloc;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    bloc.add(
        LoadingEvent()); // bloc này là singleton nên lúc nào quay lại cũng phải chạy hàm này để có loading state = true
    bloc.add(InitEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
        value: bloc,
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              "Công việc Cuộc Thi & Sự Kiện tham gia",
              style: TextStyle(color: Colors.white),
            ),
            automaticallyImplyLeading: false,
            centerTitle: true,
            backgroundColor: AppColors.mainColor,
          ),
          body: ViewCompetitionMemberTaskMenu(),
        ));
  }
}
