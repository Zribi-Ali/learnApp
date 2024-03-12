import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'languages_manager.dart';


class LanguagePicker extends StatefulWidget {
  const LanguagePicker({ Key? key }) : super(key: key);

  @override
  State<LanguagePicker> createState() => _LanguagePickerState();
}

class _LanguagePickerState extends State<LanguagePicker> {
  @override
  Widget build(BuildContext context) {
   
     
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          leading: const BackButton(),
          centerTitle: true,
          title: Text(AppLocalizations.of(context)!.changeLanguage,style: TextStyle(color: Colors.white, fontSize: 24),),
        ),
        body: 
        ListView.separated(
          separatorBuilder: (BuildContext context, int index) => const Divider(thickness: 1,),
          itemCount: Languages.names.length,
          itemBuilder: (context,index) => ListTile(
            leading: TextButton(child : Text( Languages.names[index],style: TextStyle(fontSize: 18,color: Colors.black45),), onPressed: (){  
              Provider.of<LocaleProvider>(context, listen: false).setLocale(Languages.codes[index]);
              
            },),
          ),
        ),
      );
    }
}
