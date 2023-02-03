import 'package:get_it/get_it.dart';
import '../../models/common/current_user.dart';
import '../../models/entities/club/club_model.dart';
import '../../models/entities/member/member_detail_model.dart';
import '../../services/i_services.dart';
import '../../utils/base_bloc.dart';
import 'club_event.dart';
import 'club_state.dart';

class ClubBloc extends BaseBloc<ClubEvent, ClubState> {
  final IClubService service;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool isLoading) {
    _isLoading = isLoading;
  }

  ClubBloc({required this.service})
      : super(ClubState(ClubSelected: null, MemberSelected: null)) {
    on((event, emit) async {
      if (event is ClubInitEvent) {
        print('ClubInitEvent is running!!!!!!!!!!!!!!!');
        _isLoading = true;
        CurrentUser user = GetIt.I.get<CurrentUser>();
        //
        //print('vừa vào trang club nếu có club phải qua trang chọn club cho t');
        //print(user.clubsBelongToStudent!.length.toString());
        //chuyển trang chọn clubs

        // load again clubs belong to student
        user.clubsBelongToStudent =
            await service.getListClubsBelongToStudent(user.id);

        if (user.clubsBelongToStudent.isNotEmpty) {
          if (user.clubIdSelected != 0 &&
              user.clubsBelongToStudent
                  .any((element) => element.id == user.clubIdSelected)) {
            //load info club selected
            ClubModel? clubSelected =
                await service.getClubSelected(user.clubIdSelected);

            //load info member selected
            MemberDetailModel? memberSelected =
                await service.getMemberSelected(user.clubIdSelected);

            //load cuộc thi của club selected
            if (clubSelected == null) {
              listener.add(ShowingSnackBarEvent(
                  message: "Chưa Load được club do User chưa chọn"));
            } else {
              emit(state.copyWith(
                  ClubSelected: clubSelected, MemberSelected: memberSelected));
            }
            _isLoading = false;
            return;
          }
          // user is out of club => reset
          user.clubIdSelected = 0;
          emit(state.copyWith(ClubSelected: null, MemberSelected: null));
        }

        listener.add(NavigatorClubSelectionPageEvent());
        _isLoading = false;
      }
      //
      if (event is ChooseAnotherClubEvent) {
        listener.add(NavigatorClubSelectionPageEvent());
      }
      //
      if (event is ClubSelectionEvent) {
        listener.add(NavigatorClubSelectionPageEvent());
      }
      //
      if (event is ClubsViewEvent) {
        listener.add(NavigatorClubsViewPageEvent());
      }
      //
      if (event is OutClubEvent) {
        print('OutClubEvent is running!!!!!!!!!!!!!!!');

        bool isSuccess = await service.outClubOfMember(event.memberId);        
        emit(state.copyWith(ClubSelected: state.ClubSelected, MemberSelected: state.MemberSelected, isOutClubSuccess: isSuccess));
        listener.add(ShowPopUpAnnouncementEvent(isSuccess: isSuccess));
      }
    });
  }
}
