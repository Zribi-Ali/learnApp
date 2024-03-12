import 'package:cool_alert/cool_alert.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/core/review.dart';
import '../provider/lesson_provider.dart';
import '../provider/review_provider.dart';
import '../provider/stream_provider.dart';
import '../provider/unit_provider.dart';
import '../provider/user_provider.dart';
import 'custom_used_widgets/bottom_navigation_bar.dart.dart';

class Rating extends StatefulWidget {
  const Rating({Key? key}) : super(key: key);

  @override
  _RatingState createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController reviewController = TextEditingController();
  double reviewValue = 0;

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: Text(
            AppLocalizations.of(context)!.addReview,
            style: TextStyle(
                color: Colors.white, fontSize: 25, fontWeight: FontWeight.w300),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              SizedBox(
                height: 26,
              ),
              chooseReviewNumber(context),
              SizedBox(
                height: 20,
              ),
              reviewForm(context),
              SizedBox(
                height: 80,
              ),
              addReviewButton()
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBarApp(
          currentIndex: 0,
        ));
  }

  Form reviewForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: TextFormField(
        textInputAction: TextInputAction.done,
        controller: reviewController,
        maxLines: 4,
        decoration: InputDecoration(
          hintText: AppLocalizations.of(context)!.reviews,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
        ),
        style: TextStyle(
          fontFamily: "Poppins",
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return AppLocalizations.of(context)!.addReviewError;
          }

          return null;
        },
        onSaved: (value) => reviewController.text = value!,
      ),
    );
  }

  Row chooseReviewNumber(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          AppLocalizations.of(context)!.chooseRating,
          style: TextStyle(
              color: Colors.black54, fontSize: 19, fontWeight: FontWeight.w600),
        ),
        RatingBar(
            itemSize: 30,
            initialRating: reviewValue,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            ratingWidget: RatingWidget(
                full: const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                half: const Icon(
                  Icons.star_half,
                  color: Colors.amber,
                ),
                empty: const Icon(
                  Icons.star_outline,
                  color: Colors.amber,
                )),
            onRatingUpdate: (double value) {
              setState(() => reviewValue = value);
              print(reviewValue);
            }),
      ],
    );
  }

  Widget addReviewButton() {
    return SizedBox(
        height: 56.0,
        width: MediaQuery.of(context).size.width / 1.2,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          )),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              addReview();
            }
          },
          child: Text(
            AppLocalizations.of(context)!.addReview,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
          ),
        ));
  }

  void addReview() async {
    String addReviewMessage = AppLocalizations.of(context)!.failedSignUp;

    Review newReview = Review(
        idUser: Provider.of<UserProvider>(context, listen: false).user.id,
        valueReview: reviewValue.toInt(),
        textReview: reviewController.text,
        idLesson: Provider.of<LessonProvider>(context, listen: false)
                    .currentIdLesson ==
                null
            ? 1
            : Provider.of<LessonProvider>(context, listen: false)
                .currentIdLesson!,
        myDate: DateTime.now(),
        idStream: Provider.of<AppStreamProvider>(context, listen: false)
                    .onClickStream ==
                null
            ? 0
            : Provider.of<AppStreamProvider>(context, listen: false)
                .onClickStream!
                .idStream,
        idCourse: Provider.of<UnitProvider>(context, listen: false).idCourse);
    var result = await Provider.of<ReviewProvider>(context, listen: false)
        .postNewReview(newReview);

    if (result) {
      addReviewMessage = AppLocalizations.of(context)!.addReviewSuccess;
    }

    reviewController.text = "";
    setState(() => reviewValue = 0);
    CoolAlert.show(
        context: context,
        type: CoolAlertType.success,
        title: addReviewMessage,
        loopAnimation: true,
        confirmBtnText: AppLocalizations.of(context)!.cancel,
        confirmBtnColor: Theme.of(context).colorScheme.primary,
        backgroundColor: Colors.grey.shade50,
        onConfirmBtnTap: () => Navigator.pop(context));
  }
}
