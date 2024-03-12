import 'package:flutter/material.dart';
import 'package:learn/translation_utilities/languages_manager.dart';
import 'package:learn/view/sign_up_page.dart';
import 'package:provider/provider.dart';

import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';
import 'log_in.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
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
              showDialog(
                context: context,
                builder: (BuildContext context) =>
                    _buildPopupDialog(context, privacy),
              );
              //launchURL("https://learn-sa.net/index.php?ln=en&p=privacypolicy");
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
                  //launchURL("https://learn-sa.net/index.php?ln=en&p=termsAndConditions");
                  showDialog(
                    context: context,
                    builder: (BuildContext context) =>
                        _buildPopupDialog(context, terms),
                  );
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

  Widget _buildPopupDialog(BuildContext context, content) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: Text(content,
            maxLines: 100,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.justify,
            textDirection: TextDirection.ltr,
            style: TextStyle(fontSize: 13.0)),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Close'),
        ),
      ],
    );
  }
}

String privacy = "Privacy Policy : \n" +
    "\nYour use of the services provided by the Learn platform:" +
    "\nAccess to the Services is permitted on a temporary basis, and we reserve the right to withdraw or modify the service we provide on the Services without prior notice.  We are not responsible for the unavailability of the Services for any reason, at any time and for any period." +
    "\n\n•You are solely responsible for any participation from you on our services in the form of a written explanation on the explanation board or by speaking into the microphone in direct communication between you and the students." +
    "\n" +
    "\n• You are solely responsible for any written conversation between you and the students and you acknowledge that you expose yourself to legal accountability if it contains anything that violates the rules and public morals." +
    "\n" +
    "\nYou acknowledge that the services provided by learn are intended to provide home assistance to students and you expressly agree to comply with the societal principles and morals and learn reserves the right to suspend your account if you do not comply with these principles at any time and without notice." +
    "\n\nYour right to use learn is personal to you and you are not permitted to grant this right to anyone else to use your account under your name or on your behalf." +
    "\n\n•You warrant that your participation in learn does not prejudice any rights of third parties or restrict or prohibit their use or enjoyment of the Services." +
    "\n\nYou warrant that your use of the Platform's services does not cause harm, annoyance, or harassment of others, whether personally or in public written or audio posts, and that it does not contain any offensive or offensive material or impede the normal course of learning within the Platform." +
    "\n\nYou acknowledge that you refrain from and do not encourage any other person to provide or provide any content or to do any act that includes the following:" +
    "\n\nUse of unacceptable or degrading language or language that poses a threat or use of a violent or intolerant manner of religion, race, gender, sexual orientation, origin, disability, or physical or mental condition." +
    "\n\nStir up any discussions that encourage, encourage or provide harmful information related to criminal or illegal practices including but not limited to (pornography - explosives - weapons - violence - drugs - viruses - piracy - copyright infringement)." +
    "\n\nPutting other website addresses that may include any of what was mentioned in the previous paragraph." +
    "\n\nBreach of any legal duty of third party or incitement to breach the law." +
    "\n\nExchanging personal phone numbers or home addresses, trading personal social media accounts, or agreeing to hold external meetings." +
    "\n\nImpersonating our employees, public figures, or famous people's names or personalities." +
    "\n\nPutting a profile picture on your own account on the learn platform violates public morals." +
    "\n\nProviding false or misleading information." +
    "\n\nDoing any actions that degrade or degrade our value or the value of others or our products or services." +
    "\n\nPosting any content that causes direct or indirect harm to us or any of the users of our services." +
    "\n\nYou are responsible for the confidentiality of your learn account details and for any activities that occur under your account.  If you have concerns that your account is being used by someone else, you should contact us through the Educator Support Service." +
    "\n\nWe, in our sole discretion, determine whether there has been a breach of the above clause when you use the Services.  In the event of any breach of this provision, we will take such action as we deem appropriate, including:" +
    "\n\nImmediate, temporary or permanent withdrawal of your right to use our services." +
    "\n\n- Alert you. Take legal measures against you to compensate us for all costs on the basis of compensation due to the breach." +
    "\n\nDisclosing such necessary information to law enforcement authorities as we deem necessary." +
    "\nWe can take any other measures we deem reasonably appropriate.\n";

String terms = "\n\nTerms and Conditions : " +
    "\nYour use of the services provided by the Learn platform:";
