import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testing/provider/auth_provider.dart';
import 'package:testing/view/recover_password/recover_password_part_1.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:testing/view/recover_password/recover_password_part_3.dart';

class Recovery2 extends StatefulWidget {
  const Recovery2({Key? key, required this.email}) : super(key: key);
  final String email;

  @override
  _Recovery2State createState() => _Recovery2State();
}

class _Recovery2State extends State<Recovery2> {
  String? customPin;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          AppLocalizations.of(context)!.recoverPassword,
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.w400),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding:
            EdgeInsets.only(top: 20.0, right: 30.0, left: 30.0, bottom: 10.0),
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            Image(
              image: AssetImage("assets/images/check_sign.jpg"),
            ),
            SizedBox(
              height: 30.0,
            ),
            Text(
              AppLocalizations.of(context)!.forgetPasswordMessage1,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 19.0, color: Colors.black),
            ),
            SizedBox(
              height: 25.0,
            ),
            Directionality(
              textDirection: TextDirection.ltr,
              child: OTPTextField(
                onChanged: (String? pin) {
                  if (pin?.length == 6) {
                    setState(() {
                      customPin = pin;
                    });
                  }
                },
                length: 6,
                width: MediaQuery.of(context).size.width,
                fieldWidth: 40,
                style: TextStyle(
                  fontSize: 17.0,
                ),
                textFieldAlignment: MainAxisAlignment.spaceAround,
                fieldStyle: FieldStyle.underline,
                otpFieldStyle: OtpFieldStyle(
                    focusBorderColor: Theme.of(context).colorScheme.primary),
              ),
            ),
            SizedBox(
              height: 25.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppLocalizations.of(context)!.codeMessage1,
                  style: TextStyle(color: Colors.black, fontSize: 19.0),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Recovery()));
                    },
                    child: Text(
                      AppLocalizations.of(context)!.resend,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ))
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            SizedBox(
              height: 20.0,
            ),
            buildButtonContainer2(context, customPin)
          ],
        ),
      ),
    );
  }

  Widget buildButtonContainer2(BuildContext context, String? pin) {
    return Container(
        height: 56.0,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(23.0), color: Colors.amber),
        child: MaterialButton(
          onPressed: () {
            if (pin != null && pin.isNotEmpty) {
              verifConfirmation(pin, context);
            }
          },
          child: Text(
            AppLocalizations.of(context)!.verify,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            ),
          ),
        ));
  }

  void verifConfirmation(String pin, BuildContext context) async {
    print("email is ${widget.email} and code is $pin");
    bool? result = await Provider.of<AuthProvider>(context,listen: false)
        .verifConfirmation(widget.email, pin);
    if (result != null && result) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Recovery3(email: widget.email, pin: pin)));
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
}
