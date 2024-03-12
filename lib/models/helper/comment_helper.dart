import 'dart:convert';

import '../core/comment.dart';
import '../services/api_comment_service.dart';

class CommentHelper {
  final _api = ApiCommentService();

  Future<List<Comment>?> get() async {
    var result = await _api.get();
    if (result != null) {
      return List<Comment>.from(
          json.decode(result).map((e) => Comment.fromJson(e)));
    } else {
      print("Comment helper, get error occured");
      return [];
    }
  }

  Future<Comment?> getById(int id) async {
    var result = await _api.getById(id);
    if (result != null) {
      return Comment.fromJson(json.decode(result)[0]);
    } else {
      print("Comment helper, get by id error occured");
      return null;
    }
  }

  Future<bool> post(Comment comment) async {
    print("inside helper");
    return _api.post(json.encode(comment.toJson()));
  }
}
