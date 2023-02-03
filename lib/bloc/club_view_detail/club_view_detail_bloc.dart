import 'package:unicec_mobi/bloc/club_view_detail/club_view_detail_event.dart';
import 'package:unicec_mobi/bloc/club_view_detail/club_view_detail_state.dart';
import 'package:unicec_mobi/models/enums/member_status.dart';
import 'package:unicec_mobi/utils/base_bloc.dart';

import '../../models/entities/member/member_model.dart';
import '../../services/i_services.dart';

class ClubViewDetailBloc
    extends BaseBloc<ClubViewDetailEvent, ClubViewDetailState> {
  final IMemberService service;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool isLoading) {
    _isLoading = isLoading;
  }

  ClubViewDetailBloc({required this.service})
      : super(ClubViewDetailState(
            clubViewDetail: null, statusMember: MemberStatus.Student)) {
    on((event, emit) async {
      if (event is ReceiveDataEvent) {
        _isLoading = true;
        emit(state.copyWith(
            clubViewDetail: event.clubView,
            statusMember: event.clubView.isMemberStatus));
        _isLoading = false;
      }
      //
      if (event is ApplyInClubEvent) {
        MemberModel? result = await service.applyInClub(event.clubId);
        if (result != null) {
          listener
              .add(ShowPopUpAnnouncement(message: "Đã nộp đơn thành công !"));
          emit(state.copyWith(
              clubViewDetail: state.clubViewDetail ?? null,
              statusMember: result.status));
        } else {
          listener
              .add(ShowPopUpAnnouncement(message: "Không tham gia thành công"));
        }
      }
    });
  }
}
