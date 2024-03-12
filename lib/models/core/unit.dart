class Unit {
  Unit({
    required this.idUnite,
    required this.idCourse,
    required this.titleUnite,
    required this.descUnits,
    required this.img,
  });

  int idUnite;
  int idCourse;
  String titleUnite;
  String descUnits;
  String img;

  factory Unit.fromJson(Map<String, dynamic> json) => Unit(
        idUnite: json["id_unite"],
        idCourse: json["id_course"],
        titleUnite: json["title_unite"],
        descUnits: json["desc_units"],
        img: json["img"],
      );

  Map<String, dynamic> toJson() => {
        "id_unite": idUnite,
        "id_course": idCourse,
        "title_unite": titleUnite,
        "desc_units": descUnits,
        "img": img,
      };
}
