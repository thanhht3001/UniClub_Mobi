import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/competition_round/competition_round_bloc.dart';
import '../../../bloc/competition_round/competition_round_state.dart';
import '../../../utils/loading.dart';
import 'list_round_menu.dart';

class Body extends StatefulWidget {
  Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CompetitionRoundBloc _bloc = BlocProvider.of<CompetitionRoundBloc>(context);

    return BlocBuilder<CompetitionRoundBloc, CompetitionRoundState>(
        bloc: _bloc,
        builder: (context, state) {
          return _bloc.isLoading
              ? Loading()
              : SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: (state.competitionRounds!.isNotEmpty)
                      ? ViewListRoundMenu(
                          competitionRounds: state.competitionRounds!)
                      : Padding(
                          padding: const EdgeInsets.only(top: 180.0),
                          child: Column(
                            children: [
                              Container(
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          alignment: Alignment.topCenter,
                                          image: AssetImage(
                                              "assets/img/not-found-icon-24.jpg"),
                                          fit: BoxFit.fitWidth))),
                              Image.asset("assets/img/not-found-icon-24.jpg"),
                              const Padding(
                                padding: EdgeInsets.only(top: 25.0),
                                child: Text(
                                  'Hiện tại cuộc thi chưa có Vòng Thi nào!',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ],
                          ),
                        ));
        });
  }
}
