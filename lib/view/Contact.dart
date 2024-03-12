import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;
import '../models/core/contacts.dart';
import '../models/services/api_links.dart';
import '../provider/user_provider.dart';
import 'custom_used_widgets/bottom_navigation_bar.dart.dart';
import 'theme_helper/text_field_helper.dart';

class Contact extends StatefulWidget {
  final int bottomNavigationBarIndex;
  Contact({required this.bottomNavigationBarIndex, Key? key}) : super(key: key);

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController() => TextEditingController(
      text: Provider.of<UserProvider>(context, listen: false).user.email);
  TextEditingController subjectController = TextEditingController();
  TextEditingController subjectDescriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.writeUs,
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.w400),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
          child: ListView(
            shrinkWrap: true,
            children: [
              buildTextField(AppLocalizations.of(context)!.email, Icons.email,
                  emailController(), 1, validateEmail),
              buildTextField(AppLocalizations.of(context)!.subject,
                  Icons.subject_rounded, subjectController, 1, validateSubject),
              buildTextField(
                  AppLocalizations.of(context)!.subjectDescription,
                  null,
                  subjectDescriptionController,
                  5,
                  validateSubjectDescription),
              SizedBox(
                height: 15,
              ),
              Center(
                child: Text(
                  AppLocalizations.of(context)!.or,
                  style: TextStyle(
                      color: Colors.amber,
                      fontSize: 26,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              otherContacts(context),
              SizedBox(
                height: 30,
              ),
              buildButtonContainer(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBarApp(
        currentIndex: widget.bottomNavigationBarIndex,
      ),
    );
  }

  Row otherContacts(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton.icon(
          style: TextButton.styleFrom(
            textStyle: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w300,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.0),
            ),
          ),
          onPressed: () => {},
          icon: FaIcon(
            FontAwesomeIcons.phone,
            color: Colors.amber,
          ),
          label: Text(
            AppLocalizations.of(context)!.phone,
            style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.w300,
                fontSize: 18),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        TextButton.icon(
          style: TextButton.styleFrom(
            textStyle: TextStyle(color: Colors.blue),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.0),
            ),
          ),
          onPressed: () => {},
          icon: FaIcon(
            FontAwesomeIcons.whatsapp,
            color: Colors.green,
          ),
          label: Text(
            AppLocalizations.of(context)!.whatsApp,
            style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.w300,
                fontSize: 18),
          ),
        ),
      ],
    );
  }

  validateEmail(String? value) {
    if (value!.isEmpty) {
      return AppLocalizations.of(context)!.emailError1;
    } else if (!RegExp(
            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
        .hasMatch(value)) {
      return AppLocalizations.of(context)!.emailError2;
    }
    return null;
  }

  validateSubject(String? value) {
    if (value!.isEmpty) {
      return AppLocalizations.of(context)!.passwordError;
    }

    return null;
  }

  validateSubjectDescription(String? value) {
    return null;
  }

  Widget buildTextField(
      String hintText,
      IconData? icon,
      TextEditingController controller,
      int maxLines,
      validateTextFormField(String? value)) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
          maxLines: maxLines,
          controller: controller,
          validator: (value) => validateTextFormField(value),
          onSaved: (value) => controller.text = value!,
          decoration:
              TextFieldHelper.getInputDecoration(hintText, icon, false)),
    );
  }

  Widget buildButtonContainer() {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Container(
          height: 56.0,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(23.0), color: Colors.amber),
          child: MaterialButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                print(emailController().text);
                print(subjectController.text);
                print(subjectDescriptionController.text);
                int myID =
                    Provider.of<UserProvider>(context, listen: false).user.id;
                sendContact(emailController().text, subjectController.text,
                    subjectDescriptionController.text, myID);
              }
            },
            child: Text(
              AppLocalizations.of(context)!.send,
              style: TextStyle(
                color: Colors.white,
                fontSize: 21.0,
              ),
            ),
          )),
    );
  }
}

Future<Contacts> sendContact(
    String email, String subject, String subject_desc, int id) async {
  var req = jsonEncode(<String, dynamic>{
    'email': email,
    'subject': subject,
    'subject_desc': subject_desc,
    'id_user': id,
    'mydate': ""
  });
  final response = await http.post(Uri.parse(ApiLinks.contactUrl),
      body: req, headers: {'Authorization': ApiLinks.token});
  if (response.statusCode == 200) {
    Fluttertoast.showToast(
        msg: "Messages Sent",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
    print("Success send contact");
    return Contacts.fromJson(jsonDecode(response.body));
  } else {
    Fluttertoast.showToast(
        msg: "Messages Not send",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
    throw Exception('Failed to Send contact.' + response.body);
  }
}
