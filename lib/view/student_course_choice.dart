import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:testing/view/live/live_now.dart';
import 'package:testing/view/units_via_student_course.dart';
import 'custom_used_widgets/bottom_navigation_bar.dart.dart';

class Choice extends StatefulWidget {
  final int currentIndex;
  Choice({required this.currentIndex, Key? key}) : super(key: key);

  @override
  _ChoiceState createState() => _ChoiceState();
}

class _ChoiceState extends State<Choice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text(
            AppLocalizations.of(context)!.methodLearning,
            style: TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.w400),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(18.0, 30, 18.0, 18.0),
          child: ListView(shrinkWrap: true, children: [
            recordedImage(context),
            const SizedBox(
              height: 15,
            ),
            recordedButton1(context),
            const SizedBox(
              height: 20,
            ),
            recordedButton2(context),
            SizedBox(
              height: 50,
            ),
            liveImage(context),
            const SizedBox(
              height: 15,
            ),
            liveButton1(context),
            const SizedBox(
              height: 20,
            ),
            liveButton2(context),
          ]),
        ),
        bottomNavigationBar: BottomNavigationBarApp(
          currentIndex: widget.currentIndex,
        ));
  }

  Container liveButton2(BuildContext context) {
    return Container(
      height: 50.0,
      width: MediaQuery.of(context).size.width,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
            side: BorderSide(color: Theme.of(context).colorScheme.primary),
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(16.0))),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => LiveNow()));
        },
        child: Text(
          AppLocalizations.of(context)!.liveLearningMessage,
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.w300),
        ),
      ),
    );
  }

  Container liveButton1(BuildContext context) {
    return Container(
        height: 50.0,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0), color: Colors.amber),
        child: MaterialButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => LiveNow()));
          },
          child: Text(
            AppLocalizations.of(context)!.liveLearning,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            ),
          ),
        ));
  }

  InkWell liveImage(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => LiveNow()));
      },
      child: Container(
        height: 180.0,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          image: DecorationImage(
            image: NetworkImage(
                "https://media.istockphoto.com/photos/schoolgirl-studying-with-video-online-lesson-at-home-picture-id1285962627?k=20&m=1285962627&s=612x612&w=0&h=vngcgQ9XA813PEgbuoPd5AO7mXvMxJwEXwcv28wwTFI="),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  Container recordedButton2(BuildContext context) {
    return Container(
      height: 50.0,
      width: MediaQuery.of(context).size.width,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
            side: BorderSide(color: Theme.of(context).colorScheme.primary),
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(16.0))),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => UnitsScreen()));
        },
        child: Text(
          AppLocalizations.of(context)!.recordedLessonsMessage,
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.w300),
        ),
      ),
    );
  }

  Container recordedButton1(BuildContext context) {
    return Container(
        height: 50.0,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0), color: Colors.amber),
        child: MaterialButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => UnitsScreen()));
          },
          child: Text(
            // AppLocalizations.of(context)!.recordedLessons,
            AppLocalizations.of(context)!.recordedCouses,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            ),
          ),
        ));
  }

  InkWell recordedImage(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => UnitsScreen()));
      },
      child: Container(
        height: 180.0,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          image: DecorationImage(
            image: NetworkImage("https://i.imgur.com/sdKzPkd.jpg"),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
