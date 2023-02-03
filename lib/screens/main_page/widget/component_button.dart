import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/main/main_bloc.dart';
import '../../../utils/app_color.dart';

class ComponentButton extends StatelessWidget {
  final int index;
  final Function() onPressed;
  final String label;
  int? clubIdSelected;

  ComponentButton(
      {Key? key,
      required this.index,
      required this.onPressed,
      required this.label,
      this.clubIdSelected})
      : super(key: key);

  IconData getIconData() { // index == 2 set icon in main_page
    IconData iconData = Icons.event_available;
    if (index == 3) {
      iconData = Icons.notifications_active;
    } else if (index == 4) {
      iconData = Icons.person;
    }
    return iconData;
  }

  @override
  Widget build(BuildContext context) {
    IconData iconData = getIconData();
    MainBloc bloc = BlocProvider.of<MainBloc>(context);
    return MaterialButton(
      padding: const EdgeInsets.symmetric(vertical: 5),
      onPressed: onPressed,
      child: Column(
        children: [
          Icon(
            iconData,
            color: bloc.state.currentPageIndex == index
                ? AppColors.mainColor
                : Colors.grey,
          ),
          Text(
            label,
            style: TextStyle(
                color: bloc.state.currentPageIndex == index
                    ? AppColors.mainColor
                    : Colors.grey,
                fontSize: 13),
          )
        ],
      ),
    );
  }
}
