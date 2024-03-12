import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:testing/provider/class_provider.dart';
import 'package:testing/provider/courses_provider.dart';
import 'package:testing/view/courses_manipulation/courses_view.dart';

import '../models/core/class.dart';

class Education extends StatefulWidget {
  const Education({Key? key}) : super(key: key);

  @override
  _EducationState createState() => _EducationState();
}

class _EducationState extends State<Education> {
  @override
  void initState() {
    super.initState();
    // if listen is true the widget would want to rebuild
    // before its done initializating
    Provider.of<ClassProvider>(context, listen: false).get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          AppLocalizations.of(context)!.coursesAvailable,
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
              AppLocalizations.of(context)!.chooseClass,
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
              ),
              // textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 30,
            ),
            if (Provider.of<ClassProvider>(context).loading)
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height / 4),
                child: Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              )
            else
              for (Class item in Provider.of<ClassProvider>(context).classes)
                classWidget(currentClass: item),
          ],
        ),
      ),
    );
  }
}

class classWidget extends StatelessWidget {
  const classWidget({
    Key? key,
    required this.currentClass,
  }) : super(key: key);

  final Class currentClass;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: 70.0,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                color: Colors.grey[100]),
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              onPressed: () {
                Provider.of<CoursesProvider>(context, listen: false)
                    .setIdClass(currentClass.idClass);
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => CoursesView()));
              },
              child: Text(
                currentClass.titleClass,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.normal),
              ),
            )),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
