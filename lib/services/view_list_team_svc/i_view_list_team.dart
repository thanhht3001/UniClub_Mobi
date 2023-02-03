

import '../../models/entities/team/team_model.dart';

abstract class IViewListTeamService{
  Future<TeamModel> getListTeamByConditions();
  Future<TeamModel> getById(int id);
}