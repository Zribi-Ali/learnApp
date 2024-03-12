import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learn/models/core/comment.dart';

import 'package:provider/provider.dart';

import '../../../assets_url.dart';
import '../../../models/app_utilities.dart';
import '../../../models/core/user.dart';
import '../../../provider/comment_provider.dart';
import '../../../provider/user_provider.dart';
import 'comments_utilities.dart';

// in comment utilities there exist an enumeration class enumirating three types of comments
// comment item takes one of said types to modify its ui accordingly

class CommentItem extends StatelessWidget {
  final Comment comment;
  final CommentTypeEnum type;
  const CommentItem({Key? key, required this.comment, required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: getCommentColor(context),
          border: Border.all(width: 0.5, color: Colors.black12)),
      child: ListTile(
        contentPadding: EdgeInsets.only(top: 5, left: 10, right: 10),
        title: Row(
          children: [
            comment.img == null || comment.img!.isEmpty || comment.img! == "no"
                ? CircleAvatar(
                    backgroundImage: NetworkImage(
                      "https://static.stayjapan.com/assets/user_no_photo-4896a2d64d70a002deec3046d0b6ea6e7f01628781493566c95a02361524af97.png",
                    ),
                    radius: 30,
                  )
                : CircleAvatar(
                    backgroundImage:
                        NetworkImage(AssetsUrl.users + comment.img!),
                    radius: 30,
                  ),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.5),
                  child: Text(
                    comment.fullname == null ? "Not found" : comment.fullname!,
                    style: GoogleFonts.fahkwang(fontSize: 18),
                  ),
                ),
                Text(
                  "---------",
                  style: TextStyle(
                    color: Colors.black45,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3.0),
              child: Text(
                comment.myDate,
                style: TextStyle(color: Colors.black45, fontSize: 16),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 12,
            )
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 10.0, left: 8, right: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  AppUtilities.convert(comment.comment),
                  style: GoogleFonts.fahkwang(fontSize: 16),
                ),
              ),
              if (type == CommentTypeEnum.main)
                TextButton(
                  onPressed: () {
                    onPressedMain(context);
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.reply,
                        color: Colors.yellowAccent[700],
                        size: 25,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        AppLocalizations.of(context)!.viewReplies,
                        style: GoogleFonts.podkova(
                            color: Colors.yellowAccent[700], fontSize: 19),
                      ),
                    ],
                  ),
                )
              else
                SizedBox(
                  height: 10,
                )
            ],
          ),
        ),
      ),
    );
  }

  User? getUser(BuildContext context) {
    try {
      User user = Provider.of<UserProvider>(context)
          .users
          .firstWhere((element) => element.id == comment.idUser);
      return user;
    } catch (e) {
      return null;
    }
  }

  getCommentColor(BuildContext context) {
    switch (type) {
      case CommentTypeEnum.main:
        return null;
      case CommentTypeEnum.child:
        return null;
      case CommentTypeEnum.parent:
        return Theme.of(context).colorScheme.primary.withOpacity(0.1);
      default:
        null;
    }
  }

  void onPressedMain(BuildContext context) {
    Provider.of<CommentProvider>(context, listen: false)
        .setCurrentCommentParent(comment);
    Provider.of<CommentProvider>(context, listen: false)
        .setIsParentState(false);
  }
}
