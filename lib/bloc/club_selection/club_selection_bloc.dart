import 'package:get_it/get_it.dart';

import '../../models/common/current_user.dart';
import '../../models/entities/member/member_detail_model.dart';
import '../../services/club_svc/i_club_service.dart';
import '../../utils/base_bloc.dart';
import 'club_selection_event.dart';
import 'club_selection_state.dart';

class ClubSelectionBloc
    extends BaseBloc<ClubSelectionEvent, ClubSelectionState> {
  IClubService service; //-> mượn hàm của login
  bool _isLoading = false;
  
  bool get isLoading => _isLoading;

  set isLoading(bool isLoading){
    _isLoading = isLoading;
  }

  ClubSelectionBloc({required this.service})
      : super(ClubSelectionState(
            listClubsBelongToStudent: [], listMembersBelongToClubs: [])) {
    on((event, emit) async {
      if (event is ClubSelectionEvent) {
        _isLoading = true;
        CurrentUser user = GetIt.I.get<CurrentUser>();
        user.clubsBelongToStudent = await service.getListClubsBelongToStudent(user.id); // load again when go to selection club screen
        user.membersBelongToClubs = [];
        for(var club in user.clubsBelongToStudent){
          MemberDetailModel? member =
                await service.getMemberBelongToClub(club.id);
          user.membersBelongToClubs.add(member);
        }

        emit(state.copyWith(
            listClubsBelongToStudent: user.clubsBelongToStudent, // here
            listMembersBelongToClubs: user.membersBelongToClubs));

        if(user.clubsBelongToStudent.isEmpty) { // reset selected club
          user.clubIdSelected = 0;
        }

        _isLoading = false;    
      }

      if (event is ChooseClubSelectionEvent) {
        _isLoading = true;
        CurrentUser user = GetIt.I.get<CurrentUser>();
        user.clubIdSelected = event.clubIdSelected;
        listener.add(NavigatorClubPageEvent());
        _isLoading = false;
      }

      if (event is ClubsViewPageEvent) {
        listener.add(NavigatorClubsViewPageEvent());
      }

      //hàm refresh cho nên add lại hết state global
      if (event is RefreshEvent) {
        _isLoading = true;
        //
        CurrentUser user = GetIt.I.get<CurrentUser>();
        user.clubsBelongToStudent =
            await service.getListClubsBelongToStudent(user.id);  
        
        //load list member belong to club -> active
        if (user.clubsBelongToStudent.isNotEmpty) {
          user.membersBelongToClubs = [];
          for (var club in user.clubsBelongToStudent) {
            MemberDetailModel? member =
                await service.getMemberBelongToClub(club.id);

            user.membersBelongToClubs.add(member);
          }
        }
        emit(state.copyWith(
            listClubsBelongToStudent: user.clubsBelongToStudent,
            listMembersBelongToClubs: user.membersBelongToClubs));
        
        _isLoading = false;
      }
    });
  }
}
