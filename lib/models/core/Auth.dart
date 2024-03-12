class Auth {
  Auth({
    required this.id,
    required this.fullname,
    required this.email,
    required this.ps,
    required this.idRole,
    required this.img,
    required this.tel,
    required this.permissions,
    required this.idCity,
    this.idClass = 1,
    this.idLang = 0,
    required this.myDate,
    this.actif

  });

  int id;
  String fullname;
  String email;
  String ps;
  int idRole;
  String img;
  String tel;
  int permissions;
  int idCity;
  int idClass;
  int idLang = 0;
  DateTime myDate;
  dynamic actif;

  factory Auth.fromJson(Map<String, dynamic> json) {
    return Auth(
      id: json["id"],
      fullname: json["fullname"],
      email: json["email"],
      ps: json["ps"],
      idRole: json["id_role"],
      img: json["img"] ??= "",
      tel: json["tel"] ??= "",
      permissions: json["permissions"],
      idCity: json["id_city"],
      idClass: json["id_class"] ?? 0,
      idLang: json["id_lang"] ?? 0,
      myDate: DateTime.parse(json["myDate"] ??= "20220731"),
      actif: json["actif"],
    );
  }

  factory Auth.fromJsonDiscussion(Map<String, dynamic> json) {
    return Auth(
      id: json["id"],
      fullname: json["fullname"],
      email: json["email"],
      ps: json["ps"],
      idRole: json["id_role"],
      img: json["img"] ??= "",
      tel: json["tel"] ??= "",
      permissions: json["permissions"],
      idCity: json["id_city"],
      idClass: json["id_class"],
      idLang: json["id_lang"]?? 0,
      myDate: DateTime.parse(json["myDate1"] ??= "20220731"),
      actif: json["actif"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "fullname": fullname,
    "email": email,
    "ps": ps,
    "id_role": idRole,
    "img": img,
    "tel": tel,
    "permissions": permissions,
    "id_city": idCity,
    "id_class": idClass,
    "id_lang": idLang,
    "myDate": myDate.toIso8601String(),
    "actif": actif,
  };

  @override
  String toString() {
    return "$id\n$fullname\n$email\n$ps\n$idCity";
  }

  update(String fullName, String password, String email, int? id) {
    print("inside update");
    if (fullname.isNotEmpty && fullname != "") {
      print("inside fullname not empty $fullname");
      setFullName(fullName);
    }
    if (password.isNotEmpty) {
      print("inside password not empty $password");
      setPassword(password);
    }
    if (email.isNotEmpty) {
      print("inside email  not empty $email");
      setEmail(email);
    }
    if (id != null) {
      print("new id $id");
      setidCit(id);
    }
  }

  void setPhoneNumber(String text) => tel = text;

  void setFullName(String text) {
    if (text.isNotEmpty) {
      fullname = text;
    }
  }

  void setidCit(int id) => idCity = id;

  void setEmail(String text) => email = text;

  void setPassword(String text) => ps = text;
}
