class UniSelectorModel {
  final String token;
  final List<UniBelongToEmail> listUniBelongToEmail;

  UniSelectorModel({required this.token, required this.listUniBelongToEmail});

  factory UniSelectorModel.fromJson(Map<String, dynamic> json) {
    String token = json['token'];
    List<UniBelongToEmail> listUniBelongToEmail = [];
    if (json['listUniBelongToEmail'] != null) {
      listUniBelongToEmail = <UniBelongToEmail>[];
      json['listUniBelongToEmail'].forEach((v) {
        listUniBelongToEmail.add(new UniBelongToEmail.fromJson(v));
      });
    }

    return UniSelectorModel(
        token: token, listUniBelongToEmail: listUniBelongToEmail);
  }
}

class UniBelongToEmail {
  final int id;
  final int cityId;
  final String uniCode;
  final String name;
  final String email;
  final String description;
  final String phone;
  final String? imgUrl;
  final String founding;
  final String opening;
  final String closing;
  final bool status;

  UniBelongToEmail(
      {required this.id,
      required this.cityId,
      required this.uniCode,
      required this.name,
      required this.email,
      required this.description,
      required this.phone,
      this.imgUrl,
      required this.founding,
      required this.opening,
      required this.closing,
      required this.status});

  factory UniBelongToEmail.fromJson(Map<String, dynamic> json) {
    int id = json['id'];
    int cityId = json['city_id'];
    String uniCode = json['uni_code'];
    String name = json['name'];
    String email = json['email'];
    String description = json['description'];
    String phone = json['phone'];
    String? imgUrl = json['imgURL'];
    String founding = json['founding'];
    String opening = json['opening'];
    String closing = json['closing'];
    bool status = json['status'];

    return UniBelongToEmail(
        id: id,
        cityId: cityId,
        uniCode: uniCode,
        name: name,
        email: email,
        description: description,
        phone: phone,
        imgUrl: imgUrl,
        founding: founding,
        opening: opening,
        closing: closing,
        status: status);
  }
}
