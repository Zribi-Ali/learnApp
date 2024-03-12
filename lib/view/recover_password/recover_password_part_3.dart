import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:testing/view/log_in.dart';
import 'package:testing/view/theme_helper/text_field_helper.dart';

import '../../provider/auth_provider.dart';

class Recovery3 extends StatefulWidget {
  const Recovery3({Key? key, required this.email, required this.pin})
      : super(key: key);
  final String pin;
  final String email;

  @override
  State<Recovery3> createState() => _Recovery3State();
}

class _Recovery3State extends State<Recovery3> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
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
            children: <Widget>[
              const SizedBox(
                height: 30,
              ),
              Text(
                AppLocalizations.of(context)!.changePasswordMessage,
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 25,
              ),
              TextFormField(
                  autofocus: false,
                  textInputAction: TextInputAction.done,
                  controller: passwordController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return AppLocalizations.of(context)!.passwordError;
                    }
                    return null;
                  },
                  onSaved: (value) => passwordController.text = value!,
                  decoration: TextFieldHelper.getInputDecoration(
                      AppLocalizations.of(context)!.password,
                      Icons.lock,
                      false)),
              const SizedBox(
                height: 25,
              ),
              TextFormField(
                autofocus: false,
                controller: confirmPasswordController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return AppLocalizations.of(context)!.passwordError;
                  }
                  if (passwordController.text.isNotEmpty &&
                      passwordController.text != value) {
                    return AppLocalizations.of(context)!.confirmPasswordError;
                  }
                  return null;
                },
                onSaved: (value) => confirmPasswordController.text = value!,
                decoration: TextFieldHelper.getInputDecoration(
                    AppLocalizations.of(context)!.confirmPassword,
                    Icons.lock,
                    false),
              ),
              const SizedBox(
                height: 60,
              ),
              buildButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildButton(
    BuildContext context,
  ) {
    return Container(
        height: 56.0,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(23.0), color: Colors.amber),
        child: MaterialButton(
          onPressed: () => changePassword(),
          child: Text(
            AppLocalizations.of(context)!.done,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            ),
          ),
        ));
  }

  changePassword() async {
    if (_formKey.currentState!.validate()) {
      bool? result = await Provider.of<AuthProvider>(context, listen: false)
          .changePass(passwordController.text, widget.email, widget.pin);
      if (result != null && result) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      }
    } else {
      Fluttertoast.showToast(
          timeInSecForIosWeb: 3,
          msg: AppLocalizations.of(context)!.failedOperation,
          backgroundColor: Theme.of(context).colorScheme.primary,
          fontSize: 16);
    }
  }
}
