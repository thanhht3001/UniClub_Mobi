import 'package:unicec_mobi/models/entities/member/member_model.dart';
import 'package:unicec_mobi/models/enums/member_status.dart';

import '../../models/entities/club_role/club_role_model.dart';

abstract class IMemberService {
  Future<MemberModel?> applyInClub(int clubId);
  Future<MemberStatus> getStatusMember(int clubId);
  Future<List<MemberModel>?> getListMemberByClub(
      int clubId, String? searchName, int? clubRoleId);
  Future<List<ClubRoleModel>?> getListClubRole();
}
