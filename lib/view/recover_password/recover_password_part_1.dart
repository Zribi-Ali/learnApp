import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:testing/provider/auth_provider.dart';
import 'package:testing/view/recover_password/recover_password_part_2.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:testing/view/theme_helper/text_field_helper.dart';

class Recovery extends StatefulWidget {
  const Recovery({Key? key}) : super(key: key);

  @override
  _RecoveryState createState() => _RecoveryState();
}

class _RecoveryState extends State<Recovery> {
  final TextEditingController emailController = TextEditingController(text : "sami@gmail.com");
  final _formKey = GlobalKey<FormState>();

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
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: ListView(
            children: [
              const SizedBox(
                height: 60,
              ),
              Text(
                AppLocalizations.of(context)!.forgetPasswordMessage,
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 25,
              ),
              TextFormField(
                  autofocus: false,
                  controller: emailController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return AppLocalizations.of(context)!.emailError1;
                    }
                    // reg expression for email validation
                    if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                        .hasMatch(value)) {
                      return AppLocalizations.of(context)!.emailError2;
                    }
                    return null;
                  },
                  onSaved: (value) => emailController.text = value!,
                  textInputAction: TextInputAction.done,
                  decoration: TextFieldHelper.getInputDecoration(
                      AppLocalizations.of(context)!.email, Icons.email, false)),
              const SizedBox(
                height: 60,
              ),
              buildButton(AppLocalizations.of(context)!.recoverPassword)
            ],
          ),
        ),
      ),
    );
  }

  Widget buildButton(String text) => Container(
      height: 56.0,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: Theme.of(context).colorScheme.primary),
      child: MaterialButton(
        onPressed: () {
          resendConfirmation();
        },
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          ),
        ),
      ));

  resendConfirmation() async {
    if (_formKey.currentState!.validate()) {
      bool? result = await Provider.of<AuthProvider>(context,listen: false)
          .resendConfirmation(emailController.text);
      if (result != null && result) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => Recovery2(
                      email: emailController.text,
                    )));
      } else {
        Fluttertoast.showToast(
            timeInSecForIosWeb: 3,
            msg: AppLocalizations.of(context)!.failedOperation,
            backgroundColor: Theme.of(context).colorScheme.primary,
            fontSize: 16);
      }
    }
  }
}
