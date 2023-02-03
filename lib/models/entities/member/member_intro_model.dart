class MemberIntroModel{
  int id;
  String name;
  int clubRoleId;
  String clubRoleName;
  String avatar;
  bool isOnline;

  MemberIntroModel({
    required this.id,
    required this.name,
    required this.clubRoleId,
    required this.clubRoleName,
    required this.avatar,
    required this.isOnline
  });

  factory MemberIntroModel.fromJson(Map<String, dynamic> json){
    int id = json['id'];
    String name = json['name'];
    int clubRoleId = json['club_role_id'];
    String clubRoleName = json['club_role_name'];
    String avatar = json['avatar'];
    bool isOnline = json['is_online'];

    return MemberIntroModel(
      id: id, 
      name: name, 
      clubRoleId: clubRoleId, 
      clubRoleName: clubRoleName, 
      avatar: avatar, 
      isOnline: isOnline
    );
  }
}