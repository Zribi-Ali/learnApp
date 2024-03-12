class Event {
  Event({
    required this.idEvent,
    required this.title,
    required this.description,
    required this.adress,
    required this.dateTimeEvent,
    required this.img,
    required this.idUser,
  });

  int idEvent;
  String title;
  String description;
  String adress;
  DateTime dateTimeEvent;
  String img;
  int idUser;

  factory Event.fromJson(Map<String, dynamic> json) => Event(
        idEvent: json["id_event"],
        title: json["title"],
        description: json["description"],
        adress: json["adress"],
        dateTimeEvent: DateTime.parse(json["DateTime_event"]),
        img: json["img"],
        idUser: json["id_user"],
      );

  Map<String, dynamic> toJson() => {
        "id_event": idEvent,
        "title": title,
        "description": description,
        "adress": adress,
        "DateTime_event": dateTimeEvent.toIso8601String(),
        "img": img,
        "id_user": idUser,
      };
}
