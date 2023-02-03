class SeedsWalletModel{
  int id;
  int studentId;
  double amount;
  bool status;

  SeedsWalletModel({
    required this.id,
    required this.studentId,
    required this.amount,
    required this.status
  });

  factory SeedsWalletModel.fromJson(Map<String, dynamic> json){
    int id = json['id'] ?? 0;
    int studentId = json['student_id'] ?? 0;
    double amount = json['amount'].toDouble();
    bool status = json['status'] ?? false;

    return SeedsWalletModel(
      id: id, 
      studentId: studentId, 
      amount: amount, 
      status: status
    );
  }
}