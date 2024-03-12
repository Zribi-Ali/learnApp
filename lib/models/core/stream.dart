

class AppStream {
    AppStream({
        required this.idStream,
        required this.titleStream,
        required this.descStream,
        required this.datetimeStream,
        required this.linkStream,
        required this.idCourse,
        required this.idProf,
    });

    int idStream;
    String titleStream;
    String descStream;
    DateTime datetimeStream;
    String linkStream;
    int idCourse;
    int idProf;

   

    factory AppStream.fromJson(Map<String, dynamic> json) => AppStream(
        idStream: json["id_stream"],
        titleStream: json["title_stream"],
        descStream: json["desc_stream"],
        datetimeStream: DateTime.parse(json["datetime_stream"]),
        linkStream: json["link_stream"],
        idCourse: json["id_course"],
        idProf: json["id_prof"],
    );

    Map<String, dynamic> toJson() => {
        "id_stream": idStream,
        "title_stream": titleStream,
        "desc_stream": descStream,
        "datetime_stream": datetimeStream.toIso8601String(),
        "link_stream": linkStream,
        "id_course": idCourse,
        "id_prof": idProf,
    };
}
