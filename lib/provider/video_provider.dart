import 'package:flutter/cupertino.dart';

import '../models/core/video.dart';
import '../models/helper/video_helper.dart';

class VideoProvider extends ChangeNotifier {
  final _helper = VideoHelper();
  bool loading = false;
  List<Video> _videos = [];
  // int? _idLesson;

  initializeVideos(int idLesson) async {
    loading = true;

    _videos = (await _helper.getByLessonId(idLesson))!;

    loading = false;
    notifyListeners();
  }

  List<Video> get videos => _videos;

//   int? get idLesson {
//     return _idLesson;
//   }
//
//   void setIdLesson(int id) {
//     _idLesson = id;
//     print("current id lesson : $_idLesson");
//     notifyListeners();
//   }
}
