import '../services/DataTime_service.dart';

class Comment {
  Comment(
      {this.idComment,
      required this.comment,
      required this.idUser,
      required this.idLesson,
      required this.idStream,
      required this.idCommentParent,
      required this.myDate,
      required this.vue,
      this.fullname,
      this.img});

  int? idComment;
  String comment;
  int idUser;
  int idLesson;
  int idStream;
  int idCommentParent;
  String myDate;
  dynamic vue;
  String? fullname;
  String? img;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        idComment: json["id_comment"],
        comment: json["comment"],
        idUser: json["id_user"],
        idLesson: json["id_lesson"],
        idStream: json["id_stream"],
        idCommentParent: json["id_comment_parent"],
        myDate: json["myDate"],
        vue: json["vue"],
        fullname: json["fullname"],
        img: json["img"],
      );

  Map<String, dynamic> toJson() => {
        "id_comment": idComment,
        "comment": comment,
        "id_user": idUser,
        "id_lesson": idLesson,
        "id_stream": idStream,
        "id_comment_parent": idCommentParent,
        "myDate": simplyFormat(time: DateTime.now()),
        "vue": vue,
        "fullname": fullname,
        "img": img,
      };
}
