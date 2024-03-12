class Discussion {
  Discussion({
    required this.idDiscussion,
    required this.myDate,
    required this.idUser1,
    required this.idCourses,
    required this.idUser2,
  });

  int idDiscussion;
  DateTime myDate;
  int idUser1;
  dynamic idCourses;
  int idUser2;

  factory Discussion.fromJson(Map<String, dynamic> json) => Discussion(
        idDiscussion: json["id_discussion"],
        myDate: DateTime.parse(json["myDate"]??="20220731") ,
        idUser1: json["id_user_1"],
        idCourses: json["id_Courses"],
        idUser2: json["id_user_2"],
      );

  Map<String, dynamic> toJson() => {
        "id_discussion": idDiscussion,
        "myDate": myDate.toIso8601String(),
        "id_user_1": idUser1,
        "id_Courses": idCourses,
        "id_user_2": idUser2,
      };
}
