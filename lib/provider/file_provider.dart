import 'package:flutter/cupertino.dart';

import '../models/core/file.dart';
import '../models/helper/file_helper.dart';

class FileProvider extends ChangeNotifier {
  final _helper = Filehelper();
  bool loading = false;
  List<File> _files = [];

  List<File> get files => _files;

  initializeFilesForStream(int idStream) async {
    loading = true;
    _files = (await _helper.getByIdStream(idStream))!;
    loading = false;
    notifyListeners();
  }

  initializeFilesForLesson(int idLesson) async {
    loading = true;
    _files = (await _helper.getByIdLesson(idLesson))!;
    loading = false;
    notifyListeners();
  }
}
