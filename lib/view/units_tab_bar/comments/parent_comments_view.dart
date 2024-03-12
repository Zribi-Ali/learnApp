import 'package:flutter/material.dart';
import 'package:learn/view/units_tab_bar/comments/comment_item.dart';
import 'package:provider/provider.dart';

import '../../../provider/comment_provider.dart';
import 'comments_utilities.dart';

class CommentsView extends StatefulWidget {
  const CommentsView({Key? key}) : super(key: key);

  @override
  _CommentsState createState() => _CommentsState();
}

class _CommentsState extends State<CommentsView> {
  @override
  void initState() {
    Provider.of<CommentProvider>(context, listen: false).initializeComments();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Provider.of<CommentProvider>(context).isParent
          ? ParentCommentView()
          : ChildCommentView(
              parentComment:
                  Provider.of<CommentProvider>(context).currentCommentParent!),
    );
  }
}

class ParentCommentView extends StatelessWidget {
  const ParentCommentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider.of<CommentProvider>(context).loading
        ? Center(
            child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primary),
          )
        : Column(
            children: [
              Expanded(
                child: Provider.of<CommentProvider>(context)
                        .getCommentsByParentId()
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
                            type: CommentTypeEnum.main,
                            comment: Provider.of<CommentProvider>(context)
                                .getCommentsByParentId()[index]),
                        itemCount: Provider.of<CommentProvider>(context)
                            .getCommentsByParentId()
                            .length),
              ),
              CommentUtilities.addCommentButton(context: context)
            ],
          );
  }
}
