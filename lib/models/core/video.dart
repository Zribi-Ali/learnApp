class Video {
  Video({
    required this.idVideo,
    required this.name,
    required this.idLesson,
  });

  int idVideo;
  String name;
  int idLesson;

  factory Video.fromJson(Map<String, dynamic> json) => Video(
        idVideo: json["id_video"],
        name: json["name"],
        idLesson: json["id_lesson"],
      );

  Map<String, dynamic> toJson() => {
        "id_video": idVideo,
        "name": name,
        "id_lesson": idLesson,
      };
}
