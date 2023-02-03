import 'package:intl/intl.dart';
import 'package:unicec_mobi/models/enums/member_status.dart';

class ClubModel {
  int id;
  int universityId;
  String universityName;
  String name;
  String description;
  String? image;
  String? clubFanpage;
  String? clubContact;
  int totalEvent;
  int totalActivity;
  int totalMember;
  int memberIncreaseThisMonth;
  DateTime founding;
  bool status;
  //đánh dấu show UI
  MemberStatus isMemberStatus;

  ClubModel(
      {required this.id,
      required this.universityId,
      required this.universityName,
      required this.name,
      required this.description,
      required this.image,
      required this.clubContact,
      required this.clubFanpage,
      required this.totalEvent,
      required this.totalActivity,
      required this.totalMember,
      required this.memberIncreaseThisMonth,
      required this.founding,
      required this.status,
      required this.isMemberStatus});

  factory ClubModel.fromJson(Map<String, dynamic> json) {
    int id = json['id'];
    int universityId = json['university_id'];
    String universityName = json['university_name'];
    String name = json['name'];
    String description = json['description'];
    String? image = json['image'];
    String? clubContact = json['club_contact'];
    String? clubFanpage = json['club_fanpage'];
    int totalEvent = json['total_event'];
    int totalActivity = json['total_activity'];
    int totalMember = json['total_member'];
    int memberIncreaseThisMonth = json['member_increase_this_month'];
    //
    String foundingString = json['founding'];
    foundingString = foundingString.replaceAll("T", " ");
    foundingString = foundingString.replaceAll("Z", "");
    DateTime founding = DateFormat("yyyy-MM-dd HH:mm:ss").parse(foundingString);
    //
    bool status = json['status'];

    return ClubModel(
        id: id,
        universityId: universityId,
        universityName: universityName,
        name: name,
        description: description,
        image: image,
        clubContact: clubContact,
        clubFanpage: clubFanpage,
        totalEvent: totalEvent,
        totalActivity: totalActivity,
        totalMember: totalMember,
        memberIncreaseThisMonth: memberIncreaseThisMonth,
        founding: founding,
        status: status,
        isMemberStatus: MemberStatus.Student);
  }
}
