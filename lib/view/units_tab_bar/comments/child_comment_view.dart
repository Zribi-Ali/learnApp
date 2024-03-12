import 'package:flutter/material.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:testing/view/units_tab_bar/comments/comment_item.dart';
import 'package:testing/view/units_tab_bar/comments/comments_utilities.dart';

import '../../../models/core/comment.dart';
import '../../../provider/comment_provider.dart';

class ChildCommentView extends StatelessWidget {
  final Comment parentComment;

  const ChildCommentView({Key? key, required this.parentComment})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      goBackWidget(context),
      CommentItem(
        type: CommentTypeEnum.parent,
        comment: parentComment,
      ),
      Expanded(
        child: Provider.of<CommentProvider>(context)
                .getCommentsByParentId(idParent: parentComment.idComment)
                .isEmpty
            ? Center(
                child: Text(
                  AppLocalizations.of(context)!.noComments,
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
              )
            : ListView.builder(
                itemBuilder: (context, index) => CommentItem(
                    type: CommentTypeEnum.child,
                    comment: Provider.of<CommentProvider>(context)
                        .getCommentsByParentId(
                            idParent: parentComment.idComment)[index]),
                itemCount: Provider.of<CommentProvider>(context)
                    .getCommentsByParentId(idParent: parentComment.idComment)
                    .length),
      ),
      CommentUtilities.addCommentButton(
          context: context, idParent: parentComment.idComment)
    ]));
  }

  Container goBackWidget(BuildContext context) {
    return Container(
      color: Colors.grey.shade50,
      child: InkWell(
        onTap: () => Provider.of<CommentProvider>(context, listen: false)
            .setIsParentState(true),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)!.back,
                style: GoogleFonts.podkova(
                    color: Colors.yellowAccent[700], fontSize: 22),
              ),
              Icon(
                // Icons.arrow_left_sharp,
                Icons.arrow_right_sharp,
                size: 35,
                color: Colors.yellowAccent[700],
              )
            ],
          ),
        ),
      ),
    );
  }
}
