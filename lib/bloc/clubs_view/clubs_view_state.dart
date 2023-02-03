import 'package:equatable/equatable.dart';

import '../../models/entities/club/club_model.dart';

class ClubsViewState extends Equatable {
  List<ClubModel> listClubsBelongToUniversity;
  bool hasNext;
  int currentPage;

  ClubsViewState({
    required this.listClubsBelongToUniversity,
    required this.hasNext,
    required this.currentPage,
  });

  ClubsViewState copyWith(
      {required List<ClubModel> listClubsBelongToUniversity,
      required bool hasNext,
      required int currentPage}) {
    return ClubsViewState(
        listClubsBelongToUniversity: listClubsBelongToUniversity,
        hasNext: hasNext,
        currentPage: currentPage);
  }

  @override
  List<Object?> get props =>
      [listClubsBelongToUniversity, hasNext, currentPage];
}
