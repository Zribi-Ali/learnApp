class CourseForShowMore {
  CourseForShowMore(
      {required this.idCourse,
      required this.titleCourse,
      required this.typeCourse,
      required this.title,
      required this.teacherName,
      required this.description,
      required this.img,
      required this.idClass});

  int idCourse;
  String titleCourse;
  int typeCourse;
  String title;
  String teacherName;
  String description;
  String img;

  int idClass;

  factory CourseForShowMore.fromJson(Map<String, dynamic> json) =>
      CourseForShowMore(
        idCourse: json["id_course"],
        titleCourse: json["title_course"],
        typeCourse: json["typeCourse"],
        title: json["title"],
        teacherName: json["fullname"],
        description: json["Description"],
        img: json["img"],
        idClass: json["id_class"],
      );

  Map<String, dynamic> toJson() => {
        "id_course": idCourse,
        "title_course": titleCourse,
        "typeCourse": typeCourse,
        "title": title,
        "fullname": teacherName,
        "Description": description,
        "img": img,
        "id_class": idClass,
      };
}
