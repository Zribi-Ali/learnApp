// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:testing/provider/courses_provider.dart';

import 'courses_manipulation/courses_view.dart';
import 'education.dart';

class MethodLearning extends StatelessWidget {
  final idLanguage;

  const MethodLearning({Key? key, required this.idLanguage}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
        padding: const EdgeInsets.all(18.0),
        child: ListView(
          shrinkWrap: true,
          children: [
            SizedBox(
              height: 30,
            ),
            Text(
              AppLocalizations.of(context)!.methodLearningFavorite,
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            goSystematic(context),
            SizedBox(
              height: 30,
            ),
            goIndependent(context),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }

  Container goIndependent(BuildContext context) {
    return Container(
        height: 70.0,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0), color: Colors.grey[100]),
        child: MaterialButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 0,
          highlightColor: Theme.of(context).colorScheme.primary,
          onPressed: () {
            Provider.of<CoursesProvider>(context,listen: false).setIdClass(null);
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => CoursesView()));
          },
          child: Text(
            AppLocalizations.of(context)!.method2,
            style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.normal),
          ),
        ));
  }

  Container goSystematic(BuildContext context) {
    return Container(
        height: 70.0,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0), color: Colors.grey[100]),
        child: MaterialButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => Education()));
          },
          child: Text(
            AppLocalizations.of(context)!.method1,
            style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.normal),
          ),
        ));
  }
}
