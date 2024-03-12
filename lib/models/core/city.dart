
class City {
  int idCity;
  String cityNameEn;
  String cityNameAr;
  dynamic country;
  dynamic active;
  City({
    required this.idCity,
    required this.cityNameEn,
    required this.cityNameAr,
    required this.country,
    required this.active,
  });



  factory City.fromJson(Map<String, dynamic> json) => City(
        idCity: json["id_city"],
        cityNameEn: json["city_name_en"],
        cityNameAr: json["city_name_ar"],
        country: json["country"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "id_city": idCity,
        "city_name_en": cityNameEn,
        "city_name_ar": cityNameAr,
        "country": country,
        "active": active,
      };
}
