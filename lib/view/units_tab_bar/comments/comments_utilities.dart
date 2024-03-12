import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:provider/provider.dart';
import 'package:testing/models/core/comment.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:testing/models/core/stream.dart';
import 'package:testing/provider/stream_provider.dart';

import '../../../models/services/DataTime_service.dart';
import '../../../provider/comment_provider.dart';
import '../../../provider/lesson_provider.dart';
import '../../../provider/user_provider.dart';

enum CommentTypeEnum {
  main,
  parent,
  child,
}

class CommentUtilities {
  static Future postCommentDialogue(BuildContext context, int idCommentParent) {
    TextEditingController commentController = TextEditingController();

    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(
                "ارسل لنا تعليقك",
                style: GoogleFonts.abel(color: Colors.amber, fontSize: 20),
              ),
              content: TextField(
                controller: commentController,
                maxLines: 4,
                autofocus: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.black87, width: 2.0),
                  ),
                  hintStyle: GoogleFonts.abel(),
                ),
                onSubmitted: (value) => commentController.text = value,
              ),
              actions: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 3,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(),
                      autofocus: true,
                      onPressed: () {
                        if (commentController.text.isNotEmpty) {
                          CommentUtilities.postComment(
                              commentController.text, context, idCommentParent);
                        }
                      },
                      child: Text(
                        AppLocalizations.of(context)!.send,
                        style:
                            GoogleFonts.abel(color: Colors.white, fontSize: 18),
                      )),
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width / 3,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black87,
                        ),
                        autofocus: true,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          AppLocalizations.of(context)!.cancel,
                          style: GoogleFonts.abel(
                              color: Colors.white, fontSize: 18),
                        )))
              ],
            ));
  }

  static Padding addCommentButton(
      {required BuildContext context, int? idParent}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(
        height: 45,
        width: MediaQuery.of(context).size.width / 1.5,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          )),
          onPressed: () =>
              CommentUtilities.postCommentDialogue(context, idParent ?? 0),
          child: Text(
            AppLocalizations.of(context)!.addComment,
            style: TextStyle(
              fontSize: 18.0,
            ),
          ),
        ),
      ),
    );
  }

  static void postComment(
      String commentText, BuildContext context, int idCommentParent) async {
    Comment newComment = Comment(
        comment: commentText,
        fullname:
            Provider.of<UserProvider>(context, listen: false).user.fullname,
        idUser: Provider.of<UserProvider>(context, listen: false).user.id,
        idLesson: Provider.of<LessonProvider>(context).currentIdLesson!,
        idStream: Provider.of<AppStreamProvider>(context, listen: false)
                    .onClickStream ==
                null
            ? 0
            : Provider.of<AppStreamProvider>(context, listen: false)
                .onClickStream!
                .idStream,
        idCommentParent: idCommentParent,
        myDate: simplyFormat(time: DateTime.now()),
        vue: 0);
    var result = await Provider.of<CommentProvider>(context, listen: false)
        .postComment(newComment);

    if (!result) {
      Fluttertoast.showToast(
          msg: AppLocalizations.of(context)!.failedSignUp,
          backgroundColor: Colors.grey[50],
          textColor: Colors.black,
          fontSize: 16);
    } else {
      Provider.of<CommentProvider>(context, listen: false)
          .addLocally(newComment);
    }
    Navigator.of(context).pop();
  }
}
