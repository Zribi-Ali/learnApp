import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'log_in.dart';

class DeleteUserSuccess extends StatelessWidget {
  const DeleteUserSuccess({Key? key}) : super(key: key);
  final String assetPath = "assets/images/";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Image.asset(assetPath + "logo.jpg"),
            SizedBox(
              height: 10.0,
            ),
            Image.asset(assetPath + "check_sign.jpg"),
            SizedBox(
              height: 10.0,
            ),
            Text(
              AppLocalizations.of(context)!.accountDeleted,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 28.0, color: Colors.black),
            ),
            SizedBox(
              height: 160.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: buildButtonContainer(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildButtonContainer(BuildContext context) {
    return Container(
        height: 56.0,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(23.0), color: Colors.amber),
        child: MaterialButton(
          onPressed: () => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => LoginPage())),
          child: Text(
            AppLocalizations.of(context)!.logIn,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            ),
          ),
        ));
  }
}
