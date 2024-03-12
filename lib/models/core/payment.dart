

class Payment {
  Payment({
    this.idPay = 0,
    required this.idUser,
    required this.mydate,
    required this.amount,
    required this.verified,
    required this.idCourse,
  });

  int idPay;
  int idUser;
  DateTime mydate;
  int amount;
  int verified;
  int idCourse;

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
    idPay: json["id_pay"],
    idUser: json["id_user"],
    mydate: DateTime.parse(json["mydate"]),
    amount: json["amount"],
    verified: json["verified"],
    idCourse: json["id_course"],
  );

  Map<String, dynamic> toJson() => {
    "id_pay": idPay,
    "id_user": idUser,
    "mydate": mydate.toIso8601String(),
    "amount": amount,
    "verified": verified,
    "id_course": idCourse,
  };
}
