class Message {
  Message({
 this.idMsg,
    required this.msg,
    required this.mydate,
    required this.idDiscussion,
    required this.idUserSender,
    required this.idUserReciver,
     this.vue =0,
     this.isSent = true
  });

  int? idMsg;
  String msg;
  String mydate;
  int idDiscussion;
  int idUserSender;
  int idUserReciver;
  int vue;

  // used for ui
  bool isSent ;
  
  factory Message.fromJson(Map<String, dynamic> json) => Message(
        idMsg: json["id_msg"],
        msg: json["msg"],
        mydate: json["mydate"],
        idDiscussion: json["id_discussion"],
        idUserSender: json["id_user_sender"],
        idUserReciver: json["id_user_reciver"],
        vue: json["vue"],
      );

  Map<String, dynamic> toJson() => {
        "id_msg": idMsg??0,
        "msg": msg,
        "date": mydate,
        "id_discussion": idDiscussion,
        "id_user_sender": idUserSender,
        "id_user_reciver": idUserReciver,
        "vue": vue,
      };
}
