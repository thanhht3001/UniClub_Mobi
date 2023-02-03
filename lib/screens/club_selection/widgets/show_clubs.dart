import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../../../bloc/club_selection/club_selection_bloc.dart';
import '../../../bloc/club_selection/club_selection_event.dart';
import '../../../bloc/club_selection/club_selection_state.dart';
import '../../../utils/dimens.dart';
import 'club_card.dart';

class ShowClubsBelongToStudent extends StatefulWidget {
  const ShowClubsBelongToStudent({Key? key}) : super(key: key);

  @override
  State<ShowClubsBelongToStudent> createState() =>
      _ShowClubsBelongToStudentState();
}

class _ShowClubsBelongToStudentState extends State<ShowClubsBelongToStudent> {
  @override
  Widget build(BuildContext context) {
    ClubSelectionBloc bloc = BlocProvider.of<ClubSelectionBloc>(context);
    return Column(
      children: [
        // SizedBox(height: Dimens.size10),
        // Text(
        //   'Chọn câu lạc bộ của bạn',
        //   style: TextStyle(
        //     fontWeight: FontWeight.w500,
        //     fontSize: 20.0,
        //   ),
        // ),
        SizedBox(
          height: Dimens.size10,
        ),
        BlocBuilder<ClubSelectionBloc, ClubSelectionState>(
            bloc: bloc,
            builder: (context, state) {
              return RefreshIndicator(
                      onRefresh: () {
                        return _refresh(context);
                      },
                      child: ListView.builder(
                        itemCount: state.listClubsBelongToStudent.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return ClubCard(
                            club:
                                state.listClubsBelongToStudent.elementAt(index),
                            member:
                                state.listMembersBelongToClubs.elementAt(index),
                          );
                        },
                      ));
            }),
      ],
    );
  }

  Future<bool> _refresh(BuildContext context) async {
    print("onRefresh");
    await Future.delayed(Duration(seconds: 0, milliseconds: 2000));
    BlocProvider.of<ClubSelectionBloc>(context).add(RefreshEvent());
    return true;
  }
}
