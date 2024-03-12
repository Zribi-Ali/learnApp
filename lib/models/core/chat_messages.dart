class ChatMessage {
  final String message;
  final bool isSender;
  ChatMessage({
    required this.message,
    required this.isSender,
  });
  static List messages = [
    ChatMessage(message: "اهلا كيف حالك", isSender: false),
    ChatMessage(message: "أنا بخير ، كيف حالك", isSender: true),
    ChatMessage(
        message: "لقد تحدثت معك بالفعل لأسألك عن الحفلة القادمة",
        isSender: false),
    ChatMessage(message: "لم أكن أعلم أنك دُعيت أيضًا", isSender: true),
    ChatMessage(
        message: "كان في آخر لحظة ، كانوا بحاجة إلى شخص ما للموسيقى",
        isSender: false),
    ChatMessage(message: "أنا سعيد لأنك ستكون هناك", isSender: true),
    ChatMessage(message: "هل تريد الذهاب معا", isSender: false),
    ChatMessage(
        message: "نعم ، هل يمكنك اصطحابي حوالي الساعة السابعة", isSender: true),
    ChatMessage(message: "سأكون هناك", isSender: false),
    ChatMessage(message: "مرحبًا ، لقد فقد بعض أصدقائي رحلتهم إلى الحفلة ، وكنت أتساءل عما إذا كان بإمكانك وضعنا جميعًا في سيارتك ، سأكون ممتنًا للغاية", isSender: true)
  ];
}