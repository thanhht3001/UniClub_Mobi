import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/view_detail_activity/view_detail_activity_bloc.dart';
import '../../bloc/view_detail_activity/view_detail_activity_event.dart';
import '../../constants/Theme.dart';
import '../../utils/app_color.dart';
import '../widgets/drawer.dart';
import 'component/activity_menu.dart';

class ViewDetailActivityPage extends StatefulWidget {
  //bloc
  final ViewDetailActivityBloc bloc;

  ViewDetailActivityPage({required this.bloc});

  @override
  State<StatefulWidget> createState() => _ViewDetailActivityPageState();
}

class _ViewDetailActivityPageState extends State<ViewDetailActivityPage>
    with AutomaticKeepAliveClientMixin {
  //get bloc
  ViewDetailActivityBloc get bloc => widget.bloc;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    bloc.listenerStream.listen((event) {
      if (event is ShowingSnackBarEvent) {
        if (event.message.contains("thành công")) {
          AwesomeDialog(
            context: context,
            animType: AnimType.LEFTSLIDE,
            headerAnimationLoop: false,
            dialogType: DialogType.SUCCES,
            showCloseIcon: true,
            title: 'Thành Công',
            desc: 'Cập nhật trạng thái hoạt động thành công',
            btnOkOnPress: () {},
            btnOkIcon: Icons.check_circle,
            onDissmissCallback: (type) {
              debugPrint('Dialog Dissmiss from callback $type');
            },
          ).show();
        } else {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.ERROR,
            animType: AnimType.RIGHSLIDE,
            headerAnimationLoop: true,
            title: 'Thất bại',
            desc: 'Cập nhật trạng thái hoạt động thất bại',
            btnOkOnPress: () {},
            btnOkIcon: Icons.cancel,
            btnOkColor: Colors.red,
          ).show();
        }
      }

      if(event is NavigateToListActivitiesEvent){
        Navigator.of(context).pop(true);
        Navigator.of(context).pop(true);
      }
    });
  }

  //nhận competition Id
  void didChangeDependencies() {
    RouteSettings settings = ModalRoute.of(context)!.settings;
    if (settings.arguments != null) {
      int competitionActivityId = settings.arguments as int;
      if (competitionActivityId != 0) {
        bloc.add(
            ReceiveDataEvent(competitionActivityId: competitionActivityId));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              icon: const Icon(Icons.arrow_back, color: Colors.white),
            ),
            title: const Text("Chi tiết hoạt động",
                style: TextStyle(color: Colors.white)),
            centerTitle: true,
            backgroundColor: AppColors.mainColor,
          ),
          backgroundColor: ArgonColors.bgColorScreen,
          drawer: ArgonDrawer(currentPage: "Profile"),
          body: ViewDetailActivityMenu()),
    );
  }
}
