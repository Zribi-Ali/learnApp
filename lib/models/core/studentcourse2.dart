class StudentCourse2 {
  StudentCourse2({
    required this.idSC,
    required this.idStudent,
    required this.idCourse,
    required this.mydate,
    required this.status,
    required this.active,
    required this.idCourse1,
    required this.title_course,
    required this.description,
    required this.typeCourse,
    required this.idProf,
    required this.idClass,
    required this.idLang,
    required this.img
  });

  int idSC;
  int idStudent;
  int idCourse;
  DateTime mydate;
  dynamic status;
  dynamic active;
  int idCourse1;
  String title_course;
  String description;
  int   typeCourse;
  int idProf;
  int idClass;
  int idLang;
  String img;

  factory StudentCourse2.fromJson(Map<String, dynamic> json) {
    DateTime date = DateTime.now();
    if (json["myDate"] != null) {
      date = DateTime.parse(json["mydate"]);
    }

    return StudentCourse2(
      idSC: json["id_SC"],
      idStudent: json["id_student"],
      idCourse: json["id_course"],
      mydate: date,
      status: json["status"],
      active: json["active"],
      idCourse1: json["idCourse1"],
      title_course: json["title_course"],
      description: json["description"],
      typeCourse: json["typeCourse"],
      idProf: json["idProf"],
      idClass: json["idClass"],
      idLang: json["idLang"],
      img: json["img"],

    );
  }
  Map<String, dynamic> toJson() => {
        "id_SC": idSC,
        "id_student": idStudent,
        "id_course": idCourse,
        "mydate": mydate.toIso8601String(),
        "status": status,
        "active": active,
      };
}
