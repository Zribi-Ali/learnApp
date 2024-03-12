

class Language {
    Language({
        required this.idLang,
        required this.title,
        required this.description,
        required this.img,
    });

    int idLang;
    String title;
    String description;
    String img;

    

    factory Language.fromJson(Map<String, dynamic> json) => Language(
        idLang: json["id_Lang"],
        title: json["title"],
        description: json["description"],
        img: json["img"],
    );

    Map<String, dynamic> toJson() => {
        "id_Lang": idLang,
        "title": title,
        "description": description,
        "img": img,
    };
}
