import '../../models/common/paging_request.dart';
import '../../models/common/paging_result.dart';
import '../../models/entities/club/club_model.dart';
import '../../models/entities/member/member_detail_model.dart';

abstract class IClubService {
  Future<ClubModel?> getClubSelected(int? ClubId);

  Future<MemberDetailModel?> getMemberSelected(int? clubId);

  Future<PagingResult<ClubModel>?> getClubsBelongToUniversity(PagingRequest request);

  Future<List<MemberDetailModel>?> getMembersBelongToClubs();

  Future<List<ClubModel>> getListClubsBelongToStudent(int? userId);
  //get member belong to user -> active
  Future<MemberDetailModel?> getMemberBelongToClub(int? clubId);
  Future<bool> outClubOfMember(int memberId);
}
