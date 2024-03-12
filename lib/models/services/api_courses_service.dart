import 'package:http/http.dart' as http;

import 'api_links.dart';

class ApiCoursesService {
  final url = Uri.parse(ApiLinks.coursesUrl);

  Future<String?> get() async {
    try {
      http.Response response =
          await http.get(url, headers: {'Authorization': ApiLinks.token});
      if (response.statusCode == 200) {
        return response.body;
      }
      return null;
    } catch (e) {
      print("Courses Api, Error " + e.toString());
      return null;
    }
  }

  Future<String?> countCourses(int idLang) async {
    Uri countCoursesUrl =
        Uri.parse(ApiLinks.coursesUrl + "/CountCoursesAPP?idLang=$idLang");

    try {
      http.Response response = await http
          .get(countCoursesUrl, headers: {'Authorization': ApiLinks.token});
      if (response.statusCode == 200) {
        return response.body;
      }
      return null;
    } catch (e) {
      print("Courses Api get with count courses,The following error occurred " +
          e.toString());
      return null;
    }
  }

  Future<String?> showMore(int pageNumber, int idLang) async {
    print("$pageNumber  **** $idLang");
    Uri pagingUrl = Uri.parse(ApiLinks.coursesUrl +
        "/showMoreApp?Rech=null&pageNumber=$pageNumber&idLang=$idLang");

    try {
      http.Response response =
          await http.get(pagingUrl, headers: {'Authorization': ApiLinks.token});
      if (response.statusCode == 200) {
        return response.body;
      }
      print("error occurred the response is ${response.body}");
      return null;
    } catch (e) {
      print("Courses Api get with paging,The following error occurred " +
          e.toString());
      return null;
    }
  }

  Future<String?> getById(int id) async {
    final newUrl = ApiLinks.coursesUrl + "/$id";
    try {
      http.Response response = await http
          .get(Uri.parse(newUrl), headers: {'Authorization': ApiLinks.token});
      if (response.statusCode == 200) {
        return response.body;
      }
      return null;
    } catch (e) {
      print("Courses Api Get by id, The following error occurred " +
          e.toString());
      return null;
    }
  }
/*
  Future<bool> haveCourse(idCourse,idUser) async {
    final newUrl = ApiLinks.coursesUrl+'/UserHaveCourse?idUser=$idUser&idCourse=$idCourse';
    try {
      http.Response response = await http.get(Uri.parse(newUrl),
          headers: {
            'Authorization': ApiLinks.token
          }
      );
      if (response.statusCode == 200) {
        return response;
      }
      return null;
    } catch (e) {
      print("Courses Api Get by id, The following error occurred " +
          e.toString());
      return null;
    }
  } */

}
