import 'package:equatable/equatable.dart';
import 'package:unicec_mobi/models/entities/member/member_detail_model.dart';

import '../../models/entities/club/club_model.dart';

class ClubState extends Equatable {
  final ClubModel? ClubSelected; // -> load club của Current User chọn
  final MemberDetailModel? MemberSelected;
  bool? isOutClubSuccess;

  ClubState({this.ClubSelected, this.MemberSelected, this.isOutClubSuccess});

  ClubState copyWith(
      {ClubModel? ClubSelected, MemberDetailModel? MemberSelected, bool? isOutClubSuccess}) {
    return ClubState(
        ClubSelected: ClubSelected, MemberSelected: MemberSelected, isOutClubSuccess: isOutClubSuccess);
  }

  @override
  List<Object?> get props => [ClubSelected, MemberSelected, isOutClubSuccess];
}
