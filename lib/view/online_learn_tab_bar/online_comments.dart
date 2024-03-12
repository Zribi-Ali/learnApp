import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:testing/provider/stream_provider.dart';
import 'package:testing/view/rating.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:testing/view/units_tab_bar/comments/comments_utilities.dart';
import '../../assets_url.dart';
import '../../models/app_utilities.dart';
import '../../models/core/comment.dart';
import '../../models/core/user.dart';
import '../../provider/comment_provider.dart';
import '../../provider/review_provider.dart';
import '../../provider/user_provider.dart';

class Comments extends StatefulWidget {
  const Comments({Key? key}) : super(key: key);

  @override
  _CommentsState createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  @override
  void initState() {
    Provider.of<CommentProvider>(context, listen: false).initializeComments();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Provider.of<CommentProvider>(context).loading
          ? Center(
              child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.primary),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Provider.of<CommentProvider>(context)
                          .getByIdStream(
                              (Provider.of<AppStreamProvider>(context)
                                  .onClickStream!
                                  .idStream))
                          .isEmpty
                      ? Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical:
                                    MediaQuery.of(context).size.height / 4),
                            child: Text(
                              AppLocalizations.of(context)!.noComments,
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        )
                      : Column(
                          children: Provider.of<CommentProvider>(context)
                              .getByIdStream(
                                  Provider.of<AppStreamProvider>(context)
                                      .onClickStream!
                                      .idStream)
                              .map(
                                (e) => CommentIem(comment: e),
                              )
                              .toList(),
                        ),
                  const SizedBox(height: 50),
                  CommentUtilities.addCommentButton(context: context),
                  addReviewButton(),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
    );
  }

  Widget addReviewButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(
          height: 45.0,
          width: MediaQuery.of(context).size.width / 1.5,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            )),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Rating()));
            },
            child: Text(
              AppLocalizations.of(context)!.addReview,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
          )),
    );
  }
}

class CommentIem extends StatelessWidget {
  final Comment comment;

  const CommentIem({Key? key, required this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
      child: Card(
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          leading: getUser(context) == null || getUser(context)!.img.isEmpty
              ? CircleAvatar(
                  backgroundImage: NetworkImage(
                    "https://static.stayjapan.com/assets/user_no_photo-4896a2d64d70a002deec3046d0b6ea6e7f01628781493566c95a02361524af97.png",
                  ),
                  radius: 30,
                )
              : CircleAvatar(
                  backgroundImage: NetworkImage(AssetsUrl.users +
                      Provider.of<UserProvider>(context).user.img),
                  radius: 30,
                ),
          trailing: Text(
            comment.myDate,
            style: TextStyle(color: Colors.black45),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                getUser(context) == null
                    ? "Not found"
                    : getUser(context)!.fullname,
                textAlign: TextAlign.right,
              ),
              const SizedBox(
                height: 5,
              )
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppUtilities.convert(comment.comment),
                textAlign: TextAlign.right,
              ),
              Row(children: [
                for (var i = 0; i < getReviewValue(context); i++)
                  Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 15,
                  ),
              ])
            ],
          ),
        ),
      ),
    );
  }

  int getReviewValue(BuildContext context) {
    int reviewValue = 0;

    try {
      reviewValue = Provider.of<ReviewProvider>(context)
          .getReviewsByIdStream(
              Provider.of<AppStreamProvider>(context).onClickStream!.idStream)
          .firstWhere(
            (element) => element.idUser == getUser(context)!.id,
          )
          .valueReview;
    } catch (e) {
      print(e);
    } finally {
      return reviewValue;
    }
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
}
