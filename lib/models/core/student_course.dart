class StudentCourse {
  StudentCourse({
    this.idSc = 0,
    required this.idStudent,
    required this.idCourse,
    required this.mydate,
    required this.status,
    required this.active,
  });

  int idSc;
  int idStudent;
  int idCourse;
  DateTime mydate;
  dynamic status;
  dynamic active;

  factory StudentCourse.fromJson(Map<String, dynamic> json) {
    DateTime date = DateTime.now();
    if (json["myDate"] != null) {
      date = DateTime.parse(json["mydate"]);
    }

    return StudentCourse(
      idSc: json["id_SC"],
      idStudent: json["id_student"],
      idCourse: json["id_course"],
      mydate: date,
      status: json["status"],
      active: json["active"],
    );
  }
  Map<String, dynamic> toJson() => {
        "id_SC": idSc,
        "id_student": idStudent,
        "id_course": idCourse,
        "mydate": mydate.toIso8601String(),
        "status": status,
        "active": active,
      };
}
