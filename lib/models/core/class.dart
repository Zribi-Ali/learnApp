

class Class {
    Class({
        required this.idClass,
        required this.titleClass,
    });

    int idClass;
    String titleClass;

    

    factory Class.fromJson(Map<String, dynamic> json) => Class(
        idClass: json["id_class"],
        titleClass: json["title_class"],
    );

    Map<String, dynamic> toJson() => {
        "id_class": idClass,
        "title_class": titleClass,
    };
}
