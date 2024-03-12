import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:testing/view/log_in.dart';

import '../provider/auth_provider.dart';

class ConfirmMail extends StatelessWidget {
  const ConfirmMail({Key? key, required this.email}) : super(key: key);
  final String assetPath = "assets/images/";
  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding:
            EdgeInsets.only(top: 20.0, right: 20.0, left: 20.0, bottom: 10.0),
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
              "سوف يصلك كود التفعيل على الايميل يرجى تفعيل الحساب",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 28.0, color: Colors.black),
            ),
            SizedBox(
              height: 160.0,
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                "لم يصلني الكود بعد",
                style: TextStyle(color: Colors.black, fontSize: 20.0),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            buildButtonContainer(context),
          ],
        ),
      ),
    );
  }

  // after the user is verified via the code that was previously sent they are to be redirected
  // to the log in page and are considered a verified user

  void verifConfirmation(String pin, BuildContext context) async {
    print("email is ${email} and code is $pin");
    bool? result = await Provider.of<AuthProvider>(context, listen: false)
        .verifConfirmation(email, pin);
    if (result != null && result) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    } else {
      print("my result inside the ui is $result");
      buildShowDialog(context);
    }
  }

  void buildShowDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text(AppLocalizations.of(context)!.verification,
                  textAlign: TextAlign.center),
              content: Text(
                AppLocalizations.of(context)!.incorrectPin,
                style: TextStyle(fontSize: 19),
                textAlign: TextAlign.center,
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(AppLocalizations.of(context)!.cancel,
                        style: TextStyle(fontSize: 19)))
              ],
            ));
  }

  Widget buildButtonContainer(BuildContext context) {
    return Container(
        height: 56.0,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(23.0), color: Colors.amber),
        child: MaterialButton(
          onPressed: () {
            verifConfirmation('pin', context);
          },
          child: Text(
            "اعادة ارسال الكود",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            ),
          ),
        ));
  }
}
