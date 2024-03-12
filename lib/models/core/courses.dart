
class Course {
  Course({
    required this.idCourse,
    required this.titleCourse,
    required this.description,
    required this.typeCourse,
    required this.idProf,
    required this.idClass,
    required this.idLang,
    required this.img,
  });

  int idCourse;
  String titleCourse;
  String description;
  int typeCourse;
  int idProf;
  int idClass;
  int idLang;
  String img;

  factory Course.fromJson(Map<String, dynamic> json) => Course(
        idCourse: json["id_course"],
        titleCourse: json["title_course"],
        description: json["description"],
        typeCourse: json["typeCourse"],
        idProf: json["id_prof"],
        idClass: json["id_class"],
        idLang: json["id_Lang"],
        img: json["img"],
      );

  Map<String, dynamic> toJson() => {
        "id_course": idCourse,
        "title_course": titleCourse,
        "description": description,
        "typeCourse": typeCourse,
        "id_prof": idProf,
        "id_class": idClass,
        "id_Lang": idLang,
        "img": img,
      };
}
