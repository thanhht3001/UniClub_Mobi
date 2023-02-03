import '../../models/entities/department/department_model.dart';
import '../../models/entities/user/complete_profile.dart';

abstract class IUniversitySelectionService {
  Future<bool> completeProfile(CompleteProfile model);

  Future<List<DepartmentModel>?> getDepartmentByUni(int universityId);
}
