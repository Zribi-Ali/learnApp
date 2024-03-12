import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:testing/provider/city_provider.dart';
import 'package:testing/provider/user_provider.dart';
import 'package:testing/translation_utilities/languages_manager.dart';
import 'package:testing/view/log_in.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:testing/view/recover_password/recover_password_part_2.dart';
import 'package:testing/view/theme_helper/text_field_helper.dart';
import 'package:testing/view/welcome.dart';
import '../models/core/user.dart';
import '../models/services/DataTime_service.dart';
import '../provider/auth_provider.dart';
import 'ConfirmMail.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController passwordC = TextEditingController();
  TextEditingController confirmpasswordC = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  bool _isHidden1 = true;

  String? _SelectedItem;

  int? idCity;

  void _toggleVisibility() {
    setState(() {
      _isHidden1 = !_isHidden1;
    });
  }

  @override
  void initState() {
    super.initState();
    Provider.of<CityProvider>(context, listen: false).initializeCities();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Image(
                image: AssetImage("assets/images/logo.jpg"),
              ),
              Center(
                child: Text(
                  AppLocalizations.of(context)!.newAccount,
                  style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
              usernameField(context),
              SizedBox(
                height: 20.0,
              ),
              emailField(context),
              SizedBox(
                height: 20.0,
              ),
              phoneNumberField(context),
              SizedBox(
                height: 20.0,
              ),
              whichCity(context),
              SizedBox(
                height: 20.0,
              ),
              passwordField(context),
              SizedBox(
                height: 20.0,
              ),
              confirmPasswordField(context),
              SizedBox(
                height: 20.0,
              ),
              conditionsField(context),
              SizedBox(
                height: 10.0,
              ),
              buildButtonContainer(),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                    child: Text(AppLocalizations.of(context)!.logIn),
                  ),
                  Text(AppLocalizations.of(context)!.alreadyUser),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  FormField<bool> conditionsField(BuildContext context) {
    return FormField(
      initialValue: false,
      builder: (state) {
        return Column(
          children: <Widget>[
            ListTile(
                title: Text(
                  AppLocalizations.of(context)!.agreeConditions,
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                leading: Checkbox(
                    activeColor: Colors.amber,
                    checkColor: Colors.white,
                    value: state.value,
                    onChanged: (value) => state.didChange(value)),
                trailing: TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            _buildPopupDialog(context, privacy, terms),
                      );
                    },
                    child: Text('Privacy Policy & Terms conditions',
                        style: TextStyle(fontSize: 8)))),
            Container(
              padding: EdgeInsets.fromLTRB(30, 0, 30, 15),
              alignment: getAlignment(),
              child: Text(
                state.errorText ?? '',
                style: TextStyle(
                  color: Theme.of(context).errorColor,
                  fontSize: 12,
                ),
              ),
            )
          ],
        );
      },
      validator: (value) {
        if (value! == false) {
          return AppLocalizations.of(context)!.agreeConditionsError;
        }
        return null;
      },
    );
  }

  TextFormField confirmPasswordField(BuildContext context) {
    return TextFormField(
      controller: confirmpasswordC,
      decoration: InputDecoration(
          hintText: AppLocalizations.of(context)!.confirmPassword,
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16.5,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          prefixIcon: Icon(Icons.lock),
          suffixIcon: IconButton(
            onPressed: _toggleVisibility,
            icon: _isHidden1
                ? Icon(Icons.visibility_off)
                : Icon(Icons.visibility),
          )),
      obscureText: _isHidden1,
      validator: (value) {
        if (value!.isEmpty) {
          return AppLocalizations.of(context)!.confirmPasswordError;
        }

        if (passwordC.text != confirmpasswordC.text) {
          return AppLocalizations.of(context)!.confirmPasswordError;
        }

        return null;
      },
      onSaved: (value) => confirmpasswordC.text = value!,
      textInputAction: TextInputAction.done,
    );
  }

  TextFormField passwordField(BuildContext context) {
    return TextFormField(
      controller: passwordC,
      decoration: InputDecoration(
          hintText: AppLocalizations.of(context)!.password,
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16.5,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          prefixIcon: Icon(Icons.lock),
          suffixIcon: IconButton(
            onPressed: _toggleVisibility,
            icon: _isHidden1
                ? Icon(Icons.visibility_off)
                : Icon(Icons.visibility),
          )),
      obscureText: _isHidden1,
      validator: (value) {
        if (value!.isEmpty) {
          return AppLocalizations.of(context)!.passwordError;
        }

        return null;
      },
      onSaved: (value) => passwordC.text = value!,
      textInputAction: TextInputAction.next,
    );
  }

  InkWell whichCity(BuildContext context) {
    return InkWell(
      onTap: () => bottomsheets(context),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(
                color: Theme.of(context).colorScheme.primary, width: 1)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              _SelectedItem == null
                  ? AppLocalizations.of(context)!.city
                  : _SelectedItem!,
              textAlign: TextAlign.right,
              style: GoogleFonts.cairo(fontSize: 20, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  TextFormField emailField(BuildContext context) {
    return TextFormField(
      controller: emailController,
      decoration: TextFieldHelper.getInputDecoration(
          AppLocalizations.of(context)!.email, Icons.email, false),
      validator: (value) {
        if (value!.isEmpty) {
          return AppLocalizations.of(context)!.emailError1;
        } else if (!RegExp(
                r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
            .hasMatch(value)) {
          return AppLocalizations.of(context)!.emailError2;
        }
        return null;
      },
      onSaved: (value) => emailController.text = value!,
      textInputAction: TextInputAction.next,
    );
  }

  TextFormField phoneNumberField(BuildContext context) {
    return TextFormField(
      controller: phoneNumberController,
      keyboardType: TextInputType.number,
      decoration: TextFieldHelper.getInputDecoration(
          AppLocalizations.of(context)!.phoneNumber, Icons.phone, false),
      validator: (value) {
        if (value!.isEmpty) {
          return AppLocalizations.of(context)!.phoneNumberError;
        }
        return null;
      },
      onSaved: (value) => phoneNumberController.text = value!,
      textInputAction: TextInputAction.next,
    );
  }

  TextFormField usernameField(BuildContext context) {
    return TextFormField(
      controller: usernameController,
      decoration: TextFieldHelper.getInputDecoration(
          AppLocalizations.of(context)!.userName, Icons.perm_identity, false),
      validator: (value) {
        if (value!.isEmpty) {
          return AppLocalizations.of(context)!.userNameErrorMessage;
        }
        return null;
      },
      onSaved: (value) => usernameController.text = value!,
      textInputAction: TextInputAction.next,
    );
  }

  AlignmentGeometry getAlignment() {
    if (Provider.of<LocaleProvider>(context).locale == Languages.codes[0]) {
      return Alignment.centerRight;
    }
    return Alignment.centerLeft;
  }

  Widget buildButtonContainer() {
    return Container(
        height: 56.0,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0), color: Colors.amber),
        child: MaterialButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              if (idCity != null) {
                signUp();
              } else {
                Fluttertoast.showToast(
                    msg: AppLocalizations.of(context)!.noCityError,
                    backgroundColor: Colors.grey[50],
                    textColor: Colors.black,
                    fontSize: 17.5);
              }
            }
          },
          child: Text(
            AppLocalizations.of(context)!.signUp,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            ),
          ),
        ));
  }

  void bottomsheets(context) async {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          if (Provider.of<CityProvider>(context).loading) {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primary,
              ),
            );
          } else {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: Provider.of<CityProvider>(context).cities.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.arrow_back_ios_rounded),
                    trailing: Text(
                      Provider.of<CityProvider>(context).getNames(
                          Provider.of<LocaleProvider>(context).locale)[index],
                      style: GoogleFonts.roboto(
                          color: Colors.yellow.shade700,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                    onTap: () => SelectItem(
                        Provider.of<CityProvider>(context, listen: false)
                            .cities[index]
                            .idCity,
                        Provider.of<CityProvider>(context, listen: false)
                            .getNames(Provider.of<LocaleProvider>(context,
                                    listen: false)
                                .locale)[index]),
                  );
                });
          }
        });
  }

  void SelectItem(int cityId, String cityName) {
    Navigator.pop(context);
    setState(() {
      _SelectedItem = cityName;
      idCity = cityId;
    });
  }

  // This is the resend confirmation method to be called before the actual sign up of a user and should be followed by the verification of the used email
  resendConfirmation() async {
    bool? result = await Provider.of<AuthProvider>(context, listen: false)
        .resendConfirmation(emailController.text);
    if (result != null && result) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => ConfirmMail(
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

  void signUp() async {
    User user = buildUser();

    bool result = await Provider.of<UserProvider>(context, listen: false)
        .signUpNewUser(user);

    if (result) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => ConfirmMail(
                    email: emailController.text,
                  )));
    } else {
      Fluttertoast.showToast(
          msg: AppLocalizations.of(context)!.failedSignUp,
          backgroundColor: Colors.grey[50],
          textColor: Colors.black,
          fontSize: 16);
    }
  }

  User buildUser() {
    String convertedDateTime =
        "${DateTime.now().year.toString()}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')} ${DateTime.now().hour.toString().padLeft(2, '0')}-${DateTime.now().minute.toString().padLeft(2, '0')}";
    User user = User(
        id: 0,
        fullname: usernameController.text,
        email: emailController.text,
        ps: passwordC.text,
        idRole: 3,
        img: "",
        tel: phoneNumberController.text,
        permissions: 0,
        idCity: idCity!,
        myDate: simplyFormat(time: DateTime.now()));
    return user;
  }

  Widget _buildPopupDialog(BuildContext context, content, content2) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: Column(
          children: [
            Text(content,
                maxLines: 100,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.justify,
                //textDirection: TextDirection.ltr,
                style: TextStyle(fontSize: 13.0)),
            Text(content2,
                maxLines: 100,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.justify,
                //textDirection: TextDirection.ltr,
                style: TextStyle(fontSize: 13.0)),
          ],
        ),
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
