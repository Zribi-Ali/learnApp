// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../models/core/studentcourse2.dart';
import '../../models/core/unit.dart';
import '../../models/services/api_links.dart';
import '../../provider/unit_provider.dart';
import '../payment/payment1.dart';

class CourseTemplate extends StatefulWidget {
  final String title;
  final String image;
  final String teacherName;
  final bool ok;

  CourseTemplate(
      {Key? key,
      required this.title,
      required this.image,
      required this.teacherName,
      required this.ok})
      : super(key: key);

  @override
  State<CourseTemplate> createState() => _CourseTemplateState();
}

class _CourseTemplateState extends State<CourseTemplate> {
  @override
  void initState() {
    super.initState();
    Provider.of<UnitProvider>(context, listen: false).get();
  }

  @override
  Widget build(BuildContext context) {
    print("OKKK = " + widget.ok.toString());
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          elevation: 2,
          title: Text(
            widget.title,
            style: TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.w400),
          ),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            Container(
              height: 240.0,
              decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                  image: NetworkImage(widget.image),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            if (Provider.of<UnitProvider>(context).loading)
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height / 8),
                child: Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              )
            else if (Provider.of<UnitProvider>(context).emptyUnits)
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height / 9),
                child: Text(
                  AppLocalizations.of(context)!.noUnitsForCourse,
                  style: TextStyle(fontSize: 20, color: Colors.black87),
                  textAlign: TextAlign.center,
                ),
              )
            else
              for (Unit unit in Provider.of<UnitProvider>(context).units)
                UnitTile(
                  unit: unit,
                  teacherName: widget.teacherName,
                ),
            const SizedBox(
              height: 50,
            ),
            buildButtonContainer(context)
          ],
        ));
  }

  Widget buildButtonContainer(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18.0, 0, 18, 0),
      child: Container(
          height: 56.0,
          width: 90,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(23.0),
              color: Theme.of(context).colorScheme.primary),
          child: widget.ok == true
              ? MaterialButton(
                  onPressed: () {
                    /* Navigator.push(
                  context, MaterialPageRoute(builder: (context) => );*/
                  },
                  child: Text(
                    "Enter To Course",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                )
              : MaterialButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => payment1(
                                idCourse: Provider.of<UnitProvider>(context)
                                    .idCourse)));
                  },
                  child: Text(
                    AppLocalizations.of(context)!.participateCourse,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                )),
    );
  }
}

class UnitTile extends StatelessWidget {
  final Unit unit;
  final String teacherName;

  const UnitTile({
    required this.unit,
    required this.teacherName,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(unit.titleUnite),
          subtitle: Text(unit.descUnits),
          trailing: Text(teacherName,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 15)),
        ),
        Divider(),
      ],
    );
  }
}

Future<List<StudentCourse2>> getCourseByUser(id) async {
  var response = await http.get(
      Uri.parse(ApiLinks.coursesUrl + '/getCourseByUser?id=' + id),
      headers: {'Authorization': ApiLinks.token});
  if (response.statusCode == 200) {
    Map data = jsonDecode(response.body);
    dynamic user = data['response'];
    return user.map((json) => StudentCourse2.fromJson(json)).toList();
  } else {
    throw Exception("Something gone wrong, ${response.statusCode}");
  }
}
/*
bool haveCourse(idCourse,idUser){
  //bool ok = false;
  Future<List<StudentCourse2>> listCours = getCourseByUser(idUser);
  for(var i=0; i<listCours.;i++){
     if(listCours[i].idCourse == idCourse){
       return true;
     }
  }
  return false;
}
*/



