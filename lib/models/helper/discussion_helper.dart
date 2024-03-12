import 'dart:convert';

import '../core/discussion.dart';
import '../core/user.dart';
import '../services/api_discussion_service.dart';

class DiscussionHelper {
  final _api = ApiDiscussionService();

  Future<List<Discussion>?> get() async {
    var result = await _api.get();
    if (result != null) {
      return List<Discussion>.from(
          json.decode(result).map((e) => Discussion.fromJson(e)));
    } else {
      print("Discussion helper, get error occured");
      return null;
    }
  }

  Future<Discussion?> getById(int id) async {
    var result = await _api.getById(id);
    if (result != null) {
      return Discussion.fromJson(json.decode(result)[0]);
    } else {
      print("Discussion helper, get by id error occured");
      return null;
    }
  }

  // results can be of different form
  // list or Map<String,dynamic> or else depending on the status
  //handle error inside _helper
  //{
  //   "StatusMessage": "Error not Saved ",
  //    "StatusCode": -10000
  // }

  Future<Map<Discussion, User>?> geByUserId(int idUser) async {
    var apiResult = await _api.getByIdUser(idUser);

    if (apiResult != null) {
      var jsonResult = json.decode(apiResult);
      if (jsonResult is Iterable<dynamic>) {
        return mapUsersAndDiscussions(jsonResult);
      } else {
        print("result type is ${jsonResult.runtimeType}");
        return null;
      }
    } else {
      print("Discussion helper, get by id user empty result");
      return null;
    }
  }

  Map<Discussion, User> mapUsersAndDiscussions(jsonResult) {
    Map<Discussion, User> map = Map<Discussion, User>();

    for (var item in jsonResult) {
      Discussion newDiscussion = Discussion.fromJson(item);
      User newUser = User.fromJsonDiscussion(item);
      map[newDiscussion] = newUser;
    }
    return map;
  }
}
