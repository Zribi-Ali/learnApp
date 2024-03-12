class Lesson {
  Lesson({
    required this.idLesson,
    required this.titleLesson,
    required this.descLesson,
    required this.pathLesson,
    required this.dateLesson,
    required this.idCourse,
    required this.idUnite,
    required this.imgLesson,
  });

  int idLesson;
  String titleLesson;
  String descLesson;
  String pathLesson;
  DateTime dateLesson;
  int idCourse;
  int idUnite;
  String imgLesson;

  factory Lesson.fromJson(Map<String, dynamic> json) => Lesson(
        idLesson: json["id_lesson"],
        titleLesson: json["title_lesson"],
        descLesson: json["desc_lesson"],
        pathLesson: json["path_lesson"],
        dateLesson: DateTime.parse(json["date_lesson"]),
        idCourse: json["id_course"],
        idUnite: json["id_unite"],
        imgLesson: json["img_lesson"],
      );

  Map<String, dynamic> toJson() => {
        "id_lesson": idLesson,
        "title_lesson": titleLesson,
        "desc_lesson": descLesson,
        "path_lesson": pathLesson,
        "date_lesson": dateLesson.toIso8601String(),
        "id_course": idCourse,
        "id_unite": idUnite,
        "img_lesson": imgLesson,
      };
}
