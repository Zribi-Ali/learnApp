import 'package:flutter/material.dart';
import 'package:learn/view/sign_up_page.dart';
import 'package:provider/provider.dart';

import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';
import '../translation_utilities/languages_manager.dart';
import 'log_in.dart';

class WelcomeBackPage extends StatefulWidget {
  @override
  _WelcomeBackPageState createState() => _WelcomeBackPageState();
}

class _WelcomeBackPageState extends State<WelcomeBackPage> {
  bool _isHidden = true;

  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  final _formKey = GlobalKey<FormState>();

  final TextEditingController usernameController = TextEditingController();

  //TextEditingController(text: "4");
  final TextEditingController passwordController = TextEditingController();

  // TextEditingController(text: "1234");

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
        padding: EdgeInsets.only(top: 20.0, right: 20.0, left: 20.0, bottom: 0),
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
              newAccount(context),
              SizedBox(
                height: 25.0,
              ),
              logInButton(),
              SizedBox(
                height: 25.0,
              ),
              getPrivacypolicy(),
              SizedBox(
                height: 25.0,
              ),
              getTerms(),
              SizedBox(
                height: 25.0,
              ),
              AboutUS(),
              SizedBox(
                height: 50.0,
              ),
              Text("CopyRight 2022 - masdarTraining"
                  //+ AppLocalizations.of(context)!.masdarTraining;
                  )
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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
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

  Widget getPrivacypolicy() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          height: 56.0,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(23.0), color: Colors.amber),
          child: MaterialButton(
            onPressed: () {
              print("OnPressed PrivacyPolicy ");
              launchURL("https://learn-sa.net/index.php?ln=en&p=privacypolicy");
            },
            child: Text(
              "Privacy Policy", // AppLocalizations.of(context)!.privacyPolicy,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
          )),
    );
  }

  Widget getTerms() {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Link(
          uri: Uri.parse(
              "https://learn-sa.net/index.php?ln=en&p=termsAndConditions"),
          builder: ((context, followLink) => Container(
              height: 56.0,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(23.0),
                  color: Colors.amber),
              child: MaterialButton(
                onPressed: () {
                  print("OnPressed Terms ");
                  launchURL(
                      "https://learn-sa.net/index.php?ln=en&p=termsAndConditions");
                },
                child: Text(
                  "Terms And Conditions", //AppLocalizations.of(context)!.termsAndConditions,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
              ))),
        ));
  }

  Future<void> launchURL(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
  }

  Widget AboutUS() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          height: 56.0,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(23.0), color: Colors.amber),
          child: MaterialButton(
            onPressed: () {
              print("OnPressed PrivacyPolicy ");
              launchURL("https://learn-sa.net/index.php?ln=en&p=about");
            },
            child: Text(
              "About US", //AppLocalizations.of(context)!.aboutUS,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
          )),
    );
  }
}
