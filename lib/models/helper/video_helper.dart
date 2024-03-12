import 'dart:convert';

import '../core/video.dart';
import '../services/api_video_service.dart';

class VideoHelper {
  final _api = ApiVideoService();

  Future<List<Video>?> getByLessonId(int id) async {
    String? result = await _api.getIdLesson(id);
    if (result != null && result.isNotEmpty) {
      return List<Video>.from(
          json.decode(result).map((e) => Video.fromJson(e)));
    } else if (result == null) {
      // if null => a network error occurred
      return null;
    } else {
      // no videos are available
      return [];
    }
  }
}
