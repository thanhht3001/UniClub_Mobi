import 'package:get_it/get_it.dart';

import '../../models/common/current_user.dart';
import '../../models/entities/club_role/club_role_model.dart';
import '../../models/entities/member/member_model.dart';
import '../../services/member_svc/i_member_service.dart';
import '../../utils/base_bloc.dart';
import 'view_list_member_event.dart';
import 'view_list_member_state.dart';

class ViewListMemberBloc
    extends BaseBloc<ViewListMemberEvent, ViewListMemberState> {
  IMemberService service;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool isLoading) {
    _isLoading = isLoading;
  }

  ViewListMemberBloc({required this.service})
      : super(ViewListMemberState(
            listMember: [],
            searchName: null,
            clubRoleId: 0,
            listClubRole: [])) {
    (on((event, emit) async {
      if (event is LoadListMemberEvent) {
        _isLoading = true;
        //getListCLubRole
        List<ClubRoleModel> listModel = [];
        List<ClubRoleModel>? listClubRole = await service.getListClubRole();
        if (listClubRole != null) {
          //tạo 1 club role model all
          ClubRoleModel model = ClubRoleModel(id: 0, name: 'Tất cả');
          listClubRole.add(model);
        } else {
          //tạo 1 club role model all
          ClubRoleModel model = ClubRoleModel(id: 0, name: 'Tất cả');
          //
          listModel.add(model);
        }

        //get list
        int clubIdSelected = GetIt.I.get<CurrentUser>().clubIdSelected;
        List<MemberModel>? result = await service.getListMemberByClub(
            clubIdSelected,
            state.searchName,
            (state.clubRoleId != 0) ? state.clubRoleId : null);

        if (result != null) {
          emit(state.copyWith(
              newListMember: result,
              newSearchName: state.searchName,
              newClubRoleId: state.clubRoleId,
              listClubRole: listClubRole ?? listModel));
        } else {
          emit(state.copyWith(
              newListMember: [],
              newSearchName: state.searchName,
              newClubRoleId: state.clubRoleId,
              listClubRole: listModel));
        }
        _isLoading = false;
      }
      if (event is ChangeSearchNameEvent) {
        emit(state.copyWith(
            newListMember: state.listMember,
            newSearchName: event.searchName, // change
            newClubRoleId: state.clubRoleId,
            listClubRole: state.listClubRole));
      }
      if (event is ChangeClubRoleIdEvent) {
        int clubIdSelected = GetIt.I.get<CurrentUser>().clubIdSelected;
        List<MemberModel>? result = await service.getListMemberByClub(
            clubIdSelected,
            state.searchName,
            (event.clubRoleId != 0) ? event.clubRoleId : null);

        emit(state.copyWith(
            newListMember: result ?? [],
            newSearchName: state.searchName,
            newClubRoleId: event.clubRoleId, // change
            listClubRole: state.listClubRole));
      }
      if (event is SearchEvent) {
        int clubIdSelected = GetIt.I.get<CurrentUser>().clubIdSelected;
        List<MemberModel>? result = await service.getListMemberByClub(
            clubIdSelected,
            state.searchName,
            (state.clubRoleId != 0) ? state.clubRoleId : null);
        if (result != null) {
          emit(state.copyWith(
              newListMember: result,
              newSearchName: state.searchName,
              newClubRoleId: state.clubRoleId,
              listClubRole: state.listClubRole));
        } else {
          emit(state.copyWith(
              newListMember: [],
              newSearchName: state.searchName,
              newClubRoleId: state.clubRoleId,
              listClubRole: state.listClubRole));
        }
      }
      if (event is ResetFilterEvent) {
        //getListCLubRole
        List<ClubRoleModel> listModel = [];
        List<ClubRoleModel>? listClubRole = await service.getListClubRole();
        if (listClubRole != null) {
          //tạo 1 club role model all
          ClubRoleModel model = new ClubRoleModel(id: 0, name: 'Tất cả');
          listClubRole.add(model);
        } else {
          //tạo 1 club role model all
          ClubRoleModel model = new ClubRoleModel(id: 0, name: 'Tất cả');
          //
          listModel.add(model);
        }

        int clubIdSelected = GetIt.I.get<CurrentUser>().clubIdSelected;
        List<MemberModel>? result =
            await service.getListMemberByClub(clubIdSelected, null, null);
        if (result != null) {
          emit(state.copyWith(
              newListMember: result,
              newSearchName: null,
              newClubRoleId: 0,
              listClubRole: listClubRole ?? listModel));
        } else {
          emit(state.copyWith(
              newListMember: [],
              newSearchName: null,
              newClubRoleId: 0,
              listClubRole: listModel));
        }
      }
      if (event is ClickToViewInfoEvent) {
        listener.add(NavigatorToAccountPageEvent(userId: event.userId));
      }
    }));
  }
}
