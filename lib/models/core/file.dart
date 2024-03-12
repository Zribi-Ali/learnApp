class File {
  File({
    required this.idFile,
    required this.titleFile,
    required this.dateFile,
    required this.idStream,
    required this.idLesson,
    required this.pathFile,
  });

  int idFile;
  String titleFile;
  DateTime dateFile;
  int idStream;
  int idLesson;
  String pathFile;

  factory File.fromJson(Map<String, dynamic> json) => File(
        idFile: json["id_file"],
        titleFile: json["title_file"],
        dateFile: DateTime.parse(json["date_file"]),
        idStream: json["id_stream"],
        idLesson: json["id_lesson"],
        pathFile: json["path_file"],
      );

  Map<String, dynamic> toJson() => {
        "id_file": idFile,
        "title_file": titleFile,
        "date_file": dateFile.toIso8601String(),
        "id_stream": idStream,
        "id_lesson": idLesson,
        "path_file": pathFile,
      };
}
