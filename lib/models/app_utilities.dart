class AppUtilities {
  static String convert(String text) {
    text = text.replaceAll("#@1", "'");
    text = text.replaceAll("#@3", ",");
    text = text.replaceAll("#@4", ".");
    text = text.replaceAll("#@5", "+");
    text = text.replaceAll("#@6", "-");
    text = text.replaceAll("#@7", "=");
    text = text.replaceAll("#@8", "(");
    text = text.replaceAll("#@9", ")");
    return text;
  }

  static String phoneNumber = "13469728465";
  static String adminEmail = "admin@gmail.com";
  static int maximumPageNumber = 2;

  static String creptCardInfo(String cardInfo) {
    return cardInfo;
  }

  static String decreptCardInfo(String cardInfo) {
    return cardInfo;
  }
}
