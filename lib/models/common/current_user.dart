import 'package:unicec_mobi/models/entities/member/member_detail_model.dart';
import 'package:unicec_mobi/models/entities/seedswallet/seeds_wallet_model.dart';

import '../entities/club/club_model.dart';

class CurrentUser {
  int id;
  int? universityId;
  String? universityName;
  String idToken;
  String email;
  String fullname;
  String? avatar;
  SeedsWalletModel seedsWallet;

  //
  List<ClubModel> clubsBelongToStudent;
  int clubIdSelected;
  List<MemberDetailModel?> membersBelongToClubs;
  MemberDetailModel? memberSelected;

  CurrentUser({
    required this.id,
    this.universityId,
    this.universityName,
    required this.idToken,
    required this.email,
    required this.fullname,
    this.avatar,
    required this.clubsBelongToStudent,
    required this.membersBelongToClubs,
    required this.clubIdSelected,
    required this.seedsWallet
  });

  CurrentUser get currentUser => CurrentUser(
      id: id,
      universityId: universityId,
      universityName: universityName,
      idToken: idToken,
      email: email,
      fullname: fullname,
      avatar: avatar,
      clubsBelongToStudent: clubsBelongToStudent,
      membersBelongToClubs: membersBelongToClubs,
      clubIdSelected: clubIdSelected,
      seedsWallet: seedsWallet);

  void reset() {
    id = 0;
    universityId = 0;
    universityName = '';
    idToken = "";
    email = "";
    fullname = "";
    avatar = "";
    clubsBelongToStudent = [];
    clubIdSelected = 0;
    membersBelongToClubs = [];
    memberSelected = null;
  }
}
