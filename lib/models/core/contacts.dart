
class Contacts {
  Contacts({
    required this.idContact,
    required this.email,
    required this.subject,
    required this.subjectDesc,
    required this.idUser,
    required this.myDate

  });

  int idContact;
  String email;
  String subject;
  String subjectDesc;
  int idUser;
  String myDate;


  factory Contacts.fromJson(Map<String, dynamic> json) => Contacts(
    idContact: json["id_contact"],
    email: json["email"],
    subject: json["subject"],
    subjectDesc: json["subject_desc"],
    idUser: json["id_user"],
    myDate: json["mydate"]

  );

  Map<String, dynamic> toJson() => {
    "id_contact": idContact,
    "email": email,
    "subject": subject,
    "subject_desc": subjectDesc,
    "id_user": idUser,
    "mydate": myDate

  };
}
