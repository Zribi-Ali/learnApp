import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:testing/view/learn_questions.dart';

class Questions extends StatefulWidget {
  const Questions({Key? key}) : super(key: key);

  @override
  _QuestionsState createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text(
            AppLocalizations.of(context)!.askedQuestions,
            style: TextStyle(
                color: Colors.white, fontSize: 25, fontWeight: FontWeight.w400),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: ListView(
              children: LearnQuestions.getQuestionsAndAnswers.entries
                  .map((e) => buildcard(answer: e.value, question: e.key))
                  .toList()),
        ));
  }

  Widget buildcard({required String answer, required String question}) =>
      Padding(
        padding: EdgeInsets.all(12),
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: ExpandablePanel(
            header: Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Text(
                question,
                style: GoogleFonts.cairo(
                  fontSize: 20,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            collapsed: Text(""),
            expanded: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Text(answer),
            ),
          ),
        ),
      );
}
