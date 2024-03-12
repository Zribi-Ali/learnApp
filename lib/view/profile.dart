import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../assets_url.dart';
import '../provider/city_provider.dart';
import '../provider/user_provider.dart';
import '../translation_utilities/language_picker.dart';
import '../translation_utilities/languages_manager.dart';
import 'Contact.dart';
import 'Events.dart';
import 'Location.dart';
import 'Questions.dart';
import 'Rules.dart';
import 'add_mobile.dart';
import 'change_profile.dart';
import 'custom_used_widgets/bottom_navigation_bar.dart.dart';
import 'custom_used_widgets/profile_option_tile.dart';
import 'log_in.dart';
import 'payment/Records.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int myPageIndex = 2;

  bool _isSelected = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<OptionTile> _optionTileList = [
      OptionTile(
          option: AppLocalizations.of(context)!.terms, direction: Rules()),
      OptionTile(
          option: AppLocalizations.of(context)!.askedQuestions,
          direction: Questions()),
      OptionTile(
          option: AppLocalizations.of(context)!.writeUs,
          direction: Contact(
            bottomNavigationBarIndex: myPageIndex,
          )),
      OptionTile(
          option: AppLocalizations.of(context)!.events,
          direction: Events(
            currentIndex: myPageIndex,
          )),
      OptionTile(
          option: AppLocalizations.of(context)!.addPhoneNumber,
          direction: AddMobile(
            currentIndex: myPageIndex,
          )),
      OptionTile(
          option: AppLocalizations.of(context)!.payment, direction: Records()),
      OptionTile(
          option: AppLocalizations.of(context)!.exit,
          direction: LoginPage(),
          textColor: Colors.red),
    ];

    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 90,
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text(
            AppLocalizations.of(context)!.profile,
            style: TextStyle(fontSize: 29),
          ),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50.0),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Location()));
                      },
                      child: Text(
                        Provider.of<CityProvider>(context).getcityName(
                            Provider.of<LocaleProvider>(context).locale),
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      )),
                  Icon(Icons.location_on),
                  Spacer(),
                  Column(
                    children: [
                      Text(Provider.of<UserProvider>(context).user.fullname,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w300)),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        AppLocalizations.of(context)!.registrationDate,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                      Text(
                        Provider.of<UserProvider>(context).user.myDate,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Provider.of<UserProvider>(context).user.img == "" ||
                          Provider.of<UserProvider>(context).user.img == "no"
                      ? CircleAvatar(
                          backgroundImage: NetworkImage(
                            "https://static.stayjapan.com/assets/user_no_photo-4896a2d64d70a002deec3046d0b6ea6e7f01628781493566c95a02361524af97.png",
                          ),
                          radius: 30,
                        )
                      : CircleAvatar(
                          backgroundImage: NetworkImage(AssetsUrl.users +
                              Provider.of<UserProvider>(context).user.img),
                          radius: 30,
                        ),
                ],
              ),
            ),
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Card(
                semanticContainer: true,
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: Column(
                  children: [
                    OptionTile(
                        option: AppLocalizations.of(context)!.modifyProfile,
                        direction: ChangeProfile()),
                    OptionTile(
                        option: AppLocalizations.of(context)!.changeLanguage,
                        direction: LanguagePicker()),
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                            bottom:
                                BorderSide(width: 2, color: Colors.black12)),
                      ),
                      child: SwitchListTile(
                        activeColor: Colors.amber,
                        title: Text(
                          AppLocalizations.of(context)!.activateNotifications,
                          style: TextStyle(fontSize: 20),
                        ),
                        value: _isSelected,
                        onChanged: (bool newValue) {
                          setState(() {
                            _isSelected = newValue;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Card(
                semanticContainer: true,
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: Column(
                  children: _optionTileList
                      .map((optionTile) => OptionTile(
                            option: optionTile.option,
                            direction: optionTile.direction,
                            textColor: optionTile.textColor,
                          ))
                      .toList(),
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBarApp(
        currentIndex: myPageIndex,
      ),
    );
  }
}
