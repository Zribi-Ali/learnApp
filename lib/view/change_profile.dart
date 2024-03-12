import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../assets_url.dart';
import '../models/core/user.dart';
import '../models/services/api_links.dart';
import '../provider/city_provider.dart';
import '../provider/user_provider.dart';
import '../translation_utilities/languages_manager.dart';
import 'delete_user_success.dart';
import 'theme_helper/text_field_helper.dart';

//import 'package:image_picker/image_picker.dart';

class ChangeProfile extends StatefulWidget {
  const ChangeProfile({Key? key}) : super(key: key);

  @override
  _ChangeProfileState createState() => _ChangeProfileState();
}

class _ChangeProfileState extends State<ChangeProfile> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  int? idCity;

  // late User newUser;
  //
  // setNewUser() async {
  //   newUser = await Provider.of<UserProvider>(context)
  //       .getById(Provider.of<UserProvider>(context).user.id);
  //
  //   setState(() {});
  // }

  @override
  void initState() {
    super.initState();
    Provider.of<CityProvider>(context, listen: false).initializeCities();
  }

  //
  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   setNewUser();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            title: Text(
              AppLocalizations.of(context)!.modifyProfile,
              style: TextStyle(fontSize: 24),
            ),
            centerTitle: true),
        body: Consumer<UserProvider>(
            builder: (context, userProvider, child) => ListView(
                  shrinkWrap: true,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      child: buildUserImage(context),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: buildTextField(userProvider.user.fullname,
                          Icons.perm_identity, fullNameController),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(18.0, 2.0, 18.0, 4.0),
                      child: buildTextField(userProvider.user.email,
                          Icons.email, emailController),
                    ),
                    buildCityList(context),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(18.0, 16.0, 18.0, 4.0),
                      child: buildTextField(
                          userProvider.user.ps, Icons.lock, passwordController),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: buildButtonContainer(
                          text: AppLocalizations.of(context)!.save,
                          onPressed: () => updateUser(userProvider)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: buildButtonContainer(
                          text: AppLocalizations.of(context)!.deleteUser,
                          color: Colors.red.shade400,
                          onPressed: () => deleteUser(userProvider)),
                    ),
                  ],
                )));
  }

  Column buildUserImage(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            loading();
          },
          child: Center(
            child:
                // Provider.of<UserProvider>(context).user.img ==
                //             null ||
                Provider.of<UserProvider>(context).user.img == "" ||
                        Provider.of<UserProvider>(context).user.img == "no"
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
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Center(
          child: Text(
            Provider.of<UserProvider>(context).user.fullname,
            style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w400,
                fontSize: 23),
          ),
        )
      ],
    );
  }

  Padding buildCityList(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18.0, 16.0, 18.0, 4.0),
      child: InkWell(
        onTap: () => bottomsheets(context),
        child: Material(
            elevation: 8,
            borderRadius: BorderRadius.circular(20.0),
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black38),
                    borderRadius: BorderRadius.circular(20.0)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 16),
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.black38,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        cityController.text.isEmpty
                            ? Provider.of<CityProvider>(context).getcityName(
                                Provider.of<LocaleProvider>(context).locale)
                            : cityController.text,
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16.5,
                            fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                ))),

        //
        // Icons.location_on,
        // cityController),
      ),
    );
  }

  Widget buildTextField(
      String hintText, IconData icon, TextEditingController controller) {
    return Material(
      elevation: 8,
      borderRadius: BorderRadius.circular(20.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20.0)),
        child: TextField(
          controller: controller,
          decoration: TextFieldHelper.getInputDecoration(hintText, icon, true),
          onSubmitted: (value) => controller.text = value,
        ),
      ),
    );
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
                    onTap: () => selectItem(
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

  void selectItem(int cityId, String cityName) {
    Navigator.pop(context);
    setState(() {
      cityController.text = cityName;
      print(cityController.text);
      idCity = cityId;
    });
  }

  Widget buildButtonContainer(
      {Color? color, required Function() onPressed, required String text}) {
    return Container(
        height: 56.0,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(23.0),
            color: color ?? Colors.amber),
        child: MaterialButton(
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 19.0,
            ),
          ),
        ));
  }

  bool emptyControllers() {
    if (emailController.text.isEmpty &&
        fullNameController.text.isEmpty &&
        passwordController.text.isEmpty &&
        cityController.text.isEmpty) {
      Fluttertoast.showToast(
          msg: AppLocalizations.of(context)!.noModifications,
          backgroundColor: Theme.of(context).colorScheme.primary,
          fontSize: 16);
      return true;
    }
    return false;
  }

  void clearControllers() {
    fullNameController.clear();
    passwordController.clear();
    emailController.clear();
    cityController.clear();
  }

  checkResult(bool result) {
    clearControllers();
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
      // Navigator.pushReplacement(
      //     context, MaterialPageRoute(builder: (context) => ChangeProfile()));
    }
  }

  void updateUser(UserProvider userProvider) async {
    if (!emptyControllers()) {
      User newUser = userProvider.user
        ..update(fullNameController.text, passwordController.text,
            emailController.text, idCity);
      // print(Provider.of<UserProvider>(context, listen: false).user);

      bool result = await userProvider.update(newUser, context);

      checkResult(result);
    }
  }

  deleteUser(UserProvider userProvider) async {
    bool result = await userProvider.deleteUser();
    if (result) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => DeleteUserSuccess()));
    } else {
      Fluttertoast.showToast(
          msg: AppLocalizations.of(context)!.failedOperation,
          backgroundColor: Theme.of(context).colorScheme.primary,
          fontSize: 16);
    }
  }

  File? image;
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);

      setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future loading() async {
    pickImage();
    await Future.delayed(Duration(seconds: 4), () {
      updateuserd(image);
    });
  }

  Future<void> updateuserd(File? image) async {
    Dio dio = Dio();
    try {
      String filename = image!.path.split('/').last;
      FormData formData = FormData.fromMap({
        "Images": await MultipartFile.fromFile(image.path, filename: filename)
      });
      Response response = await dio.post(ApiLinks.mainUrl + "Users/Images?",
          data: formData,
          options: Options(
            headers: <String, String>{
              'authorization': ApiLinks.token,
              'Content-Type': 'application/json',
            },
          ));
      print(response);
    } catch (e) {
      print(e);
    }
  }
}
