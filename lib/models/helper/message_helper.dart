import 'dart:convert';

import '../core/message.dart';
import '../services/api_message_service.dart';

class MessageHelper {
  final _api = ApiMessageService();

  Future<List<Message>?> get() async {
    var result = await _api.get();
    if (result != null) {
      return List<Message>.from(
          json.decode(result).map((e) => Message.fromJson(e)));
    } else {
      print("message helper, get error occured");
      return null;
    }
  }

  Future<Message?> getById(int id) async {
    var result = await _api.getById(id);
    if (result != null) {
      return Message.fromJson(json.decode(result)[0]);
    } else {
      print("message helper, get by id error occured");
      return null;
    }
  }

  Future<List<Message>?> getByIdDiscussion(int id) async {
    var result = await _api.getByDiscussionId(id);
    if (result != null) {
      var jsonResult = json.decode(result);
      if (jsonResult == "Empty") {
        return [];
      } else {
        return List.from(jsonResult.map((e) => Message.fromJson(e)));
      }
    } else {
      print("message helper, get by id discussion error occured");
      return null;
    }
  }

  Future<bool> post(Message message) async =>
      _api.post(json.encode(message.toJson()));
}
