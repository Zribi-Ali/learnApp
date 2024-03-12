import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../assets_url.dart';
import '../../models/core/course_for_show_more.dart';
import '../../models/services/api_links.dart';
import '../../provider/unit_provider.dart';
import '../../provider/user_provider.dart';
import '../courses_manipulation/course_template.dart';

class CourseWidget extends StatelessWidget {
  final CourseForShowMore course;

  CourseWidget({
    Key? key,
    required this.course,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var ok = false;
    return Card(
      elevation: 6,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
            child: InkWell(
              onTap: () {
                Provider.of<UnitProvider>(context, listen: false)
                    .setIdCourse(course.idCourse);
                if (haveCourse(
                        Provider.of<UnitProvider>(context, listen: false)
                            .idCourse,
                        Provider.of<UserProvider>(context, listen: false)
                            .user
                            .id) ==
                    true) {
                  ok = true;
                }
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CourseTemplate(
                        title: course.titleCourse,
                        teacherName: course.teacherName,
                        image: AssetsUrl.coursesImages + course.img,
                        ok: ok)));
              },
              child: Container(
                height: 200.0,
                alignment: Alignment.bottomLeft,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  image: DecorationImage(
                    image: NetworkImage(AssetsUrl.coursesImages + course.img),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                width: MediaQuery.of(context).size.width,
                child: ListTile(
                  title: Text(
                    course.titleCourse,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w300,
                        fontSize: 20),
                  ),
                  subtitle: Text(course.description),
                )),
          ),
        ],
      ),
    );
  }
}

Future<bool> haveCourse(idCourse, idUser) async {
  print("idcourse= " + idCourse.toString() + " iduser= " + idUser.toString());

  var headers = {'Authorization': ApiLinks.token};
  var request = http.Request(
      'GET',
      Uri.parse(ApiLinks.coursesUrl +
          '/UserHaveCourse?idUser=$idUser&idCourse=$idCourse'));

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());

    if (response.stream.bytesToString() == 'true') {
      return true;
    } else {
      return false;
    }
  } else {
    print(response.reasonPhrase);
    return false;
  }
}
