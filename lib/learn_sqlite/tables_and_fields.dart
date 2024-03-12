class Tables {
  static const String userPreference = "User_Preference";
  static const String cardDetails = "card_details";
}

class CardDetailsFields {
  static const String id = "id_card_details";
  static const String userId = "user_id";
  static const String cardNumber = "card_number";
  static const String cvv = "card_verification_value";
  static const String expirationDate = "expiration_date";
  static const String nameOnCard = "name_on_card";
}

class FieldTypes {
  // AT : Auto incrementation
  static const String idTypeAT = "INTEGER PRIMARY KEY AUTOINCREMENT";

  static const String idType = "INTEGER PRIMARY KEY";

  static const String boolType = "BOOLEAN NOT NULL";

  static const String integerType = "INTEGER NOT NULL";

  static const String doubleType = "DOUBLE NOT NULL";

  static const String textType = "TEXT";

  static const String charType = "char(255) NOT NULL ";
}

// class UserPreferenceFields {
//   static const String id = "id_user_preference";
//   static const String appLanguage = "app_language";
// }
