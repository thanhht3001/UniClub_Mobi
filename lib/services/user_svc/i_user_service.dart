import 'package:unicec_mobi/models/common/paging_result.dart';
import 'package:unicec_mobi/models/common/resultCRUD.dart';
import 'package:unicec_mobi/models/entities/department/department_model.dart';
import 'package:unicec_mobi/models/entities/seedswallet/seeds_wallet_model.dart';
import 'package:unicec_mobi/models/entities/university/university_model.dart';

import '../../models/entities/user/user_model.dart';

abstract class IUserService{
  Future<UserModel?> getById(int id);
  Future<SeedsWalletModel?> getSeedsWalletByUser(int userId);
  Future<UniversityModel?> getUniById(int universityId);
  Future<DepartmentModel?> getDepartmentById(int departmentId);
  Future<ResultCRUD> updateUser(UserModel user);
  Future<PagingResult<DepartmentModel>?> loadDepartmentsByUni(int universityId);
}