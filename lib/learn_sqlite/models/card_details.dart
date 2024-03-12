class CardDetails {
  CardDetails({
    this.idCardDetails,
    required this.cardNumber,
    required this.cardVerificationValue,
    required this.expirationDate,
    required this.nameOnCard,
    required this.userId,
  });

  int? idCardDetails;
  String? cardNumber;
  int? cardVerificationValue;
  String? expirationDate;
  String? nameOnCard;
  int? userId;

  CardDetails.isEmpty();

  factory CardDetails.fromJson(Map<String, dynamic> json) => CardDetails(
    idCardDetails: json["id_card_details"],
    cardNumber: json["card_number"],
    cardVerificationValue: json["card_verification_value"],
    expirationDate: json["expiration_date"],
    nameOnCard: json["name_on_card"],
    userId: json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "id_card_details": idCardDetails,
    "card_number": cardNumber,
    "card_verification_value": cardVerificationValue,
    "expiration_date": expirationDate,
    "name_on_card": nameOnCard,
    "user_id": userId,
  };
}
