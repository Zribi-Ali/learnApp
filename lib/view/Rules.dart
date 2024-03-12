import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:testing/view/welcome.dart';

class Rules extends StatefulWidget {
  const Rules({Key? key}) : super(key: key);

  @override
  _RulesState createState() => _RulesState();
}

class _RulesState extends State<Rules> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Center(
          child: Text(
            AppLocalizations.of(context)!.terms,
            style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.w400
            ),
          ),
        ),
      )
        ,body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Text(
                  terms,
                textAlign: TextAlign.justify,
                textDirection: TextDirection.ltr,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w400
                  )
                ),
                Text(
                    privacy,
                    textAlign: TextAlign.justify,
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w400
                )
                ),
              ],
            ),
          )
    )
    );
  }
}
