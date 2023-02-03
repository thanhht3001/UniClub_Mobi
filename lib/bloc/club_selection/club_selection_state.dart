import 'package:equatable/equatable.dart';

import '../../models/entities/club/club_model.dart';
import '../../models/entities/member/member_detail_model.dart';

class ClubSelectionState extends Equatable {
  final List<ClubModel> listClubsBelongToStudent;
  final List<MemberDetailModel?> listMembersBelongToClubs;

  ClubSelectionState(
      {required this.listClubsBelongToStudent,
      required this.listMembersBelongToClubs});

  ClubSelectionState copyWith(
      {required List<ClubModel> listClubsBelongToStudent,
      required List<MemberDetailModel?> listMembersBelongToClubs}) {
    return ClubSelectionState(
        listClubsBelongToStudent: listClubsBelongToStudent,
        listMembersBelongToClubs: listMembersBelongToClubs);
  }

  @override
  List<Object?> get props =>
      [listClubsBelongToStudent, listMembersBelongToClubs];
}
