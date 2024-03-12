
class AppNotification {
    AppNotification({
        required this.idNotifications,
        required this.idUser,
        required this.titleNotif,
        required this.descriptionNotif,
        required this.dateNotif,
        required this.typeNotif,
        required this.vue,
    });

    int idNotifications;
    int idUser;
    String titleNotif;
    String descriptionNotif;
    DateTime dateNotif;
    String typeNotif;
    int vue;

    factory AppNotification.fromJson(Map<String, dynamic> json) => AppNotification(
        idNotifications: json["id_notifications"],
        idUser: json["id_user"],
        titleNotif: json["title_notif"],
        descriptionNotif: json["description_notif"],
        dateNotif: DateTime.parse(json["date_notif"]),
        typeNotif: json["type_notif"],
        vue: json["vue"],
    );

    Map<String, dynamic> toJson() => {
        "id_notifications": idNotifications,
        "id_user": idUser,
        "title_notif": titleNotif,
        "description_notif": descriptionNotif,
        "date_notif": dateNotif.toIso8601String(),
        "type_notif": typeNotif,
        "vue": vue,
    };
}
