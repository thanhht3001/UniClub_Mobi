import 'package:equatable/equatable.dart';
import 'package:unicec_mobi/models/entities/competition_activity/competition_activity_detail_model.dart';
import 'package:unicec_mobi/models/enums/competition_activity_status.dart';

class ViewDetailActivityState extends Equatable {
  //load dữ liệu
  CompetitionActivityDetailModel? competitionActivityDetail;
  //chọn status nào và cập nhật
  CompetitionActivityStatus status;
  //chọn ảnh default
  int selectedImageIndex;
  bool isLoading;

  ViewDetailActivityState(
      {required this.competitionActivityDetail,
      required this.status,
      required this.selectedImageIndex,
      required this.isLoading});

  ViewDetailActivityState copyWith(
      {required CompetitionActivityDetailModel newCompetitionActivityDetail,
      required CompetitionActivityStatus newStatus,
      required int newSelectedImageIndex,
      required bool isLoading}) {
    return ViewDetailActivityState(
        competitionActivityDetail: newCompetitionActivityDetail,
        status: newStatus,
        selectedImageIndex: newSelectedImageIndex,
        isLoading: isLoading);
  }

  @override
  List<Object?> get props =>
      [competitionActivityDetail, status, selectedImageIndex, isLoading];
}
