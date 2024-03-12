class StudentStream {
  StudentStream({
    this.idSS = 0,
    required this.idStudent,
    required this.idStream,
    required this.mydate,
  });

  int idSS;
  int idStudent;
  int idStream;
  DateTime mydate;

  factory StudentStream.fromJson(Map<String, dynamic> json) => StudentStream(
        idSS: json["id_SS"],
        idStudent: json["id_student"],
        idStream: json["id_stream"],
        mydate: DateTime.parse(json["mydate"]),
      );

  Map<String, dynamic> toJson() => {
        "id_SS": idSS,
        "id_student": idStudent,
        "id_stream": idStream,
        "mydate": mydate.toIso8601String(),
      };
}
