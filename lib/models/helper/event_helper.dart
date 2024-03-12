import 'dart:convert';

import '../core/event.dart';
import '../services/api_event_service.dart';

class EventHelper {
  final _api = ApiEventService();

  Future<List<Event>?> get() async {
    var result = await _api.get();
    if (result != null) {
      return List<Event>.from(
          json.decode(result).map((e) => Event.fromJson(e)));
    } else {
      print("Event helper, get error occured");
      return [];
    }
  }

  Future<Event?> getById(int id) async {
    var result = await _api.getById(id);
    if (result != null) {
      return Event.fromJson(json.decode(result)[0]);
    } else {
      print("Event helper, get by id error occured");
      return null;
    }
  }
}
