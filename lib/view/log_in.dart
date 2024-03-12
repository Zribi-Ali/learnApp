import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testing/provider/user_provider.dart';
import 'package:testing/translation_utilities/languages_manager.dart';
import 'package:testing/view/all_lessons.dart';
import 'package:testing/view/recover_password/recover_password_part_1.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:testing/view/sign_up_page.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../models/core/user.dart';
import '../provider/city_provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isHidden = true;

  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  final _formKey = GlobalKey<FormState>();

  final TextEditingController usernameController =
      //TextEditingController();
      TextEditingController(text: "medsamiformation@gmail.com");
  final TextEditingController passwordController =
      //TextEditingController();
      TextEditingController(text: "1234");

  bool isArabic = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding:
            EdgeInsets.only(top: 20.0, right: 20.0, left: 20.0, bottom: 20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                    onPressed: () {
                      changeLanguage();
                    },
                    child: Text(isArabic ? "AR" : "En")),
              ),
              SizedBox(
                height: 15.0,
              ),
              Image(
                image: AssetImage("assets/images/logo.jpg"),
              ),
              SizedBox(
                height: 25.0,
              ),
              Text(
                AppLocalizations.of(context)!.logIn,
                style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 40.0,
              ),
              getUserNameTextField(),
              SizedBox(
                height: 20.0,
              ),
              getPasswordTextField(),
              SizedBox(
                height: 20.0,
              ),
              forgetPassword(context),
              SizedBox(height: 20.0),
              logInButton(),
              SizedBox(
                height: 10.0,
              ),
              newAccount(context),
            ],
          ),
        ),
      ),
    );
  }

  Container newAccount(BuildContext context) {
    return Container(
      child: TextButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SignUpPage()));
        },
        child: Text(
          AppLocalizations.of(context)!.newAccount,
          style: TextStyle(color: Colors.black, fontSize: 20.0),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Container forgetPassword(BuildContext context) {
    return Container(
      child: TextButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Recovery()));
          },
          child: Text(
            AppLocalizations.of(context)!.forgetPassword,
            style: TextStyle(color: Colors.black, fontSize: 20.0),
          )),
    );
  }

  TextFormField getPasswordTextField() {
    return TextFormField(
      obscureText: _isHidden,
      autofocus: false,
      controller: passwordController,
      validator: (value) {
        if (value!.isEmpty) {
          return AppLocalizations.of(context)!.passwordError;
        }

        return null;
      },
      onSaved: (value) => passwordController.text = value!,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          hintText: AppLocalizations.of(context)!.password,
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16.0,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          prefixIcon: Icon(Icons.lock),
          suffixIcon: IconButton(
            onPressed: _toggleVisibility,
            icon:
                _isHidden ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
          )),
    );
  }

  TextFormField getUserNameTextField() {
    return TextFormField(
        autofocus: false,
        controller: usernameController,
        validator: (value) {
          if (value!.isEmpty) {
            return AppLocalizations.of(context)!.userNameErrorMessage;
          }

          return null;
        },
        onSaved: (value) => usernameController.text = value!,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            hintText: AppLocalizations.of(context)!.userName,
            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: 16.0,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            prefixIcon: Icon(Icons.perm_identity)));
  }

  Widget logInButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          height: 56.0,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(23.0), color: Colors.amber),
          child: MaterialButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                logIn(usernameController.text, passwordController.text);
              }
            },
            child: Text(
              AppLocalizations.of(context)!.logIn,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
          )),
    );
  }

  void logIn(String username, String password) async {
    print("log in start");
    bool result = await Provider.of<UserProvider>(context, listen: false)
        .initializeUserData(password, username, context);
    if (result) {
      if (mounted) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => AllLessons()));
      }
    } else {
      Fluttertoast.showToast(
          timeInSecForIosWeb: 3,
          msg: AppLocalizations.of(context)!.noUser,
          backgroundColor: Theme.of(context).colorScheme.primary,
          fontSize: 16);
    }
  }

  void changeLanguage() {
    if (isArabic) {
      Provider.of<LocaleProvider>(context, listen: false)
          .setLocale(Languages.codes[0]);
      setState(() {
        isArabic = false;
      });
    } else {
      Provider.of<LocaleProvider>(context, listen: false)
          .setLocale(Languages.codes[1]);
      setState(() {
        isArabic = true;
      });
    }
  }
}
