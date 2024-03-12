import 'package:flutter/cupertino.dart';

import '../models/core/comment.dart';
import '../models/helper/comment_helper.dart';

class CommentProvider extends ChangeNotifier {
  final _helper = CommentHelper();

  bool loading = false;

  List<Comment> _comments = [];
  var test;
  Future<void> initializeComments() async {
    loading = true;
    _comments = (await _helper.get())!;
    loading = false;
    notifyListeners();
  }

  List<Comment> get getAllComments => _comments;

  List<Comment> getCommentsByParentId({int? idParent = 0}) {
    int id = idParent ?? 0;
    return _comments.where((e) => e.idCommentParent == id).toList();
  }

  List<Comment> getByIdStream(int idStream) {
    _filterByStream(idStream);
    return _comments;
  }

  _filterByStream(int idStream) => _comments =
      _comments.where((element) => element.idStream == idStream).toList();

  Future<bool> postComment(Comment comment) => _helper.post(comment);

  addLocally(Comment comment) {
    _comments.add(comment);
    notifyListeners();
  }

  /////////////////////// Comment View State Management //////////////////////////////////////
  bool _isParent = true;
  Comment? _currentCommentParent;

  setIsParentState(bool state) {
    print("inside set is parent");
    _isParent = state;
    notifyListeners();
  }

  bool get isParent => _isParent;

  setCurrentCommentParent(Comment comment) {
    _currentCommentParent = comment;
    notifyListeners;
  }

  Comment? get currentCommentParent => _currentCommentParent;
}
