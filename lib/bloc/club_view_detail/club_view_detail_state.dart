import 'package:equatable/equatable.dart';

import '../../models/entities/club/club_model.dart';
import '../../models/enums/member_status.dart';

class ClubViewDetailState extends Equatable {
  ClubModel? clubViewDetail;
  MemberStatus statusMember;

  ClubViewDetailState(
      {required this.clubViewDetail, required this.statusMember});

  ClubViewDetailState copyWith(
      {required ClubModel? clubViewDetail,
      required MemberStatus statusMember}) {
    return ClubViewDetailState(
        clubViewDetail: clubViewDetail, statusMember: statusMember);
  }

  @override
  List<Object?> get props => [clubViewDetail, statusMember];
}
