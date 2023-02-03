class MemberTakesActivityModel {
  int id;
  int competitionActivityId;
  int memberId;
  String memberName;
  String memberImg;
  int bookerId;
  String bookerName;

  MemberTakesActivityModel(
      {required this.id,
      required this.competitionActivityId,
      required this.memberId,
      required this.memberName,
      required this.memberImg,
      required this.bookerId,
      required this.bookerName});

  factory MemberTakesActivityModel.fromJson(Map<String, dynamic> json) {
    int id = json['id'] ?? 0;
    int competitionActivityId = json['competition_activity_id'] ?? 0;
    int memberId = json['member_id'] ?? 0;
    String memberName = json['member_name'] ?? '';
    String memberImg = json['member_img'] ?? '';
    int bookerId = json['booker_id'] ?? 0;
    String bookerName = json['booker_name'] ?? '';

    return MemberTakesActivityModel(
        id: id,
        competitionActivityId: competitionActivityId,
        memberId: memberId,
        memberName: memberName,
        memberImg: memberImg,
        bookerId: bookerId,
        bookerName: bookerName);
  }
}
