import 'dart:convert';

import '../core/stream.dart';
import '../services/api_stream_service.dart';

class StreamHelper {
  final _api = ApiStreamService();

  Future<List<AppStream>?> get() async {
    var result = await _api.get();
    if (result != null) {
      return List<AppStream>.from(
          json.decode(result).map((e) => AppStream.fromJson(e)));
    } else {
      print("stream helper, get error occured");
      return null;
    }
  }

  Future<String?> UserHaveStream(int iduser, int idStream) async {
    var result = await _api.UserHaveStream(iduser, idStream);
    if (result != null) {
      return result;
    } else {
      print("stream helper, get error occured");
      return null;
    }
  }

  Future<AppStream?> getById(int id) async {
    var result = await _api.getById(id);
    if (result != null) {
      return AppStream.fromJson(json.decode(result)[0]);
    } else {
      print("stream helper, get by id error occured");
      return null;
    }
  }

  Future<List<AppStream>?> getStreamsForUserToday(int idUser) async {
    print("inside get streams for user today HELPER");
    var result = await _api.getStreamsForUserToday(idUser);
    if (result != null) {
      return List<AppStream>.from(
          json.decode(result).map((e) => AppStream.fromJson(e)));
    } else {
      print("stream helper, get stream for user today error occurred");
      return null;
    }
  }
}
