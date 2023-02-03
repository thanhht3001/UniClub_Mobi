import 'package:unicec_mobi/models/common/paging_request.dart';
import 'package:unicec_mobi/models/common/paging_result.dart';
import 'package:unicec_mobi/models/entities/member/member_detail_model.dart';
import 'package:unicec_mobi/services/club_svc/i_club_service.dart';
import '../../models/entities/club/club_model.dart';
import '../../utils/base_bloc.dart';
import 'clubs_view_event.dart';
import 'clubs_view_state.dart';

class ClubsViewBloc extends BaseBloc<ClubsViewEvent, ClubsViewState> {
  IClubService service;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool isLoading) {
    _isLoading = isLoading;
  }

  final int pageSize = 10; // default pageSize

  ClubsViewBloc({required this.service})
      : super(ClubsViewState(
            listClubsBelongToUniversity: [], hasNext: false, currentPage: 1)) {
    on((event, emit) async {
      if (event is ClubsViewInitEvent) {
        _isLoading = true;
        PagingRequest request = PagingRequest(currentPage: state.currentPage, pageSize: pageSize);

        PagingResult<ClubModel>? result =
            await service.getClubsBelongToUniversity(request);
        List<ClubModel> listClubsUni = result?.items ?? [];

        if (listClubsUni.isNotEmpty) {
          //load list member thuộc club đó có cả Status Pending, Active
          List<MemberDetailModel>? listMembersBelongToClubs =
              await service.getMembersBelongToClubs();

          if (listMembersBelongToClubs != null) {
            for (var memberOfClub in listMembersBelongToClubs) {
              for (var clubOfUni in listClubsUni) {
                if (memberOfClub.clubId == clubOfUni.id) {
                  clubOfUni.isMemberStatus = memberOfClub.status;
                }
              }
            }
          }

          emit(state.copyWith(
              listClubsBelongToUniversity: listClubsUni,
              hasNext: result?.hasNext ?? state.hasNext,
              currentPage: result?.currentPage ?? state.currentPage));
        } else {
          //thông báo lỗi load clubs
        }

        _isLoading = false;
      }
      //
      if (event is IncrementalEvent) {
        int increase = state.currentPage + 1;
        emit(state.copyWith(
            listClubsBelongToUniversity: state.listClubsBelongToUniversity,
            hasNext: state.hasNext,
            currentPage: increase));
      }
      //
      if (event is RefreshEvent) {
        //refresh state
        emit(state.copyWith(
            listClubsBelongToUniversity: [], hasNext: false, currentPage: 1));
      }
      // tự chạy hàm loading
      if (event is LoadAddMoreEvent) {
        PagingRequest request = PagingRequest(currentPage: state.currentPage, pageSize: pageSize);

        PagingResult<ClubModel>? result =
            await service.getClubsBelongToUniversity(request);
        //
        List<ClubModel> listContinue = result?.items ?? [];
        //
        if (listContinue.isNotEmpty) {
          //load list member thuộc club đó có cả Status Pending, Active
          List<MemberDetailModel>? listMembersBelongToClubs =
              await service.getMembersBelongToClubs();

          if (listMembersBelongToClubs != null) {
            for (var memberOfClub in listMembersBelongToClubs) {
              for (var clubOfUni in listContinue) {
                if (memberOfClub.clubId == clubOfUni.id) {
                  clubOfUni.isMemberStatus = memberOfClub.status;
                }
              }
            }
          }

          for (ClubModel club in listContinue) {
            state.listClubsBelongToUniversity.add(club);
          }
        }
        //
        emit(state.copyWith(
            listClubsBelongToUniversity: state.listClubsBelongToUniversity,
            hasNext: result?.hasNext ??
                false, // result trả ra null thì đồng nghĩa với việc hasNext = false
            currentPage: result?.currentPage ?? state.currentPage));
      }

      if (event is ChooseClubEvent) {
        listener.add(
            NavigatorClubViewDetailPageEvent(clubSelect: event.clubSelect));
      }
    });
  }
}
