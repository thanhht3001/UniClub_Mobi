import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicec_mobi/bloc/competition_round/competition_round_bloc.dart';
import 'package:unicec_mobi/models/enums/competition_round_status.dart';
import 'package:unicec_mobi/utils/log.dart';
import '../../../constants/Theme.dart';
import '../../../models/entities/competition_round/competition_round_model.dart';
import '../../../utils/app_color.dart';
import '../../../utils/router.dart';

class ViewListRoundMenu extends StatefulWidget {
  List<CompetitionRoundModel> competitionRounds;

  ViewListRoundMenu({Key? key, required this.competitionRounds})
      : super(key: key);

  @override
  _ViewListRoundMenuState createState() => _ViewListRoundMenuState();
}

class _ViewListRoundMenuState extends State<ViewListRoundMenu> {
  List<CompetitionRoundModel> get _competitionRounds =>
      widget.competitionRounds;

  @override
  Widget build(BuildContext context) {
    CompetitionRoundBloc _bloc = BlocProvider.of<CompetitionRoundBloc>(context);
    Log.info('data competitionRound: ${_competitionRounds}');

    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          itemCount: _competitionRounds.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.black87,
                  padding: const EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  backgroundColor: const Color.fromARGB(255, 235, 237, 241),
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(Routes.viewListMatch,
                      arguments: _competitionRounds[index]);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(_competitionRounds[index].title,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                    if (_competitionRounds[index].status ==
                        CompetitionRoundStatus.Active)
                      const Text("Sắp diễn ra",
                          style: TextStyle(
                              fontSize: 17,
                              color: ArgonColors.success,
                              fontWeight: FontWeight.normal)),
                    if (_competitionRounds[index].status ==
                        CompetitionRoundStatus.Happening)
                      const Text("Đang diễn ra",
                          style: TextStyle(
                              fontSize: 17,
                              color: ArgonColors.label,
                              fontWeight: FontWeight.normal)),
                    if (_competitionRounds[index].status ==
                            CompetitionRoundStatus.Finished)
                      const Text("Kết thúc",
                          style: TextStyle(
                              fontSize: 17,
                              color: Colors.grey,
                              fontWeight: FontWeight.normal)),
                    if (_competitionRounds[index].status ==
                            CompetitionRoundStatus.Cancel)
                      const Text("Đã hủy",
                          style: TextStyle(
                              fontSize: 17,
                              color: ArgonColors.error,
                              fontWeight: FontWeight.normal)),                    
                    Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.mainColor,
                    )
                  ],
                ),
              ),
            );
          },
        )
      ],
    );
  }
}
