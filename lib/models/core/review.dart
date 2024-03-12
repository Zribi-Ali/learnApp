class Review {
  Review({
     this.idReview = 1,
    required this.idUser,
    required this.valueReview,
    required this.textReview,
    required this.myDate,
    this.idLesson,
    required this.idStream ,
    required this.idCourse,
     this.active =0,
     // this.activeValue= 0,
  });

  int? idReview;
  int idUser;
  int valueReview;
  String? textReview;
  DateTime myDate;
  int? idLesson;
  int? idStream;
  int? idCourse;
  // bool? isActive;
  // int activeValue;
  int active ;

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        idReview: json["id_review"],
        idUser: json["id_user"],
        valueReview: json["value_review"],
        textReview: json["text_review"],
        myDate: DateTime.parse(json["myDate"]),
        idLesson: json["id_lesson"],
        idStream: json["id_stream"],
        idCourse: json["id_course"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "id_review": idReview,
        "id_user": idUser,
        "value_review": valueReview,
        "text_review": textReview,
        "myDate": myDate.toIso8601String(),
        "id_lesson": idLesson,
        "id_stream": idStream,
        "id_course": idCourse,
        "active": active,
      };
}
