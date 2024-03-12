import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../assets_url.dart';
import '../models/core/user.dart';
import '../provider/user_provider.dart';
import 'custom_used_widgets/bottom_navigation_bar.dart.dart';

class AddMobile extends StatefulWidget {
  const AddMobile({Key? key, required this.currentIndex}) : super(key: key);
  final int currentIndex;

  @override
  _AddMobileState createState() => _AddMobileState();
}

class _AddMobileState extends State<AddMobile> {
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text(
            AppLocalizations.of(context)!.addPhoneNumber,
            style: TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.w400),
          ),
          centerTitle: true,
        ),
        body: ListView(
          shrinkWrap: true,
          children: [
            const SizedBox(
              height: 50,
            ),
            buildProfileImage(context),
            SizedBox(
              height: 30,
            ),
            buildPhoneNumberTextField(context),
            SizedBox(
              height: 30,
            ),
            buildButtonContainer()
          ],
        ),
        bottomNavigationBar: BottomNavigationBarApp(
          currentIndex: widget.currentIndex,
        ));
  }

  Padding buildPhoneNumberTextField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Center(child: Consumer<UserProvider>(
        builder: (context, provider, child) {
          return IntlPhoneField(
            // autovalidateMode: AutovalidateMode.disabled,
            controller: phoneController,
            decoration: InputDecoration(
              hintText: Provider.of<UserProvider>(context).user.tel == ""
                  ? AppLocalizations.of(context)!.phoneNumber
                  : provider.user.tel,
              border: OutlineInputBorder(
                borderSide: BorderSide(),
              ),
            ),
            initialCountryCode: 'SA',
            invalidNumberMessage:
                AppLocalizations.of(context)!.phoneNumberError,
            onSaved: (value) => phoneController.text = value!.number,
          );
        },
      )),
    );
  }

  Container buildProfileImage(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          // Provider.of<UserProvider>(context).user.img == null ||
          Provider.of<UserProvider>(context).user.img == ""
              ? CircleAvatar(
                  backgroundImage: NetworkImage(
                    "https://static.stayjapan.com/assets/user_no_photo-4896a2d64d70a002deec3046d0b6ea6e7f01628781493566c95a02361524af97.png",
                  ),
                  radius: 40,
                )
              : CircleAvatar(
                  backgroundImage: NetworkImage(AssetsUrl.users +
                      Provider.of<UserProvider>(context).user.img),
                  radius: 40,
                ),
          SizedBox(
            height: 5,
          ),
          Text(
            Provider.of<UserProvider>(context).user.fullname,
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w300,
              color: Colors.black,
            ),
          )
        ],
      ),
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
              addPhoneNumber();
            },
            child: Text(
              AppLocalizations.of(context)!.save,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
          )),
    );
  }

  void addPhoneNumber() async {
    if (phoneController.text.isNotEmpty) {
      User newUser = Provider.of<UserProvider>(context, listen: false).user
        ..setPhoneNumber(phoneController.text);

      bool result = await Provider.of<UserProvider>(context, listen: false)
          .update(newUser, context);

      checkResult(result);
    }
  }

  checkResult(bool result) {
    if (!result) {
      Fluttertoast.showToast(
          msg: AppLocalizations.of(context)!.failedOperation,
          backgroundColor: Theme.of(context).colorScheme.primary,
          fontSize: 16);
    } else {
      Fluttertoast.showToast(
          msg: AppLocalizations.of(context)!.updatedSuccess,
          backgroundColor: Theme.of(context).colorScheme.primary,
          fontSize: 16);
    }
  }
}
