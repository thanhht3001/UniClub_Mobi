import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/models/entities/team/sending_data_model.dart';
import '/models/entities/competition/send_data_model.dart';
import '../../bloc/view_list_team_participant/view_list_team_participant_bloc.dart';
import '../../bloc/view_list_team_participant/view_list_team_participant_event.dart';
import '../../bloc/view_list_team_participant/view_list_team_participant_state.dart';
import '../../utils/app_color.dart';
import '../../utils/router.dart';
import 'component/add_team_button.dart';
import 'component/body.dart';

class ViewListTeamParticipantPage extends StatefulWidget {
  final ViewListTeamParticipantBloc bloc;
  ViewListTeamParticipantPage({required this.bloc});
  @override
  State<StatefulWidget> createState() => _ViewListTeamParticipantPageState();
}

class _ViewListTeamParticipantPageState
    extends State<ViewListTeamParticipantPage>
    with AutomaticKeepAliveClientMixin {
  //bloc
  ViewListTeamParticipantBloc get bloc => widget.bloc;
  //
  final _formKeyTeamName = GlobalKey<FormState>();
  final _formKeyTeamDescription = GlobalKey<FormState>();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    //mặc định competition id 2
    //bloc.add(RecieveDataEvent(competitionId: 2));
    //
    bloc.listenerStream.listen((event) async {
      if (event is ShowingSnackBarEvent) {
        if (event.message.contains("thành công")) {
          AwesomeDialog(
            context: context,
            animType: AnimType.LEFTSLIDE,
            headerAnimationLoop: false,
            dialogType: DialogType.SUCCES,
            showCloseIcon: true,
            title: 'Thành Công',
            desc: 'Tạo đội thành công',
            btnOkOnPress: () {
              Navigator.of(context).pop;
            },
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
            desc: (event.message
                    .contains("Please out team previous to create new Team"))
                ? "Tạo đội thi thất bại, hiện tại bạn đã ở trong đội rồi"
                : (event.message.contains("bảo trì"))
                    ? "Thất bại, hiện tại Cuộc Thi & Sự Kiện đang bảo trì"
                    : (event.message.contains("qua thời gian tạo"))
                        ? "Thất bại, hiện tại đã quá thời gian cho phép thực hiện hành động"
                        : (event.message
                                .contains("You are already in that Team"))
                            ? "Tham gia đội thi thất bại, hiện tại bạn đã ở trong đội đó rồi"
                            : (event.message.contains(
                                    "Please out team previous to join the next Team"))
                                ? "Tham gia đội thi thất bại, hiện tại bạn đã ở trong đội rồi"
                                : (event.message.contains("Team is full"))
                                    ? "Tham gia đội thi thất bại, hiện tại số lượng thành viên trong đội đã đủ"
                                    : (event.message.contains(
                                            "Team Is Locked you can't join"))
                                        ? "Tham gia đội thi thất bại, đội thi đang ở trạng thái Đóng"
                                        : (event.message.contains(
                                                "Not found team with Invited Code"))
                                            ? "Thất bại, mã tham gia đội thi không hợp lệ"
                                            : event.message,
            btnOkOnPress: () {
              Navigator.of(context).pop;
            },
            btnOkIcon: Icons.cancel,
            btnOkColor: Colors.red,
          ).show();
        }
        // ScaffoldMessenger.of(context)
        //     .showSnackBar(SnackBar(content: Text(event.message)));
      }
      if (event is NavigatorTeamDetailPageEvent) {
        SendingDataModel data = SendingDataModel(
          competitionId: event.competitionId,
          teamId: event.teamId,
          teamName: event.teamName,
          teamDescription: event.teamDescription,
          status: event.status,
        );
        bool returnData = await Navigator.of(context)
                .pushNamed(Routes.viewDetailTeamParticipant, arguments: data)
            as bool;
        if (returnData) {
          bloc.add(LoadingEvent());
          bloc.add(ResetFilterEvent());
        }
      }
      if (event is RebuildListViewTeamEvent) {
        bloc.add(ViewListTeamInitEvent());
        // ScaffoldMessenger.of(context)
        //     .showSnackBar(SnackBar(content: Text("Tạo Team Thành Công !")));
      }
    });
  }

  //nhận competition Id
  void didChangeDependencies() {
    RouteSettings settings = ModalRoute.of(context)!.settings;
    if (settings.arguments != null) {
      SendDataModel competition = settings.arguments as SendDataModel;
      if (competition != null) {
        bloc.add(ReceiveDataEvent(
            competitionId: competition.competitionId,
            minNumber: competition.min,
            maxNumber: competition.max));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
        value: bloc,
        child: BlocBuilder<ViewListTeamParticipantBloc,
                ViewListTeamParticipantState>(
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
                    "Danh sách các đội tham gia",
                    style: TextStyle(color: Colors.white),
                  ),
                  automaticallyImplyLeading: false,
                  centerTitle: true,
                  backgroundColor: AppColors.mainColor,
                ),
                body: Body(),
                floatingActionButton: AddTeamButton(),
              );
            }));
  }
}
