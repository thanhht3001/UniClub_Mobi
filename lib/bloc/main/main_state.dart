import 'package:equatable/equatable.dart';

class MainState extends Equatable {
  final int currentPageIndex;
  final bool isHiddenFAB;
  final int clubSelected;

  const MainState(
      {required this.currentPageIndex,
      required this.isHiddenFAB,
      required this.clubSelected});

  MainState copyWith({
    int? currentPageIndex,
    bool? isHiddenFAB,
    int? clubSelected,
  }) {
    return MainState(
        currentPageIndex: currentPageIndex ?? this.currentPageIndex,
        isHiddenFAB: isHiddenFAB ?? this.isHiddenFAB,
        clubSelected: clubSelected ?? this.clubSelected);
  }

  @override
  List<Object> get props => [currentPageIndex, isHiddenFAB, clubSelected];
}

// class SecondState extends MainState {
//   SecondState({required super.currentPageIndex, required super.isHiddenFAB});
// }
