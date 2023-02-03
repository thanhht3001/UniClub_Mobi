import 'package:equatable/equatable.dart';

import '../../models/entities/club_role/club_role_model.dart';
import '../../models/entities/member/member_model.dart';

class ViewListMemberState extends Equatable {
  List<MemberModel> listMember;
  String? searchName;
  int? clubRoleId;
  //
  List<ClubRoleModel> listClubRole;

  ViewListMemberState(
      {required this.listMember,
      required this.searchName,
      required this.clubRoleId,
      required this.listClubRole});

  ViewListMemberState copyWith(
      {required List<MemberModel> newListMember,
      required String? newSearchName,
      required int? newClubRoleId,
      required List<ClubRoleModel> listClubRole}) {
    return ViewListMemberState(
        listMember: newListMember,
        searchName: newSearchName,
        clubRoleId: newClubRoleId,
        listClubRole: listClubRole);
  }

  @override
  List<Object?> get props => [listMember, searchName, clubRoleId, listClubRole];
}
